;;! target = "x86_64"

(module
    (func (result i64)
	(i64.const 0x8000000000000000)
	(i64.const 1)
	(i64.sub)
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
;;      	 48b80000000000000080 	
;; 				movabs	rax, 0x8000000000000000
;;      	 4883e801             	sub	rax, 1
;;      	 4883c410             	add	rsp, 0x10
;;      	 5d                   	pop	rbp
;;      	 c3                   	ret	
;;   38:	 0f0b                 	ud2	
