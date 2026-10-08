;;! target = "x86_64"
;;! test = "winch"
;;! flags = ["-Omemory-reservation=0x20000", "-Omemory-may-move=n"]

;; The memory's minimum size fits within `memory-reservation` and the memory
;; can't move, so the reservation is an upper bound: an access whose offset
;; exceeds it is statically out of bounds.
(module
  (memory 2)
  (func (export "load_offset") (param i32) (result i32)
    local.get 0
    i32.load offset=0x20000))
;; wasm[0]::function[0]:
;;       pushq   %rbp
;;       movq    %rsp, %rbp
;;       movq    8(%rdi), %r11
;;       movq    0x18(%r11), %r11
;;       addq    $0x20, %r11
;;       cmpq    %rsp, %r11
;;       ja      0x54
;;   1c: movq    %rdi, %r14
;;       subq    $0x20, %rsp
;;       movq    %rdi, 0x18(%rsp)
;;       movq    %rsi, 0x10(%rsp)
;;       movl    %edx, 0xc(%rsp)
;;       movl    0xc(%rsp), %eax
;;       movq    8(%r14), %rcx
;;       movq    (%rcx), %r11
;;       addq    $1, %r11
;;       movq    %r11, (%rcx)
;;       ud2
;;       addq    $0x20, %rsp
;;       popq    %rbp
;;       retq
;;   54: ud2
