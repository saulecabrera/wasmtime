;;! target = "x86_64"
(module
  (func $dummy)
  (func (export "nested") (param i32 i32) (result i32)
    (if (result i32) (local.get 0)
      (then
        (if (local.get 1) (then (call $dummy) (nop)))
        (if (local.get 1) (then) (else (call $dummy) (nop)))
        (if (result i32) (local.get 1)
          (then (call $dummy) (i32.const 9))
          (else (call $dummy) (i32.const 10))
        )
      )
      (else
        (if (local.get 1) (then (call $dummy) (nop)))
        (if (local.get 1) (then) (else (call $dummy) (nop)))
        (if (result i32) (local.get 1)
          (then (call $dummy) (i32.const 10))
          (else (call $dummy) (i32.const 11))
        )
      )
    )
  )
)
;;      	 55                   	push	rbp
;;      	 4889e5               	mov	rbp, rsp
;;      	 4883ec10             	sub	rsp, 0x10
;;      	 4989fe               	mov	r14, rdi
;;      	 4d8b5e08             	mov	r11, qword ptr [r14 + 8]
;;      	 4d8b1b               	mov	r11, qword ptr [r11]
;;      	 4939e3               	cmp	r11, rsp
;;      	 0f870f000000         	ja	0x2a
;;   1b:	 48897c2408           	mov	qword ptr [rsp + 8], rdi
;;      	 48893424             	mov	qword ptr [rsp], rsi
;;      	 4883c410             	add	rsp, 0x10
;;      	 5d                   	pop	rbp
;;      	 c3                   	ret	
;;   2a:	 0f0b                 	ud2	
;;
;;      	 55                   	push	rbp
;;      	 4889e5               	mov	rbp, rsp
;;      	 4883ec18             	sub	rsp, 0x18
;;      	 4989fe               	mov	r14, rdi
;;      	 4d8b5e08             	mov	r11, qword ptr [r14 + 8]
;;      	 4d8b1b               	mov	r11, qword ptr [r11]
;;      	 4939e3               	cmp	r11, rsp
;;      	 0f8752010000         	ja	0x16d
;;   1b:	 48897c2410           	mov	qword ptr [rsp + 0x10], rdi
;;      	 4889742408           	mov	qword ptr [rsp + 8], rsi
;;      	 89542404             	mov	dword ptr [rsp + 4], edx
;;      	 890c24               	mov	dword ptr [rsp], ecx
;;      	 8b442404             	mov	eax, dword ptr [rsp + 4]
;;      	 85c0                 	test	eax, eax
;;      	 0f849a000000         	je	0xd2
;;   38:	 8b0424               	mov	eax, dword ptr [rsp]
;;      	 85c0                 	test	eax, eax
;;      	 0f8418000000         	je	0x5b
;;   43:	 4883ec08             	sub	rsp, 8
;;      	 4c89f7               	mov	rdi, r14
;;      	 4c89f6               	mov	rsi, r14
;;      	 e800000000           	call	0x52
;;      	 4883c408             	add	rsp, 8
;;      	 4c8b742410           	mov	r14, qword ptr [rsp + 0x10]
;;      	 8b0424               	mov	eax, dword ptr [rsp]
;;      	 85c0                 	test	eax, eax
;;      	 0f8405000000         	je	0x6b
;;      	 e918000000           	jmp	0x83
;;   6b:	 4883ec08             	sub	rsp, 8
;;      	 4c89f7               	mov	rdi, r14
;;      	 4c89f6               	mov	rsi, r14
;;      	 e800000000           	call	0x7a
;;      	 4883c408             	add	rsp, 8
;;      	 4c8b742410           	mov	r14, qword ptr [rsp + 0x10]
;;      	 8b0424               	mov	eax, dword ptr [rsp]
;;      	 85c0                 	test	eax, eax
;;      	 0f8422000000         	je	0xb0
;;   8e:	 4883ec08             	sub	rsp, 8
;;      	 4c89f7               	mov	rdi, r14
;;      	 4c89f6               	mov	rsi, r14
;;      	 e800000000           	call	0x9d
;;      	 4883c408             	add	rsp, 8
;;      	 4c8b742410           	mov	r14, qword ptr [rsp + 0x10]
;;      	 b809000000           	mov	eax, 9
;;      	 e9b7000000           	jmp	0x167
;;   b0:	 4883ec08             	sub	rsp, 8
;;      	 4c89f7               	mov	rdi, r14
;;      	 4c89f6               	mov	rsi, r14
;;      	 e800000000           	call	0xbf
;;      	 4883c408             	add	rsp, 8
;;      	 4c8b742410           	mov	r14, qword ptr [rsp + 0x10]
;;      	 b80a000000           	mov	eax, 0xa
;;      	 e995000000           	jmp	0x167
;;   d2:	 8b0424               	mov	eax, dword ptr [rsp]
;;      	 85c0                 	test	eax, eax
;;      	 0f8418000000         	je	0xf5
;;   dd:	 4883ec08             	sub	rsp, 8
;;      	 4c89f7               	mov	rdi, r14
;;      	 4c89f6               	mov	rsi, r14
;;      	 e800000000           	call	0xec
;;      	 4883c408             	add	rsp, 8
;;      	 4c8b742410           	mov	r14, qword ptr [rsp + 0x10]
;;      	 8b0424               	mov	eax, dword ptr [rsp]
;;      	 85c0                 	test	eax, eax
;;      	 0f8405000000         	je	0x105
;;      	 e918000000           	jmp	0x11d
;;  105:	 4883ec08             	sub	rsp, 8
;;      	 4c89f7               	mov	rdi, r14
;;      	 4c89f6               	mov	rsi, r14
;;      	 e800000000           	call	0x114
;;      	 4883c408             	add	rsp, 8
;;      	 4c8b742410           	mov	r14, qword ptr [rsp + 0x10]
;;      	 8b0424               	mov	eax, dword ptr [rsp]
;;      	 85c0                 	test	eax, eax
;;      	 0f8422000000         	je	0x14a
;;  128:	 4883ec08             	sub	rsp, 8
;;      	 4c89f7               	mov	rdi, r14
;;      	 4c89f6               	mov	rsi, r14
;;      	 e800000000           	call	0x137
;;      	 4883c408             	add	rsp, 8
;;      	 4c8b742410           	mov	r14, qword ptr [rsp + 0x10]
;;      	 b80a000000           	mov	eax, 0xa
;;      	 e91d000000           	jmp	0x167
;;  14a:	 4883ec08             	sub	rsp, 8
;;      	 4c89f7               	mov	rdi, r14
;;      	 4c89f6               	mov	rsi, r14
;;      	 e800000000           	call	0x159
;;      	 4883c408             	add	rsp, 8
;;      	 4c8b742410           	mov	r14, qword ptr [rsp + 0x10]
;;      	 b80b000000           	mov	eax, 0xb
;;      	 4883c418             	add	rsp, 0x18
;;      	 5d                   	pop	rbp
;;      	 c3                   	ret	
;;  16d:	 0f0b                 	ud2	
