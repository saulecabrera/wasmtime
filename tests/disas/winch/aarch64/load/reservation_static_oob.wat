;;! target = "aarch64"
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
;;       stp     x29, x30, [sp, #-0x10]!
;;       mov     x29, sp
;;       str     x28, [sp, #-0x10]!
;;       mov     x28, sp
;;       ldur    x16, [x0, #8]
;;       ldur    x16, [x16, #0x18]
;;       mov     x17, #0
;;       movk    x17, #0x18
;;       add     x16, x16, x17
;;       cmp     sp, x16
;;       b.lo    #0x7c
;;   2c: mov     x9, x0
;;       sub     x28, x28, #0x18
;;       mov     sp, x28
;;       stur    x0, [x28, #0x10]
;;       stur    x1, [x28, #8]
;;       stur    w2, [x28, #4]
;;       ldur    w0, [x28, #4]
;;       ldur    x1, [x9, #8]
;;       ldur    x16, [x1]
;;       add     x16, x16, #1
;;       stur    x16, [x1]
;;       sub     sp, x28, #8
;;       udf     #0xc11f
;;       mov     sp, x28
;;       add     x28, x28, #0x18
;;       mov     sp, x28
;;       mov     sp, x28
;;       ldr     x28, [sp], #0x10
;;       ldp     x29, x30, [sp], #0x10
;;       ret
;;   7c: udf     #0xc11f
