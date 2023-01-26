//! AArch64 register definition.

use crate::isa::reg::Reg;
use regalloc2::{PReg, RegClass};

/// Construct a X-register from an index.
pub(crate) const fn xreg(num: u8) -> Reg {
    assert!(num < 32);
    Reg::new(PReg::new(num as usize, RegClass::Int))
}

/// Construct a V-register from an index.
pub(crate) const fn vreg(num: u8) -> Reg {
    assert!(num < 32);
    Reg::new(PReg::new(num as usize, RegClass::Float))
}

/// Scratch register.
/// Intra-procedure-call corruptible register.
pub(crate) const fn ip0() -> Reg {
    xreg(16)
}

/// Alias to the IP0 register.
pub(crate) const fn scratch() -> Reg {
    ip0()
}

/// Scratch register.
/// Intra-procedure-call corruptible register.
pub(crate) const fn ip1() -> Reg {
    xreg(17)
}

/// Register used to carry platform state.
const fn platform() -> Reg {
    xreg(18)
}

/// Frame pointer register.
pub(crate) const fn fp() -> Reg {
    xreg(29)
}

/// Link register for function calls.
pub(crate) const fn lr() -> Reg {
    xreg(30)
}

/// Zero register.
pub(crate) const fn zero() -> Reg {
    xreg(31)
}

/// Stack pointer register.
///
/// In aarch64 the zero and stack pointer registers are contextually
/// different but have the same hardware encoding; to differentiate
/// them, we are following Cranelift's encoding and representing it as
/// 31 + 32.  Ref:
/// https://github.com/bytecodealliance/wasmtime/blob/main/cranelift/codegen/src/isa/aarch64/inst/regs.rs#L70
pub(crate) const fn sp() -> Reg {
    Reg::new(PReg::new(31 + 32, RegClass::Int))
}

/// Shadow stack pointer register.
///
/// The shadow stack pointer is used as the base for memory addressing
/// to workaround Aarch64's constraint on the stack pointer 16-byte
/// alignment for memory addressing. This allows word size loads and
/// stores.  It's always assumed that the real stack pointer is
/// unaligned; the only exceptions to this assumption are the function
/// prologue and epilogue in which we use the real stack pointer for
/// addressing, assuming that the 16-byte alignment is respected.
///
/// The fact that the shadow stack pointer is used for memory
/// addressing, doesn't change the meaning of the real stack pointer,
/// which should always be used to allocate and deallocate stack
/// space. Throughout the code generation any change to the stack
/// pointer is reflected in the shadow stack pointer via the
/// `MacroAssembler::move_sp_to_shadow_sp` function.
pub(crate) const fn shadow_sp() -> Reg {
    xreg(28)
}

const NON_ALLOCATABLE_GPR: u32 = (1 << ip0().hw_enc())
    | (1 << ip1().hw_enc())
    | (1 << platform().hw_enc())
    | (1 << fp().hw_enc())
    | (1 << lr().hw_enc())
    | (1 << zero().hw_enc())
    | (1 << shadow_sp().hw_enc());

/// Bitmask to represent the available general purpose registers.
pub(crate) const ALL_GPR: u32 = u32::MAX & !NON_ALLOCATABLE_GPR;
