;;! target = "x86_64"

(module
    (func (param f64) (param f64) (result f64)
        (local.get 0)
        (local.get 1)
        (f64.add)
    )
)
;;      	 55                   	push	rbp
;;      	 4889e5               	mov	rbp, rsp
;;      	 4883ec20             	sub	rsp, 0x20
;;      	 4989fe               	mov	r14, rdi
;;      	 4d8b5e08             	mov	r11, qword ptr [r14 + 8]
;;      	 4d8b1b               	mov	r11, qword ptr [r11]
;;      	 4939e3               	cmp	r11, rsp
;;      	 0f872e000000         	ja	0x49
;;   1b:	 48897c2418           	mov	qword ptr [rsp + 0x18], rdi
;;      	 4889742410           	mov	qword ptr [rsp + 0x10], rsi
;;      	 f20f11442408         	movsd	qword ptr [rsp + 8], xmm0
;;      	 f20f110c24           	movsd	qword ptr [rsp], xmm1
;;      	 f20f100424           	movsd	xmm0, qword ptr [rsp]
;;      	 f20f104c2408         	movsd	xmm1, qword ptr [rsp + 8]
;;      	 f20f58c8             	addsd	xmm1, xmm0
;;      	 660f28c1             	movapd	xmm0, xmm1
;;      	 4883c420             	add	rsp, 0x20
;;      	 5d                   	pop	rbp
;;      	 c3                   	ret	
;;   49:	 0f0b                 	ud2	
