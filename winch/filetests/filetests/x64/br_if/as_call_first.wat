;;! target = "x86_64"
(module
  (func $f (param i32 i32 i32) (result i32) (i32.const -1))
  (func (export "as-call-first") (result i32)
    (block (result i32)
      (call $f
        (br_if 0 (i32.const 12) (i32.const 1)) (i32.const 2) (i32.const 3)
      )
    )
  )
)
;;      	 55                   	push	rbp
;;      	 4889e5               	mov	rbp, rsp
;;      	 4883ec20             	sub	rsp, 0x20
;;      	 4989fe               	mov	r14, rdi
;;      	 4d8b5e08             	mov	r11, qword ptr [r14 + 8]
;;      	 4d8b1b               	mov	r11, qword ptr [r11]
;;      	 4939e3               	cmp	r11, rsp
;;      	 0f8722000000         	ja	0x3d
;;   1b:	 48897c2418           	mov	qword ptr [rsp + 0x18], rdi
;;      	 4889742410           	mov	qword ptr [rsp + 0x10], rsi
;;      	 8954240c             	mov	dword ptr [rsp + 0xc], edx
;;      	 894c2408             	mov	dword ptr [rsp + 8], ecx
;;      	 4489442404           	mov	dword ptr [rsp + 4], r8d
;;      	 b8ffffffff           	mov	eax, 0xffffffff
;;      	 4883c420             	add	rsp, 0x20
;;      	 5d                   	pop	rbp
;;      	 c3                   	ret	
;;   3d:	 0f0b                 	ud2	
;;
;;      	 55                   	push	rbp
;;      	 4889e5               	mov	rbp, rsp
;;      	 4883ec10             	sub	rsp, 0x10
;;      	 4989fe               	mov	r14, rdi
;;      	 4d8b5e08             	mov	r11, qword ptr [r14 + 8]
;;      	 4d8b1b               	mov	r11, qword ptr [r11]
;;      	 4939e3               	cmp	r11, rsp
;;      	 0f8753000000         	ja	0x6e
;;   1b:	 48897c2408           	mov	qword ptr [rsp + 8], rdi
;;      	 48893424             	mov	qword ptr [rsp], rsi
;;      	 b901000000           	mov	ecx, 1
;;      	 b80c000000           	mov	eax, 0xc
;;      	 85c9                 	test	ecx, ecx
;;      	 0f8532000000         	jne	0x68
;;   36:	 4883ec04             	sub	rsp, 4
;;      	 890424               	mov	dword ptr [rsp], eax
;;      	 4883ec0c             	sub	rsp, 0xc
;;      	 4c89f7               	mov	rdi, r14
;;      	 4c89f6               	mov	rsi, r14
;;      	 8b54240c             	mov	edx, dword ptr [rsp + 0xc]
;;      	 b902000000           	mov	ecx, 2
;;      	 41b803000000         	mov	r8d, 3
;;      	 e800000000           	call	0x5b
;;      	 4883c40c             	add	rsp, 0xc
;;      	 4883c404             	add	rsp, 4
;;      	 4c8b742408           	mov	r14, qword ptr [rsp + 8]
;;      	 4883c410             	add	rsp, 0x10
;;      	 5d                   	pop	rbp
;;      	 c3                   	ret	
;;   6e:	 0f0b                 	ud2	
