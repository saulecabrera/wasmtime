;;! target = "x86_64"

(module
    (func (result f64)
        i64.const 1
        f64.convert_i64_u
        block
        end
    )
)
;;      	 55                   	push	rbp
;;      	 4889e5               	mov	rbp, rsp
;;      	 4883ec10             	sub	rsp, 0x10
;;      	 4989fe               	mov	r14, rdi
;;      	 4d8b5e08             	mov	r11, qword ptr [r14 + 8]
;;      	 4d8b1b               	mov	r11, qword ptr [r11]
;;      	 4939e3               	cmp	r11, rsp
;;      	 0f8756000000         	ja	0x71
;;   1b:	 48897c2408           	mov	qword ptr [rsp + 8], rdi
;;      	 48893424             	mov	qword ptr [rsp], rsi
;;      	 48c7c101000000       	mov	rcx, 1
;;      	 4883f900             	cmp	rcx, 0
;;      	 0f8c0a000000         	jl	0x3f
;;   35:	 f2480f2ac1           	cvtsi2sd	xmm0, rcx
;;      	 e91a000000           	jmp	0x59
;;   3f:	 4989cb               	mov	r11, rcx
;;      	 49c1eb01             	shr	r11, 1
;;      	 4889c8               	mov	rax, rcx
;;      	 4883e001             	and	rax, 1
;;      	 4c09d8               	or	rax, r11
;;      	 f2480f2ac0           	cvtsi2sd	xmm0, rax
;;      	 f20f58c0             	addsd	xmm0, xmm0
;;      	 4883ec08             	sub	rsp, 8
;;      	 f20f110424           	movsd	qword ptr [rsp], xmm0
;;      	 f20f100424           	movsd	xmm0, qword ptr [rsp]
;;      	 4883c408             	add	rsp, 8
;;      	 4883c410             	add	rsp, 0x10
;;      	 5d                   	pop	rbp
;;      	 c3                   	ret	
;;   71:	 0f0b                 	ud2	
