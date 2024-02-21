;;! target = "x86_64"

(module
    (func (result f32)
        (local $foo f32)  
        (local $bar f32)

        (f32.const 1.1)
        (local.set $foo)

        (f32.const 2.2)
        (local.set $bar)

        (local.get $foo)
        (local.get $bar)
        f32.min
    )
)
;;      	 55                   	push	rbp
;;      	 4889e5               	mov	rbp, rsp
;;      	 4883ec18             	sub	rsp, 0x18
;;      	 4989fe               	mov	r14, rdi
;;      	 4d8b5e08             	mov	r11, qword ptr [r14 + 8]
;;      	 4d8b1b               	mov	r11, qword ptr [r11]
;;      	 4939e3               	cmp	r11, rsp
;;      	 0f8766000000         	ja	0x81
;;   1b:	 48897c2410           	mov	qword ptr [rsp + 0x10], rdi
;;      	 4889742408           	mov	qword ptr [rsp + 8], rsi
;;      	 48c7042400000000     	mov	qword ptr [rsp], 0
;;      	 f30f100553000000     	movss	xmm0, dword ptr [rip + 0x53]
;;      	 f30f11442404         	movss	dword ptr [rsp + 4], xmm0
;;      	 f30f10054d000000     	movss	xmm0, dword ptr [rip + 0x4d]
;;      	 f30f110424           	movss	dword ptr [rsp], xmm0
;;      	 f30f100424           	movss	xmm0, dword ptr [rsp]
;;      	 f30f104c2404         	movss	xmm1, dword ptr [rsp + 4]
;;      	 0f2ec8               	ucomiss	xmm1, xmm0
;;      	 0f8518000000         	jne	0x74
;;      	 0f8a08000000         	jp	0x6a
;;   62:	 0f56c8               	orps	xmm1, xmm0
;;      	 e90e000000           	jmp	0x78
;;   6a:	 f30f58c8             	addss	xmm1, xmm0
;;      	 0f8a04000000         	jp	0x78
;;   74:	 f30f5dc8             	minss	xmm1, xmm0
;;      	 0f28c1               	movaps	xmm0, xmm1
;;      	 4883c418             	add	rsp, 0x18
;;      	 5d                   	pop	rbp
;;      	 c3                   	ret	
;;   81:	 0f0b                 	ud2	
;;   83:	 0000                 	add	byte ptr [rax], al
;;   85:	 0000                 	add	byte ptr [rax], al
;;   87:	 00cd                 	add	ch, cl
;;   89:	 cc                   	int3	
