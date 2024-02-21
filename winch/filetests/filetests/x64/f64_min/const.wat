;;! target = "x86_64"

(module
    (func (result f64)
        (f64.const 1.1)
        (f64.const 2.2)
        (f64.min)
    )
)
;;      	 55                   	push	rbp
;;      	 4889e5               	mov	rbp, rsp
;;      	 4883ec10             	sub	rsp, 0x10
;;      	 4989fe               	mov	r14, rdi
;;      	 4d8b5e08             	mov	r11, qword ptr [r14 + 8]
;;      	 4d8b1b               	mov	r11, qword ptr [r11]
;;      	 4939e3               	cmp	r11, rsp
;;      	 0f874a000000         	ja	0x65
;;   1b:	 48897c2408           	mov	qword ptr [rsp + 8], rdi
;;      	 48893424             	mov	qword ptr [rsp], rsi
;;      	 f20f10053c000000     	movsd	xmm0, qword ptr [rip + 0x3c]
;;      	 f20f100d3c000000     	movsd	xmm1, qword ptr [rip + 0x3c]
;;      	 660f2ec8             	ucomisd	xmm1, xmm0
;;      	 0f8519000000         	jne	0x57
;;      	 0f8a09000000         	jp	0x4d
;;   44:	 660f56c8             	orpd	xmm1, xmm0
;;      	 e90e000000           	jmp	0x5b
;;   4d:	 f20f58c8             	addsd	xmm1, xmm0
;;      	 0f8a04000000         	jp	0x5b
;;   57:	 f20f5dc8             	minsd	xmm1, xmm0
;;      	 660f28c1             	movapd	xmm0, xmm1
;;      	 4883c410             	add	rsp, 0x10
;;      	 5d                   	pop	rbp
;;      	 c3                   	ret	
;;   65:	 0f0b                 	ud2	
;;   67:	 009a99999999         	add	byte ptr [rdx - 0x66666667], bl
;;   6d:	 99                   	cdq	
;;   6e:	 01409a               	add	dword ptr [rax - 0x66], eax
;;   71:	 99                   	cdq	
;;   72:	 99                   	cdq	
;;   73:	 99                   	cdq	
;;   74:	 99                   	cdq	
;;   75:	 99                   	cdq	
;;   76:	 f1                   	int1	
