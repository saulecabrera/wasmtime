use super::regs::scratch;
use crate::{
    codegen::{CodeGenContext, Emission},
    masm::{MacroAssembler, OperandSize, RegImm, Imm},
    operands::{BinopType, Operands},
    reg::{writable, Reg},
    stack::Val,
};
use anyhow::Result;
use wasmparser::Operator;

pub(crate) struct X64Operands;

impl Operands for X64Operands {
    fn binop<T: BinopType, M: MacroAssembler>(
        &self,
        op: Operator,
        context: &mut CodeGenContext<Emission>,
        masm: &mut M,
    ) -> Result<(RegImm, Reg, OperandSize)> {
	let v0 = context.stack.peek().expect("Value at stack top");

	let supports_inline_imm = matches!(op, Operator::I64Add | Operator::I64Sub | Operator::I64Mul | Operator::I32Add | Operator::I32Sub | Operator::I32Mul);

	if supports_inline_imm && v0.is_const() {
	    let imm = match v0 {
		Val::I32(_) => context.pop_i32_const().unwrap() as u64,
		Val::I64(_) => context.pop_i64_const().unwrap() as u64,
		_ => unreachable!()
	    };

	    let v1 = context.pop_to_reg(masm, None)?;

	    return match i32::try_from(imm) {
		Ok(v32) => Ok((RegImm::i32(v32), v1.reg, T::operand_size())),
		Err(_) => {
		    // TODO: acquire!
		    masm.load_constant(writable!(scratch()), Imm::i64(imm as i64), T::operand_size())?;
		    Ok((RegImm::reg(scratch()), v1.reg, T::operand_size()))
		}
	    }
	}
	let v0 = context.pop_to_reg(masm, None)?;
	let v1 = context.pop_to_reg(masm, None)?;

	Ok((RegImm::reg(v0.reg), v1.reg, T::operand_size()))
    }
}
