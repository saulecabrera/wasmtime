;;! target = "x86_64"

(module
    (func (result f32)
        (f32.const -1.1)
        (f32.const 2.2)
        (f32.copysign)
    )
)
;;      	 55                   	push	rbp
;;      	 4889e5               	mov	rbp, rsp
;;      	 4883ec10             	sub	rsp, 0x10
;;      	 4989fe               	mov	r14, rdi
;;      	 4d8b5e08             	mov	r11, qword ptr [r14 + 8]
;;      	 4d8b1b               	mov	r11, qword ptr [r11]
;;      	 4939e3               	cmp	r11, rsp
;;      	 0f873c000000         	ja	0x57
;;   1b:	 48897c2408           	mov	qword ptr [rsp + 8], rdi
;;      	 48893424             	mov	qword ptr [rsp], rsi
;;      	 f30f100534000000     	movss	xmm0, dword ptr [rip + 0x34]
;;      	 f30f100d34000000     	movss	xmm1, dword ptr [rip + 0x34]
;;      	 41bb00000080         	mov	r11d, 0x80000000
;;      	 66450f6efb           	movd	xmm15, r11d
;;      	 410f54c7             	andps	xmm0, xmm15
;;      	 440f55f9             	andnps	xmm15, xmm1
;;      	 410f28cf             	movaps	xmm1, xmm15
;;      	 0f56c8               	orps	xmm1, xmm0
;;      	 0f28c1               	movaps	xmm0, xmm1
;;      	 4883c410             	add	rsp, 0x10
;;      	 5d                   	pop	rbp
;;      	 c3                   	ret	
;;   57:	 0f0b                 	ud2	
;;   59:	 0000                 	add	byte ptr [rax], al
;;   5b:	 0000                 	add	byte ptr [rax], al
;;   5d:	 0000                 	add	byte ptr [rax], al
;;   5f:	 00cd                 	add	ch, cl
;;   61:	 cc                   	int3	
;;   62:	 0c40                 	or	al, 0x40
;;   64:	 0000                 	add	byte ptr [rax], al
;;   66:	 0000                 	add	byte ptr [rax], al
;;   68:	 cdcc                 	int	0xcc
