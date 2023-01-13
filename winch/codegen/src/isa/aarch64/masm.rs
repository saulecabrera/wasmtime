use cranelift_codegen::{
    MachBufferFinalized, Final,
    settings, MachBuffer, MachInstEmit, Writable,
    isa::aarch64::{
	settings as aaarch64_settings,
	inst::Inst,
    },
};

use crate::{
    abi::{addressing_mode::Address, local::LocalSlot},
    isa::reg::Reg,
    masm::{MacroAssembler as Masm, OperandSize, RegImm},
};

#[derive(Default)]
pub(crate) struct MacroAssembler;

impl Masm for MacroAssembler {
    fn prologue(&mut self) {
    }

    fn epilogue(&mut self, _locals_size: u32) {
    }

    fn reserve_stack(&mut self, _bytes: u32) {
    }

    fn local_address(&mut self, _local: &LocalSlot) -> Address {
    }

    fn store(&mut self, _src: RegImm, _dst: Address, _size: OperandSize) {
    }

    fn load(&mut self, _src: Address, _dst: Reg, _size: OperandSize) {}

    fn sp_offset(&mut self) -> u32 {
        0u32
    }

    fn finalize(self) -> MachBufferFinalized<Final> {
    }

    fn mov(&mut self, _src: RegImm, _dst: RegImm, _size: OperandSize) {
    }

    fn add(&mut self, _dst: RegImm, __lhs: RegImm, __rhs: RegImm, _size: OperandSize) {
    }

    fn zero(&mut self, _reg: Reg) {
    }

    fn push(&mut self, _reg: Reg) -> u32 {
    }
}


struct Assembler {
}
