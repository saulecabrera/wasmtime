use crate::isa::{aarch64::masm::MacroAssembler, TargetIsa};
use crate::stack::Stack;
use crate::frame::Frame;
use crate::regalloc::RegAlloc;
use crate::codegen::{CodeGenContext, CodeGen};
use anyhow::Result;
use cranelift_codegen::{MachBufferFinalized, Final};
use target_lexicon::Triple;
use wasmparser::{FuncType, FuncValidator, FunctionBody, ValidatorResources};

use self::regs::ALL_GPR;

mod abi;
mod masm;
mod regs;

/// Create an ISA from the given triple.
pub(crate) fn isa_from(triple: Triple) -> Aarch64 {
    Aarch64::new(triple)
}

pub(crate) struct Aarch64 {
    triple: Triple,
}

impl Aarch64 {
    pub fn new(triple: Triple) -> Self {
        Self { triple }
    }
}

impl TargetIsa for Aarch64 {
    fn name(&self) -> &'static str {
        "aarch64"
    }

    fn triple(&self) -> &Triple {
        &self.triple
    }

    fn compile_function(
        &self,
        _sig: &FuncType,
        _body: &FunctionBody,
        mut _validator: FuncValidator<ValidatorResources>,
    ) -> Result<MachBufferFinalized<Final>> {
        let mut body = body.get_binary_reader();
        let masm = MacroAssembler::new();
        let stack = Stack::new();
        let abi = abi::Aarch64ABI::default();
        let abi_sig = abi.sig(sig);
        let frame = Frame::new(&abi_sig, &mut body, &mut validator, &abi)?;
        // TODO Add in floating point bitmask
        let regalloc = RegAlloc::new(RegSet::new(ALL_GPR, 0), regs::scratch());
        let codegen_context = CodeGenContext::new(masm, stack, &frame);
        let mut codegen = CodeGen::new::<abi::Aarch64ABI>(codegen_context, abi_sig, regalloc);

        codegen.emit(&mut body, validator)
    }
}
