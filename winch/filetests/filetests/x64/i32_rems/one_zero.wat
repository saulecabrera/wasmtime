;;! target = "x86_64"

(module
    (func (result i32)
	(i32.const 1)
	(i32.const 0)
	(i32.rem_s)
    )
)
;;      	 55                   	push	rbp
;;      	 4889e5               	mov	rbp, rsp
;;      	 4883ec10             	sub	rsp, 0x10
;;      	 4989fe               	mov	r14, rdi
;;      	 4d8b5e08             	mov	r11, qword ptr [r14 + 8]
;;      	 4d8b1b               	mov	r11, qword ptr [r11]
;;      	 4939e3               	cmp	r11, rsp
;;      	 0f8731000000         	ja	0x4c
;;   1b:	 48897c2408           	mov	qword ptr [rsp + 8], rdi
;;      	 48893424             	mov	qword ptr [rsp], rsi
;;      	 b900000000           	mov	ecx, 0
;;      	 b801000000           	mov	eax, 1
;;      	 99                   	cdq	
;;      	 83f9ff               	cmp	ecx, -1
;;      	 0f850a000000         	jne	0x42
;;   38:	 ba00000000           	mov	edx, 0
;;      	 e902000000           	jmp	0x44
;;   42:	 f7f9                 	idiv	ecx
;;      	 89d0                 	mov	eax, edx
;;      	 4883c410             	add	rsp, 0x10
;;      	 5d                   	pop	rbp
;;      	 c3                   	ret	
;;   4c:	 0f0b                 	ud2	
