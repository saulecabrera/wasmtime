;;! target = "x86_64"

(module
    (func (result i64)
      i64.const 15
      i64.popcnt
    )
)
;;      	 55                   	push	rbp
;;      	 4889e5               	mov	rbp, rsp
;;      	 4883ec10             	sub	rsp, 0x10
;;      	 4989fe               	mov	r14, rdi
;;      	 4d8b5e08             	mov	r11, qword ptr [r14 + 8]
;;      	 4d8b1b               	mov	r11, qword ptr [r11]
;;      	 4939e3               	cmp	r11, rsp
;;      	 0f8770000000         	ja	0x8b
;;   1b:	 48897c2408           	mov	qword ptr [rsp + 8], rdi
;;      	 48893424             	mov	qword ptr [rsp], rsi
;;      	 48c7c00f000000       	mov	rax, 0xf
;;      	 4889c1               	mov	rcx, rax
;;      	 48c1e801             	shr	rax, 1
;;      	 49bb5555555555555555 	
;; 				movabs	r11, 0x5555555555555555
;;      	 4c21d8               	and	rax, r11
;;      	 4829c1               	sub	rcx, rax
;;      	 4889c8               	mov	rax, rcx
;;      	 49bb3333333333333333 	
;; 				movabs	r11, 0x3333333333333333
;;      	 4c21d8               	and	rax, r11
;;      	 48c1e902             	shr	rcx, 2
;;      	 4c21d9               	and	rcx, r11
;;      	 4801c1               	add	rcx, rax
;;      	 4889c8               	mov	rax, rcx
;;      	 48c1e804             	shr	rax, 4
;;      	 4801c8               	add	rax, rcx
;;      	 49bb0f0f0f0f0f0f0f0f 	
;; 				movabs	r11, 0xf0f0f0f0f0f0f0f
;;      	 4c21d8               	and	rax, r11
;;      	 49bb0101010101010101 	
;; 				movabs	r11, 0x101010101010101
;;      	 490fafc3             	imul	rax, r11
;;      	 48c1e838             	shr	rax, 0x38
;;      	 4883c410             	add	rsp, 0x10
;;      	 5d                   	pop	rbp
;;      	 c3                   	ret	
;;   8b:	 0f0b                 	ud2	
