;;! target = "x86_64"

(module
    (func (result i32)
        (f64.const 1.1)
        (f64.const 2.2)
        (f64.lt)
    )
)
;;      	 55                   	push	rbp
;;      	 4889e5               	mov	rbp, rsp
;;      	 4883ec10             	sub	rsp, 0x10
;;      	 4989fe               	mov	r14, rdi
;;      	 4d8b5e08             	mov	r11, qword ptr [r14 + 8]
;;      	 4d8b1b               	mov	r11, qword ptr [r11]
;;      	 4939e3               	cmp	r11, rsp
;;      	 0f872c000000         	ja	0x47
;;   1b:	 48897c2408           	mov	qword ptr [rsp + 8], rdi
;;      	 48893424             	mov	qword ptr [rsp], rsi
;;      	 f20f100524000000     	movsd	xmm0, qword ptr [rip + 0x24]
;;      	 f20f100d24000000     	movsd	xmm1, qword ptr [rip + 0x24]
;;      	 660f2ec1             	ucomisd	xmm0, xmm1
;;      	 b800000000           	mov	eax, 0
;;      	 400f97c0             	seta	al
;;      	 4883c410             	add	rsp, 0x10
;;      	 5d                   	pop	rbp
;;      	 c3                   	ret	
;;   47:	 0f0b                 	ud2	
;;   49:	 0000                 	add	byte ptr [rax], al
;;   4b:	 0000                 	add	byte ptr [rax], al
;;   4d:	 0000                 	add	byte ptr [rax], al
;;   4f:	 009a99999999         	add	byte ptr [rdx - 0x66666667], bl
;;   55:	 99                   	cdq	
;;   56:	 01409a               	add	dword ptr [rax - 0x66], eax
;;   59:	 99                   	cdq	
;;   5a:	 99                   	cdq	
;;   5b:	 99                   	cdq	
;;   5c:	 99                   	cdq	
;;   5d:	 99                   	cdq	
;;   5e:	 f1                   	int1	
