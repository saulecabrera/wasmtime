;;! target = "x86_64"

(module
    (func (result i64)
        (local f32)  

        (local.get 0)
        (i64.trunc_f32_u)
    )
)
;;      	 55                   	push	rbp
;;      	 4889e5               	mov	rbp, rsp
;;      	 4883ec18             	sub	rsp, 0x18
;;      	 4989fe               	mov	r14, rdi
;;      	 4d8b5e08             	mov	r11, qword ptr [r14 + 8]
;;      	 4d8b1b               	mov	r11, qword ptr [r11]
;;      	 4939e3               	cmp	r11, rsp
;;      	 0f876e000000         	ja	0x89
;;   1b:	 48897c2410           	mov	qword ptr [rsp + 0x10], rdi
;;      	 4889742408           	mov	qword ptr [rsp + 8], rsi
;;      	 48c7042400000000     	mov	qword ptr [rsp], 0
;;      	 f30f104c2404         	movss	xmm1, dword ptr [rsp + 4]
;;      	 41bb0000005f         	mov	r11d, 0x5f000000
;;      	 66450f6efb           	movd	xmm15, r11d
;;      	 410f2ecf             	ucomiss	xmm1, xmm15
;;      	 0f8317000000         	jae	0x5f
;;      	 0f8a3d000000         	jp	0x8b
;;   4e:	 f3480f2cc1           	cvttss2si	rax, xmm1
;;      	 4883f800             	cmp	rax, 0
;;      	 0f8d26000000         	jge	0x83
;;   5d:	 0f0b                 	ud2	
;;      	 0f28c1               	movaps	xmm0, xmm1
;;      	 f3410f5cc7           	subss	xmm0, xmm15
;;      	 f3480f2cc0           	cvttss2si	rax, xmm0
;;      	 4883f800             	cmp	rax, 0
;;      	 0f8c17000000         	jl	0x8d
;;   76:	 49bb0000000000000080 	
;; 				movabs	r11, 0x8000000000000000
;;      	 4c01d8               	add	rax, r11
;;      	 4883c418             	add	rsp, 0x18
;;      	 5d                   	pop	rbp
;;      	 c3                   	ret	
;;   89:	 0f0b                 	ud2	
;;   8b:	 0f0b                 	ud2	
;;   8d:	 0f0b                 	ud2	
