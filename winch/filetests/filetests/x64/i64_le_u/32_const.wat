;;! target = "x86_64"

(module
    (func (result i32)
        (i64.const 2)
        (i64.const 3)
        (i64.le_u)
    )
)
;;      	 55                   	push	rbp
;;      	 4889e5               	mov	rbp, rsp
;;      	 4883ec10             	sub	rsp, 0x10
;;      	 4989fe               	mov	r14, rdi
;;      	 4d8b5e08             	mov	r11, qword ptr [r14 + 8]
;;      	 4d8b1b               	mov	r11, qword ptr [r11]
;;      	 4939e3               	cmp	r11, rsp
;;      	 0f8723000000         	ja	0x3e
;;   1b:	 48897c2408           	mov	qword ptr [rsp + 8], rdi
;;      	 48893424             	mov	qword ptr [rsp], rsi
;;      	 48c7c002000000       	mov	rax, 2
;;      	 4883f803             	cmp	rax, 3
;;      	 b800000000           	mov	eax, 0
;;      	 400f96c0             	setbe	al
;;      	 4883c410             	add	rsp, 0x10
;;      	 5d                   	pop	rbp
;;      	 c3                   	ret	
;;   3e:	 0f0b                 	ud2	
