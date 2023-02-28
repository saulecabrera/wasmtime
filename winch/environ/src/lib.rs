//! This crate implements Winch's function compilation environment,
//! allows Winch's code generation to access module and runtime
//! specific information.  This crate mainly implements the
//! `winch_codegen::FuncEnv` trait.

use wasmparser::types::Types;
use wasmtime_environ::{FuncIndex, Module};
use winch_codegen::{self, Callee, TargetIsa};

/// Function environment containing module and runtime specific
/// information.
pub struct FuncEnv<'a> {
    pub module: &'a Module,
    pub types: &'a Types,
    pub isa: &'a dyn TargetIsa,
}

impl<'a> winch_codegen::FuncEnv for FuncEnv<'a> {
    fn callee_from_index(&self, index: u32) -> Callee {
        let func = self
            .types
            .function_at(index)
            .expect(&format!("function type at index: {}", index));

        Callee {
            ty: func.clone(),
            import: self.module.is_imported_function(FuncIndex::from_u32(index)),
            index,
            // All functions are assumed to use Winch's calling convention.
            // The compatibility with system ABIs takes places in trampolines,
            // which wrap all imports and exports.
            call_conv: self.isa.winch_call_conv(),
        }
    }
}

impl<'a> FuncEnv<'a> {
    /// Create a new function environment.
    pub fn new(module: &'a Module, types: &'a Types, isa: &'a dyn TargetIsa) -> Self {
        Self { module, types, isa }
    }
}
