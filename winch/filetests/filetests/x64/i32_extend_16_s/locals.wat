;;! target = "x86_64"

(module
    (func (result i32)
        (local i32)

        (local.get 0)
        (i32.extend16_s)
    )
)
;;      	 55                   	push	rbp
;;      	 4889e5               	mov	rbp, rsp
;;      	 4883ec18             	sub	rsp, 0x18
;;      	 4989fe               	mov	r14, rdi
;;      	 4d8b5e08             	mov	r11, qword ptr [r14 + 8]
;;      	 4d8b1b               	mov	r11, qword ptr [r11]
;;      	 4939e3               	cmp	r11, rsp
;;      	 0f871f000000         	ja	0x3a
;;   1b:	 48897c2410           	mov	qword ptr [rsp + 0x10], rdi
;;      	 4889742408           	mov	qword ptr [rsp + 8], rsi
;;      	 48c7042400000000     	mov	qword ptr [rsp], 0
;;      	 8b442404             	mov	eax, dword ptr [rsp + 4]
;;      	 0fbfc0               	movsx	eax, ax
;;      	 4883c418             	add	rsp, 0x18
;;      	 5d                   	pop	rbp
;;      	 c3                   	ret	
;;   3a:	 0f0b                 	ud2	
