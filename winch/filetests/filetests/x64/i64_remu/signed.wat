;;! target = "x86_64"

(module
    (func (result i64)
	(i64.const -1)
	(i64.const -1)
	(i64.rem_u)
    )
)
;;      	 55                   	push	rbp
;;      	 4889e5               	mov	rbp, rsp
;;      	 4883ec10             	sub	rsp, 0x10
;;      	 4989fe               	mov	r14, rdi
;;      	 4d8b5e08             	mov	r11, qword ptr [r14 + 8]
;;      	 4d8b1b               	mov	r11, qword ptr [r11]
;;      	 4939e3               	cmp	r11, rsp
;;      	 0f8726000000         	ja	0x41
;;   1b:	 48897c2408           	mov	qword ptr [rsp + 8], rdi
;;      	 48893424             	mov	qword ptr [rsp], rsi
;;      	 48c7c1ffffffff       	mov	rcx, 0xffffffffffffffff
;;      	 48c7c0ffffffff       	mov	rax, 0xffffffffffffffff
;;      	 4831d2               	xor	rdx, rdx
;;      	 48f7f1               	div	rcx
;;      	 4889d0               	mov	rax, rdx
;;      	 4883c410             	add	rsp, 0x10
;;      	 5d                   	pop	rbp
;;      	 c3                   	ret	
;;   41:	 0f0b                 	ud2	
