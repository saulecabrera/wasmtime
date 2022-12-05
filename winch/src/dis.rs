//! Disassembly utilities.

use anyhow::{Result, bail};
use capstone::prelude::*;
use target_lexicon::Architecture;
// TODO re-export at top level?
use winch_codegen::isa::TargetIsa;
use std::fmt::Write;

pub fn print(bytes: &[u8], isa: &dyn TargetIsa) -> Result<()> {
    let disasm = disasm_for(isa)?;
    let insts = disasm.disasm_all(bytes, 0x0).unwrap();

    for i in insts.iter() {
	let mut line = String::new();

	write!(&mut line, "{:4x}:\t", i.address()).unwrap();

	let mut bytes_str = String::new();
	let mut len = 0;
	let mut first = true;
	for b in i.bytes() {
	    if !first {
		write!(&mut bytes_str, " ").unwrap();
	    }
	    write!(&mut bytes_str, "{:02x}", b).unwrap();
	    len += 1;
	    first = false;
	}
	write!(&mut line, "{:21}\t", bytes_str).unwrap();
	if len > 8 {
	    write!(&mut line, "\n\t\t\t\t").unwrap();
	}

	if let Some(s) = i.mnemonic() {
	    write!(&mut line, "{}\t", s).unwrap();
	}

	if let Some(s) = i.op_str() {
	    write!(&mut line, "{}", s).unwrap();
	}

	println!("{}", line);
    }

    Ok(())
}

fn disasm_for(isa: &dyn TargetIsa) -> Result<Capstone> {
    let disasm = match isa.triple().architecture {
	Architecture::X86_64 => Capstone::new()
	    .x86()
	    .mode(arch::x86::ArchMode::Mode64)
	    .build()
	    .map_err(|e| anyhow::format_err!("{}", e))?,
	
	_ => bail!("Unsupported ISA"),
    };

    Ok(disasm)
}
