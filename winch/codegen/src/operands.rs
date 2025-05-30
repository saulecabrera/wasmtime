//! ISA-specific handling of insruction operands.

use crate::{
    codegen::{CodeGenContext, Emission},
    masm::{MacroAssembler, OperandSize, RegImm},
    reg::Reg,
};
use anyhow::Result;
use wasmparser::Operator;

pub struct I32xI32;
pub struct I64xI64;

pub(crate) trait BinopType {
    fn operand_size() -> OperandSize;
}

impl BinopType for I32xI32 {
    fn operand_size() -> OperandSize {
        OperandSize::S32
    }
}

impl BinopType for I64xI64 {
    fn operand_size() -> OperandSize {
        OperandSize::S64
    }
}

pub(crate) trait Operands {
    fn binop<T: BinopType, M: MacroAssembler>(
        &self,
        op: Operator,
        context: &mut CodeGenContext<Emission>,
        masm: &mut M,
    ) -> Result<(RegImm, Reg, OperandSize)>;
}
