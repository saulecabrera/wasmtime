;;! target = "x86_64"
(module
  (memory (data "\00\00\00\00\00\00\f4\7f"))

  (func (export "f64.load") (result f64) (f64.load (i32.const 0)))
)
;;      	 55                   	push	rbp
;;      	 4889e5               	mov	rbp, rsp
;;      	 4883ec10             	sub	rsp, 0x10
;;      	 4989fe               	mov	r14, rdi
;;      	 4d8b5e08             	mov	r11, qword ptr [r14 + 8]
;;      	 4d8b1b               	mov	r11, qword ptr [r11]
;;      	 4939e3               	cmp	r11, rsp
;;      	 0f871f000000         	ja	0x3a
;;   1b:	 48897c2408           	mov	qword ptr [rsp + 8], rdi
;;      	 48893424             	mov	qword ptr [rsp], rsi
;;      	 b800000000           	mov	eax, 0
;;      	 498b4e50             	mov	rcx, qword ptr [r14 + 0x50]
;;      	 4801c1               	add	rcx, rax
;;      	 f20f1001             	movsd	xmm0, qword ptr [rcx]
;;      	 4883c410             	add	rsp, 0x10
;;      	 5d                   	pop	rbp
;;      	 c3                   	ret	
;;   3a:	 0f0b                 	ud2	
