(module
  (; (func $const-i32 (result i32) (i32.const 0x132)) ;)
  (; (func $func (param i32 i32) (result i32) (local.get 0)) ;)
  (; (type $check (func (param i32 i32) (result i32))) ;)

  (func $func (result i32) (i32.const 0))
  (type $check (func (result i32)))
  (table funcref (elem $func $func))

  (func (export "main") (result i32)
    (block (result i32)
      (i32.const 1)
      (call_indirect (type $check))
    )
  )
)
