;;! target = "x86_64"

(module
    (func (param f32) (param f32) (result i32)
        (local.get 0)
        (local.get 1)
        (f32.lt)
    )
)
;;      	 55                   	push	rbp
;;      	 4889e5               	mov	rbp, rsp
;;      	 4883ec18             	sub	rsp, 0x18
;;      	 4989fe               	mov	r14, rdi
;;      	 4d8b5e08             	mov	r11, qword ptr [r14 + 8]
;;      	 4d8b1b               	mov	r11, qword ptr [r11]
;;      	 4939e3               	cmp	r11, rsp
;;      	 0f8732000000         	ja	0x4d
;;   1b:	 48897c2410           	mov	qword ptr [rsp + 0x10], rdi
;;      	 4889742408           	mov	qword ptr [rsp + 8], rsi
;;      	 f30f11442404         	movss	dword ptr [rsp + 4], xmm0
;;      	 f30f110c24           	movss	dword ptr [rsp], xmm1
;;      	 f30f100424           	movss	xmm0, dword ptr [rsp]
;;      	 f30f104c2404         	movss	xmm1, dword ptr [rsp + 4]
;;      	 0f2ec1               	ucomiss	xmm0, xmm1
;;      	 b800000000           	mov	eax, 0
;;      	 400f97c0             	seta	al
;;      	 4883c418             	add	rsp, 0x18
;;      	 5d                   	pop	rbp
;;      	 c3                   	ret	
;;   4d:	 0f0b                 	ud2	
