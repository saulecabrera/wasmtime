;;! target = "x86_64"

(module
    (func (result i64)
        (local $foo i64)

        (i64.const 2)
        (local.set $foo)

        (local.get $foo)
        (i64.clz)
    )
)
;;      	 55                   	push	rbp
;;      	 4889e5               	mov	rbp, rsp
;;      	 4883ec18             	sub	rsp, 0x18
;;      	 4989fe               	mov	r14, rdi
;;      	 4d8b5e08             	mov	r11, qword ptr [r14 + 8]
;;      	 4d8b1b               	mov	r11, qword ptr [r11]
;;      	 4939e3               	cmp	r11, rsp
;;      	 0f873f000000         	ja	0x5a
;;   1b:	 48897c2410           	mov	qword ptr [rsp + 0x10], rdi
;;      	 4889742408           	mov	qword ptr [rsp + 8], rsi
;;      	 48c7042400000000     	mov	qword ptr [rsp], 0
;;      	 48c7c002000000       	mov	rax, 2
;;      	 48890424             	mov	qword ptr [rsp], rax
;;      	 488b0424             	mov	rax, qword ptr [rsp]
;;      	 480fbdc0             	bsr	rax, rax
;;      	 41bb00000000         	mov	r11d, 0
;;      	 410f95c3             	setne	r11b
;;      	 48f7d8               	neg	rax
;;      	 4883c040             	add	rax, 0x40
;;      	 4c29d8               	sub	rax, r11
;;      	 4883c418             	add	rsp, 0x18
;;      	 5d                   	pop	rbp
;;      	 c3                   	ret	
;;   5a:	 0f0b                 	ud2	
