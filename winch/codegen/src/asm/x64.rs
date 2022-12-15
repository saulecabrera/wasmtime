//! Assembler library implementation for x64.

use crate::abi::addressing_mode::Address;
use crate::isa::{reg::Reg, x64::regs::reg_name};
use cranelift_codegen::{
    isa::x64::{
        args::{
            Amode, FromWritableReg, Gpr, GprMemImm, OperandSize, RegMemImm, SyntheticAmode,
            WritableGpr, AluRmiROpcode, ExtMode, RegMem, GprMem
        },
        settings as x64_settings, EmitInfo, EmitState, Inst,
    },
    settings, MachBuffer, MachInstEmit, Writable, MachBufferFinalized, Final
};

/// A x64 instruction operand.
#[derive(Debug, Copy, Clone)]
pub(crate) enum Operand {
    Reg(Reg),
    Mem(Address),
    Imm(i32),
}

/// x64 Assembler.

/// All instructions defined by the assembler denote a 64 bit size,
/// unless otherwise specified by the corresponding function name
/// suffix.
pub(crate) struct Assembler {
    buffer: MachBuffer<Inst>,
    emit_info: EmitInfo,
    emit_state: EmitState,
    disasm: String,
}

impl Default for Assembler {
    fn default() -> Self {
        let shared_flags = settings::Flags::new(settings::builder());
        let isa_flag_builder = x64_settings::builder();
        let isa_flags = x64_settings::Flags::new(&shared_flags, isa_flag_builder);
        Self {
            buffer: MachBuffer::<Inst>::new(),
            emit_state: Default::default(),
            emit_info: EmitInfo::new(shared_flags, isa_flags),
            disasm: String::new(),
        }
    }
}

impl Assembler {
    fn emit(&mut self, inst: Inst) {
        use core::fmt::Write;

        writeln!(
            &mut self.disasm,
            "  {}",
            inst.pretty_print_inst(&[], &mut self.emit_state)
        )
        .unwrap();
        inst.emit(&[], &mut self.buffer, &self.emit_info, &mut self.emit_state);
    }

    pub fn push_r(&mut self, reg: Reg) {
        let src = GprMemImm::new(reg.into()).expect("valid register argument");
        self.emit(Inst::Push64 { src });
    }

    pub fn pop_r(&mut self, reg: Reg) {
        let dst = WritableGpr::from_writable_reg(Writable::from_reg(reg.into()))
            .expect("valid writable reg");
        self.emit(Inst::Pop64 { dst });
    }

    pub fn ret(&mut self) {
        self.emit(Inst::Ret { rets: vec![] });
    }

    pub fn mov(&mut self, src: Operand, dst: Operand) {
        // r, r
        // r, m (displacement)
        // r, m (displace,ent, index)
        // i, r
        // i, m (displacement)
        // i, m (displacement, index)
        // load combinations
        match &(src, dst) {
            (Operand::Reg(lhs), Operand::Reg(rhs)) => self.mov_rr(*lhs, *rhs),
            (Operand::Reg(r), Operand::Mem(addr)) => match addr {
                Address::Base { base, imm } => self.mov_rm(*r, *base, *imm),
            },

            // All immediates are assumed to be 32 bit ints, for now.
            // so we are delegating it to movl.
            (Operand::Imm(r), Operand::Mem(addr)) => match addr {
                Address::Base { base, imm } => self.mov_im(*r, *base, *imm),
            },

            (Operand::Imm(imm), Operand::Reg(reg)) => self.movl_ir(*imm, *reg),
            (Operand::Mem(addr), Operand::Reg(reg)) => match addr {
                Address::Base { base, imm } => self.mov_mr(*base, *imm, *reg),
            },
            _ => panic!(
                "Invalid operand combination for mov; src = {:?}; dst = {:?}",
                src, dst
            ),
        }
    }

    pub fn mov_rr(&mut self, src: Reg, dst: Reg) {
        let src = Gpr::new(src.into()).expect("valid gpr");
        let dst = WritableGpr::from_writable_reg(Writable::from_reg(dst.into()))
            .expect("valid writable gpr");

        self.emit(Inst::MovRR {
            src,
            dst,
            size: OperandSize::Size64,
        });
    }

    pub fn mov_im(&mut self, src: i32, base: Reg, disp: u32) {
	let dst = Amode::imm_reg(disp, base.into());
	self.emit(Inst::MovIM {
	    size: OperandSize::Size64,
	    simm64: src as u64,
	    dst: SyntheticAmode::real(dst),
	});
    }

    pub fn mov_rm(&mut self, src: Reg, base: Reg, disp: u32) {
        let src = Gpr::new(src.into()).expect("valid gpr");
        let dst = Amode::imm_reg(disp, base.into());

        self.emit(Inst::MovRM {
            size: OperandSize::Size64,
            src,
            dst: SyntheticAmode::real(dst),
        });
    }

    pub fn mov_mr(&mut self, base: Reg, disp: u32, dst: Reg) {
        let dst = WritableGpr::from_writable_reg(Writable::from_reg(dst.into()))
            .expect("valid writable gpr");
        let src = Amode::imm_reg(disp, base.into());

        self.emit(Inst::Mov64MR {
            src: SyntheticAmode::real(src),
            dst,
        });
    }

    pub fn movl(&mut self, src: Operand, dst: Operand) {
        // r, r
        // r, m (displacement)
        // r, m (displace,ent, index)
        // i, r
        // i, m (displacement)
        // i, m (displacement, index)
        // load combinations
        match &(src, dst) {
            (Operand::Reg(lhs), Operand::Reg(rhs)) => self.movl_rr(*lhs, *rhs),

            (Operand::Imm(r), Operand::Mem(addr)) => match addr {
                Address::Base { base, imm } => self.movl_im(*r, *base, *imm),
            },
            (Operand::Reg(r), Operand::Mem(addr)) => match addr {
                Address::Base { base, imm } => self.movl_rm(*r, *base, *imm),
            },
            (Operand::Imm(imm), Operand::Reg(reg)) => self.movl_ir(*imm, *reg),
            (Operand::Mem(addr), Operand::Reg(reg)) => match addr {
                Address::Base { base, imm } => self.movl_mr(*base, *imm, *reg),
            },

            _ => panic!(
                "Invalid operand combination for movl; src = {:?}; dst = {:?}",
                src, dst
            ),
        }
    }

    pub fn movl_rr(&mut self, src: Reg, dst: Reg) {
        let src = Gpr::new(src.into()).expect("valid gpr");
        let dst = WritableGpr::from_writable_reg(Writable::from_reg(dst.into()))
            .expect("valid writable gpr");

        self.emit(Inst::MovRR {
            src,
            dst,
            size: OperandSize::Size32,
        });
    }

    pub fn movl_rm(&mut self, src: Reg, base: Reg, disp: u32) {
        let src = Gpr::new(src.into()).expect("valid gpr");
        let dst = Amode::imm_reg(disp, base.into());

        self.emit(Inst::MovRM {
            size: OperandSize::Size32,
            src,
            dst: SyntheticAmode::real(dst),
        });
    }

    pub fn movl_ir(&mut self, imm: i32, dst: Reg) {
        let dst = WritableGpr::from_writable_reg(Writable::from_reg(dst.into()))
            .expect("valid writable gpr");

        self.emit(Inst::Imm {
            dst_size: OperandSize::Size32,
            simm64: imm as u64,
            dst,
        });
    }

    pub fn movl_im(&mut self, src: i32, base: Reg, disp: u32) {
	let dst = Amode::imm_reg(disp, base.into());
	self.emit(Inst::MovIM {
	    size: OperandSize::Size32,
	    simm64: src as u64,
	    dst: SyntheticAmode::real(dst),
	});
    }

    pub fn movl_mr(&mut self, base: Reg, disp: u32, dst: Reg) {
        let dst = WritableGpr::from_writable_reg(Writable::from_reg(dst.into()))
            .expect("valid writable gpr");
        let src = Amode::imm_reg(disp, base.into());
	let src = RegMem::mem(SyntheticAmode::real(src));

	self.emit(Inst::MovzxRmR {
	    ext_mode: ExtMode::LQ,
	    src: GprMem::new(src).expect("valid gpr or memory"),
	    dst,
	});
    }

    pub fn sub_ir(&mut self, imm: u32, dst: Reg) {
	let writable = WritableGpr::from_writable_reg(Writable::from_reg(dst.into()))
	    .expect("valid writable gpr");
	let src = Gpr::new(dst.into())
	    .expect("valid gpr");

	let imm = RegMemImm::imm(imm);

	self.emit(Inst::AluRmiR {
	    size: OperandSize::Size64,
	    op: AluRmiROpcode::Sub,
	    src1: src,
	    src2: GprMemImm::new(imm).expect("valid gpr mem or immediate"),
	    dst: writable,
	});
    }

    pub fn add(&mut self, src: Operand, dst: Operand) {
	match &(src, dst) {
	    (Operand::Imm(imm), Operand::Reg(dst)) => self.add_ir(*imm, *dst),
	    (Operand::Reg(src), Operand::Reg(dst)) => self.add_rr(*src, *dst),
	    _ => panic!(
		"Invalid operand combination for add; src = {:?} dst = {:?}",
		src, dst
	    ),
	}
    }

    pub fn add_ir(&mut self, imm: i32, dst: Reg) {
	let writable = WritableGpr::from_writable_reg(Writable::from_reg(dst.into()))
	    .expect("valid writable gpr");
	let src = Gpr::new(dst.into())
	    .expect("valid gpr");

	let imm = RegMemImm::imm(imm as u32);

	self.emit(Inst::AluRmiR {
	    size: OperandSize::Size64,
	    op: AluRmiROpcode::Add,
	    src1: src,
	    src2: GprMemImm::new(imm).expect("valid gpr mem or immediate"),
	    dst: writable,
	});
    }

    pub fn add_rr(&mut self, src: Reg, dst: Reg) {
	let dest = WritableGpr::from_writable_reg(Writable::from_reg(dst.into()))
	    .expect("valid writable gpr");
	let src1 = Gpr::new(dst.into())
	    .expect("valid gpr");

	let src2 = RegMemImm::reg(src.into());

	self.emit(Inst::AluRmiR {
	    size: OperandSize::Size64,
	    op: AluRmiROpcode::Add,
	    src1,
	    src2: GprMemImm::new(src2).expect("valid gpr mem or immediate"),
	    dst: dest,
	});

    }

    pub fn addl(&mut self, src: Operand, dst: Operand) {
	match &(src, dst) {
	    (Operand::Imm(imm), Operand::Reg(dst)) => self.addl_ir(*imm, *dst),
	    (Operand::Reg(src), Operand::Reg(dst)) => self.addl_rr(*src, *dst),
	    _ => panic!(
		"Invalid operand combination for add; src = {:?} dst = {:?}",
		src, dst
	    ),
	}
    }

    pub fn addl_ir(&mut self, imm: i32, dst: Reg) {
	let writable = WritableGpr::from_writable_reg(Writable::from_reg(dst.into()))
	    .expect("valid writable gpr");
	let src = Gpr::new(dst.into())
	    .expect("valid gpr");

	let imm = RegMemImm::imm(imm as u32);

	self.emit(Inst::AluRmiR {
	    size: OperandSize::Size32,
	    op: AluRmiROpcode::Add,
	    src1: src,
	    src2: GprMemImm::new(imm).expect("valid gpr mem or immediate"),
	    dst: writable,
	});
    }

    pub fn addl_rr(&mut self, src: Reg, dst: Reg) {
	let dest = WritableGpr::from_writable_reg(Writable::from_reg(dst.into()))
	    .expect("valid writable gpr");
	let src1 = Gpr::new(dst.into())
	    .expect("valid gpr");

	let src2 = RegMemImm::reg(src.into());

	self.emit(Inst::AluRmiR {
	    size: OperandSize::Size32,
	    op: AluRmiROpcode::Add,
	    src1,
	    src2: GprMemImm::new(src2).expect("valid gpr mem or immediate"),
	    dst: dest,
	});
    }

    pub fn xorl_rr(&mut self, src: Reg, dst: Reg) {
	let dest = WritableGpr::from_writable_reg(Writable::from_reg(dst.into()))
	    .expect("valid writable gpr");
	let src1 = Gpr::new(dst.into())
	    .expect("valid gpr");

	let src2 = RegMemImm::reg(src.into());

	self.emit(Inst::AluRmiR {
	    size: OperandSize::Size32,
	    op: AluRmiROpcode::Xor,
	    src1,
	    src2: GprMemImm::new(src2).expect("valid gpr mem or immediate"),
	    dst: dest,
	});
    }

    /// Return the emitted code.
    pub fn finalize(self) -> MachBufferFinalized<Final> {
	let stencil = self.buffer.finish();
	stencil.apply_base_srcloc(Default::default())
    }
}

impl From<Reg> for RegMemImm {
    fn from(r: Reg) -> RegMemImm {
        RegMemImm::reg(r.into())
    }
}
