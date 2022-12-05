use cranelift_codegen::{MachBufferFinalized, Final};

use super::regs::{rbp, rsp};
use crate::abi::addressing_mode::Address;
use crate::abi::local::LocalSlot;
use crate::isa::reg::Reg;
use crate::masm::{MacroAssembler as Masm, OperandSize, RegImm};
use crate::asm::x64::{Operand, Assembler};

#[derive(Default)]
pub(crate) struct MacroAssembler {
    sp_offset: u32,
    asm: Assembler,
}

impl Masm for MacroAssembler {
    fn prologue(&mut self) {
        let frame_pointer = rbp();
        let stack_pointer = rsp();

        self.asm.push_r(frame_pointer);
        self.asm.mov_rr(stack_pointer, frame_pointer);
    }

    fn push(&mut self, reg: Reg) -> u32 {
        self.asm.push_r(reg);
        // In x64 the push instruction takes either
        // 2 or 8 bytes; in our case we're always
        // assuming 8 bytes per push.
        self.increment_sp(8);

        self.sp_offset
    }

    fn reserve_stack(&mut self, bytes: u32) {
        if bytes == 0 {
            return;
        }

        self.asm.sub_ir(bytes, rsp());
        self.increment_sp(bytes);
    }

    fn local_address(&mut self, local: &LocalSlot) -> Address {
        let (reg, offset) = local
            .addressed_from_sp()
            .then(|| {
                let offset = self.sp_offset.checked_sub(local.offset).expect(&format!(
                    "Invalid local offset = {}; sp offset = {}",
                    local.offset, self.sp_offset
                ));
                (rsp(), offset)
            })
            .unwrap_or((rbp(), local.offset));

        Address::base(reg, offset)
    }

    fn store(&mut self, src: RegImm, dst: Address, size: OperandSize) {
        let src: Operand = src.into();
        let dst: Operand = dst.into();

        match size {
            OperandSize::S32 => {
                self.asm.movl(src, dst);
            }
            OperandSize::S64 => {
                self.asm.mov(src, dst);
            }
        }
    }

    fn load(&mut self, src: Address, dst: Reg, size: OperandSize) {
        let src = src.into();
        let dst = dst.into();

        match size {
            OperandSize::S32 => self.asm.movl(src, dst),
            OperandSize::S64 => self.asm.mov(src, dst),
        }
    }

    fn sp_offset(&mut self) -> u32 {
        self.sp_offset
    }

    fn zero(&mut self, reg: Reg) {
        self.asm.xorl_rr(reg, reg);
    }

    fn mov(&mut self, src: RegImm, dst: RegImm, size: OperandSize) {
        let src: Operand = src.into();
        let dst: Operand = dst.into();

        match size {
            OperandSize::S32 => {
                self.asm.movl(src, dst);
            }
            OperandSize::S64 => {
                self.asm.mov(src, dst);
            }
        }
    }

    fn add(&mut self, dst: RegImm, lhs: RegImm, rhs: RegImm, size: OperandSize) {
        let (src, dst): (Operand, Operand) = if dst == lhs {
            (rhs.into(), dst.into())
        } else {
            panic!(
                "the destination and first source argument must be the same, dst={:?}, lhs={:?}",
                dst, lhs
            );
        };

        match size {
            OperandSize::S32 => {
                self.asm.addl(src, dst);
            }
            OperandSize::S64 => {
                self.asm.add(src, dst);
            }
        }
    }

    fn epilogue(&mut self, locals_size: u32) {
        let rsp = rsp();
        if locals_size > 0 {
            self.asm.add_ir(locals_size as i32, rsp);
        }
        self.asm.pop_r(rbp());
        self.asm.ret();
    }

    fn finalize(self) -> MachBufferFinalized<Final> {
        self.asm.finalize()
    }
}

impl MacroAssembler {
    /// Crate a x64 MacroAssembler
    pub fn new() -> Self {
        Self {
            sp_offset: 0,
            asm: Default::default(),
        }
    }

    fn increment_sp(&mut self, bytes: u32) {
        self.sp_offset += bytes;
    }

    #[allow(dead_code)]
    fn decrement_sp(&mut self, bytes: u32) {
        assert!(
            self.sp_offset >= bytes,
            "sp offset = {}; bytes = {}",
            self.sp_offset,
            bytes
        );
        self.sp_offset -= bytes;
    }
}

impl From<RegImm> for Operand {
    fn from(rimm: RegImm) -> Self {
        match rimm {
            RegImm::Reg(r) => r.into(),
            RegImm::Imm(imm) => Operand::Imm(imm),
        }
    }
}

impl From<Reg> for Operand {
    fn from(reg: Reg) -> Self {
        Operand::Reg(reg)
    }
}

impl From<Address> for Operand {
    fn from(addr: Address) -> Self {
        Operand::Mem(addr)
    }
}
