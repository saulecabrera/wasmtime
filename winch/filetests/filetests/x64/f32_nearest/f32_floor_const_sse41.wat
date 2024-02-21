;;! target = "x86_64"
;;! flags = ["has_sse41"]

(module
    (func (result f32)
        (f32.const -1.32)
        (f32.nearest)
    )
)
;;      	 55                   	push	rbp
;;      	 4889e5               	mov	rbp, rsp
;;      	 4883ec10             	sub	rsp, 0x10
;;      	 4989fe               	mov	r14, rdi
;;      	 4d8b5e08             	mov	r11, qword ptr [r14 + 8]
;;      	 4d8b1b               	mov	r11, qword ptr [r11]
;;      	 4939e3               	cmp	r11, rsp
;;      	 0f871d000000         	ja	0x38
;;   1b:	 48897c2408           	mov	qword ptr [rsp + 8], rdi
;;      	 48893424             	mov	qword ptr [rsp], rsi
;;      	 f30f100514000000     	movss	xmm0, dword ptr [rip + 0x14]
;;      	 660f3a0ac000         	roundss	xmm0, xmm0, 0
;;      	 4883c410             	add	rsp, 0x10
;;      	 5d                   	pop	rbp
;;      	 c3                   	ret	
;;   38:	 0f0b                 	ud2	
;;   3a:	 0000                 	add	byte ptr [rax], al
;;   3c:	 0000                 	add	byte ptr [rax], al
;;   3e:	 0000                 	add	byte ptr [rax], al
;;   40:	 c3                   	ret	
;;   41:	 f5                   	cmc	
;;   42:	 a8bf                 	test	al, 0xbf
