//! AArch64 register definition

use crate::isa::reg::Reg;
use regalloc2::{PReg, RegClass};

/// Construct a X-register from an index.
pub(crate) const fn xreg(num: u8) -> Reg {
    assert!(num < 31);
    Reg::new(PReg::new(num as usize, RegClass::Int))
}

/// Construct a V-register from an index.
pub(crate) const fn vreg(num: u8) -> Reg {
    assert!(num < 32);
    Reg::new(PReg::new(num as usize, RegClass::Float))
}

const GPR: u32 = 16;
const ALLOCATABLE_GPR: u32 = (1 << GPR) - 1;
pub(crate) const ALL_GPR: u32 = ALLOCATABLE_GPR;

pub fn scratch() -> Reg {
    xreg(17)
}

pub fn zero() -> Reg {
    xreg(31)
}

pub fn stack() -> Reg {
    Reg::new(PReg::new(31 + 32, RegClass::Int))
}
