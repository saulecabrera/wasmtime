;;! target = "x86_64"

(module
    (func (result i32)
        (i64.const 1)
        (i32.wrap_i64)
    )
)
;;      	 55                   	push	rbp
;;      	 4889e5               	mov	rbp, rsp
;;      	 4883ec10             	sub	rsp, 0x10
;;      	 4989fe               	mov	r14, rdi
;;      	 4d8b5e08             	mov	r11, qword ptr [r14 + 8]
;;      	 4d8b1b               	mov	r11, qword ptr [r11]
;;      	 4939e3               	cmp	r11, rsp
;;      	 0f8718000000         	ja	0x33
;;   1b:	 48897c2408           	mov	qword ptr [rsp + 8], rdi
;;      	 48893424             	mov	qword ptr [rsp], rsi
;;      	 48c7c001000000       	mov	rax, 1
;;      	 89c0                 	mov	eax, eax
;;      	 4883c410             	add	rsp, 0x10
;;      	 5d                   	pop	rbp
;;      	 c3                   	ret	
;;   33:	 0f0b                 	ud2	
