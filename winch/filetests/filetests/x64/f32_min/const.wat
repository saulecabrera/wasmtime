;;! target = "x86_64"

(module
    (func (result f32)
        (f32.const 1.1)
        (f32.const 2.2)
        (f32.min)
    )
)
;;      	 55                   	push	rbp
;;      	 4889e5               	mov	rbp, rsp
;;      	 4883ec10             	sub	rsp, 0x10
;;      	 4989fe               	mov	r14, rdi
;;      	 4d8b5e08             	mov	r11, qword ptr [r14 + 8]
;;      	 4d8b1b               	mov	r11, qword ptr [r11]
;;      	 4939e3               	cmp	r11, rsp
;;      	 0f8747000000         	ja	0x62
;;   1b:	 48897c2408           	mov	qword ptr [rsp + 8], rdi
;;      	 48893424             	mov	qword ptr [rsp], rsi
;;      	 f30f10053c000000     	movss	xmm0, dword ptr [rip + 0x3c]
;;      	 f30f100d3c000000     	movss	xmm1, dword ptr [rip + 0x3c]
;;      	 0f2ec8               	ucomiss	xmm1, xmm0
;;      	 0f8518000000         	jne	0x55
;;      	 0f8a08000000         	jp	0x4b
;;   43:	 0f56c8               	orps	xmm1, xmm0
;;      	 e90e000000           	jmp	0x59
;;   4b:	 f30f58c8             	addss	xmm1, xmm0
;;      	 0f8a04000000         	jp	0x59
;;   55:	 f30f5dc8             	minss	xmm1, xmm0
;;      	 0f28c1               	movaps	xmm0, xmm1
;;      	 4883c410             	add	rsp, 0x10
;;      	 5d                   	pop	rbp
;;      	 c3                   	ret	
;;   62:	 0f0b                 	ud2	
;;   64:	 0000                 	add	byte ptr [rax], al
;;   66:	 0000                 	add	byte ptr [rax], al
;;   68:	 cdcc                 	int	0xcc
;;   6a:	 0c40                 	or	al, 0x40
;;   6c:	 0000                 	add	byte ptr [rax], al
;;   6e:	 0000                 	add	byte ptr [rax], al
;;   70:	 cdcc                 	int	0xcc
