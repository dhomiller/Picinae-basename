(* Automatically generated with pcode2coq
arch: armv8
file: basename.lo
function: basename
*)

Require Import Picinae_armv8.
Require Import NArith.
Require Import Lia.
Open Scope N.

Definition basename : program := fun _ a => match a with

(* 0x00100004: cbz x0,0x0010006c *)
(*    1048580: cbz x0,0x0010006c *)
| 0x100004 => Some (4,
	(* (unique, 0x18f80, 1) INT_EQUAL (register, 0x4000, 8) , (const, 0x0, 8) *)
	Move (V_TEMP 0x18f80) (BinOp OP_EQ (Var R_X0) (Word 0x0 64)) $;
	(*  ---  CBRANCH (ram, 0x10006c, 8) , (unique, 0x18f80, 1) *)
	If (Cast CAST_LOW 1 (Var (V_TEMP 0x18f80))) (
		Jmp (Word 0x10006c 64)
	) (* else *) (
		Nop
	)
)

(* 0x00100008: stp x29,x30,[sp, #-0x20]! *)
(*    1048584: stp x29,x30,[sp, #-0x20]! *)
| 0x100008 => Some (4,
	(* (unique, 0x3a500, 8) COPY (register, 0x40e8, 8) *)
	Move (V_TEMP 0x3a500) (Var R_X29) $;
	(* (unique, 0x3a580, 8) COPY (register, 0x40f0, 8) *)
	Move (V_TEMP 0x3a580) (Var R_X30) $;
	(* (register, 0x8, 8) INT_ADD (register, 0x8, 8) , (const, 0xffffffffffffffe0, 8) *)
	Move R_SP (BinOp OP_PLUS (Var R_SP) (Word 0xffffffffffffffe0 64)) $;
	(*  ---  STORE (const, 0x1b1, 8) , (register, 0x8, 8) , (unique, 0x3a500, 8) *)
	Move V_MEM64 (Store (Var V_MEM64) (Var R_SP) (Cast CAST_LOW 64 (Var (V_TEMP 0x3a500))) LittleE 8) $;
	(* (unique, 0x3a600, 8) INT_ADD (register, 0x8, 8) , (const, 0x8, 8) *)
	Move (V_TEMP 0x3a600) (BinOp OP_PLUS (Var R_SP) (Word 0x8 64)) $;
	(*  ---  STORE (const, 0x1b1, 8) , (unique, 0x3a600, 8) , (unique, 0x3a580, 8) *)
	Move V_MEM64 (Store (Var V_MEM64) (Var (V_TEMP 0x3a600)) (Cast CAST_LOW 64 (Var (V_TEMP 0x3a580))) LittleE 8)
)

(* 0x0010000c: mov x29,sp *)
(*    1048588: mov x29,sp *)
| 0x10000c => Some (4,
	(* (register, 0x40e8, 8) COPY (register, 0x8, 8) *)
	Move R_X29 (Var R_SP)
)

(* 0x00100010: str x19,[sp, #0x10] *)
(*    1048592: str x19,[sp, #0x10] *)
| 0x100010 => Some (4,
	(* (unique, 0x6500, 8) INT_ADD (register, 0x8, 8) , (const, 0x10, 8) *)
	Move (V_TEMP 0x6500) (BinOp OP_PLUS (Var R_SP) (Word 0x10 64)) $;
	(*  ---  STORE (const, 0x1b1, 8) , (unique, 0x6500, 8) , (register, 0x4098, 8) *)
	Move V_MEM64 (Store (Var V_MEM64) (Var (V_TEMP 0x6500)) (Cast CAST_LOW 64 (Var R_X19)) LittleE 8)
)

(* 0x00100014: mov x19,x0 *)
(*    1048596: mov x19,x0 *)
| 0x100014 => Some (4,
	(* (register, 0x4098, 8) COPY (register, 0x4000, 8) *)
	Move R_X19 (Var R_X0)
)

(* 0x00100018: ldrb w1,[x0] *)
(*    1048600: ldrb w1,[x0] *)
| 0x100018 => Some (4,
	(* (unique, 0x6680, 8) COPY (register, 0x4000, 8) *)
	Move (V_TEMP 0x6680) (Var R_X0) $;
	(* (unique, 0x25500, 1) LOAD (const, 0x1b1, 8) , (unique, 0x6680, 8) *)
	Move (V_TEMP 0x25500) (Load (Var V_MEM64) (Var (V_TEMP 0x6680)) LittleE 1) $;
	(* (register, 0x4008, 8) INT_ZEXT (unique, 0x25500, 1) *)
	Move R_X1 (Cast CAST_UNSIGNED 64 (Var (V_TEMP 0x25500)))
)

(* 0x0010001c: cbz w1,0x00100078 *)
(*    1048604: cbz w1,0x00100078 *)
| 0x10001c => Some (4,
	(* (unique, 0x18f00, 1) INT_EQUAL (register, 0x4008, 4) , (const, 0x0, 4) *)
	Move (V_TEMP 0x18f00) (BinOp OP_EQ (Extract 31 0 (Var R_X1)) (Word 0x0 32)) $;
	(*  ---  CBRANCH (ram, 0x100078, 8) , (unique, 0x18f00, 1) *)
	If (Cast CAST_LOW 1 (Var (V_TEMP 0x18f00))) (
		Jmp (Word 0x100078 64)
	) (* else *) (
		Nop
	)
)

(* 0x00100020: bl 0x00200000 *)
(*    1048608: bl 0x00200000 *)
| 0x100020 => Some (4,
	(* (register, 0x40f0, 8) INT_ADD (const, 0x100020, 8) , (const, 0x4, 8) *)
	Move R_X30 (BinOp OP_PLUS (Word 0x100020 64) (Word 0x4 64)) $;
	(*  ---  CALL (ram, 0x101000, 8) *)
	Jmp (Word 0x200000 64)
)

(* 0x00100024: sub x0,x0,#0x1 *)
(*    1048612: sub x0,x0,#0x1 *)
| 0x100024 => Some (4,
	(* (register, 0x4000, 8) INT_SUB (register, 0x4000, 8) , (const, 0x1, 8) *)
	Move R_X0 (BinOp OP_MINUS (Var R_X0) (Word 0x1 64))
)

(* 0x00100028: cbz x0,0x0010004c *)
(*    1048616: cbz x0,0x0010004c *)
| 0x100028 => Some (4,
	(* (unique, 0x18f80, 1) INT_EQUAL (register, 0x4000, 8) , (const, 0x0, 8) *)
	Move (V_TEMP 0x18f80) (BinOp OP_EQ (Var R_X0) (Word 0x0 64)) $;
	(*  ---  CBRANCH (ram, 0x10004c, 8) , (unique, 0x18f80, 1) *)
	If (Cast CAST_LOW 1 (Var (V_TEMP 0x18f80))) (
		Jmp (Word 0x10004c 64)
	) (* else *) (
		Nop
	)
)

(* 0x0010002c: ldrb w1,[x19, x0, LSL ] *)
(*    1048620: ldrb w1,[x19, x0, LSL ] *)
| 0x10002c => Some (4,
	(* (unique, 0x5a00, 8) COPY (register, 0x4000, 8) *)
	Move (V_TEMP 0x5a00) (Var R_X0) $;
	(* (unique, 0x7100, 8) COPY (unique, 0x5a00, 8) *)
	Move (V_TEMP 0x7100) (Var (V_TEMP 0x5a00)) $;
	(* (unique, 0x7100, 8) INT_LEFT (unique, 0x7100, 8) , (const, 0x0, 8) *)
	Move (V_TEMP 0x7100) (BinOp OP_LSHIFT (Var (V_TEMP 0x7100)) (Word 0x0 64)) $;
	(* (unique, 0x7580, 8) INT_ADD (register, 0x4098, 8) , (unique, 0x7100, 8) *)
	Move (V_TEMP 0x7580) (BinOp OP_PLUS (Var R_X19) (Var (V_TEMP 0x7100))) $;
	(* (unique, 0x25600, 1) LOAD (const, 0x1b1, 8) , (unique, 0x7580, 8) *)
	Move (V_TEMP 0x25600) (Load (Var V_MEM64) (Var (V_TEMP 0x7580)) LittleE 1) $;
	(* (register, 0x4008, 8) INT_ZEXT (unique, 0x25600, 1) *)
	Move R_X1 (Cast CAST_UNSIGNED 64 (Var (V_TEMP 0x25600)))
)

(* 0x00100030: cmp w1,#0x2f *)
(*    1048624: cmp w1,#0x2f *)
| 0x100030 => Some (4,
	(* (unique, 0x1c980, 4) COPY (const, 0x2f, 4) *)
	Move (V_TEMP 0x1c980) (Word 0x2f 32) $;
	(* (register, 0x105, 1) INT_LESSEQUAL (const, 0x2f, 4) , (register, 0x4008, 4) *)
	Move R_TMPCY (Cast CAST_UNSIGNED 8 (BinOp OP_LE (Word 0x2f 32) (Extract 31 0 (Var R_X1)))) $;
	(* (register, 0x106, 1) INT_SBORROW (register, 0x4008, 4) , (const, 0x2f, 4) *)
	Move R_TMPOV (Cast CAST_LOW 8 (BinOp OP_AND (BinOp OP_XOR (BinOp OP_AND (BinOp OP_RSHIFT (Extract 31 0 (Var R_X1)) (Word 31 32)) (Word 1 32)) (BinOp OP_AND (BinOp OP_RSHIFT (BinOp OP_MINUS (Extract 31 0 (Var R_X1)) (Word 0x2f 32)) (Word 31 32)) (Word 1 32))) (BinOp OP_XOR (BinOp OP_XOR (BinOp OP_AND (BinOp OP_RSHIFT (BinOp OP_MINUS (Extract 31 0 (Var R_X1)) (Word 0x2f 32)) (Word 31 32)) (Word 1 32)) (BinOp OP_AND (BinOp OP_RSHIFT (Word 0x2f 32) (Word 31 32)) (Word 1 32))) (Word 1 32)))) $;
	(* (unique, 0x1ca80, 4) INT_SUB (register, 0x4008, 4) , (unique, 0x1c980, 4) *)
	Move (V_TEMP 0x1ca80) (BinOp OP_MINUS (Extract 31 0 (Var R_X1)) (Var (V_TEMP 0x1c980))) $;
	(* (register, 0x107, 1) INT_SLESS (unique, 0x1ca80, 4) , (const, 0x0, 4) *)
	Move R_TMPNG (Cast CAST_UNSIGNED 8 (BinOp OP_SLT (Var (V_TEMP 0x1ca80)) (Word 0x0 32))) $;
	(* (register, 0x108, 1) INT_EQUAL (unique, 0x1ca80, 4) , (const, 0x0, 4) *)
	Move R_TMPZR (Cast CAST_UNSIGNED 8 (BinOp OP_EQ (Var (V_TEMP 0x1ca80)) (Word 0x0 32))) $;
	(* (register, 0x100, 1) COPY (register, 0x107, 1) *)
	Move R_NG (Var R_TMPNG) $;
	(* (register, 0x101, 1) COPY (register, 0x108, 1) *)
	Move R_ZR (Var R_TMPZR) $;
	(* (register, 0x102, 1) COPY (register, 0x105, 1) *)
	Move R_CY (Var R_TMPCY) $;
	(* (register, 0x103, 1) COPY (register, 0x106, 1) *)
	Move R_OV (Var R_TMPOV)
)

(* 0x00100034: b.eq 0x0010005c *)
(*    1048628: b.eq 0x0010005c *)
| 0x100034 => Some (4,
	(*  ---  CBRANCH (ram, 0x10005c, 8) , (register, 0x101, 1) *)
	If (Cast CAST_LOW 1 (Var R_ZR)) (
		Jmp (Word 0x10005c 64)
	) (* else *) (
		Nop
	)
)

(* 0x00100038: cbz x0,0x0010004c *)
(*    1048632: cbz x0,0x0010004c *)
| 0x100038 => Some (4,
	(* (unique, 0x18f80, 1) INT_EQUAL (register, 0x4000, 8) , (const, 0x0, 8) *)
	Move (V_TEMP 0x18f80) (BinOp OP_EQ (Var R_X0) (Word 0x0 64)) $;
	(*  ---  CBRANCH (ram, 0x10004c, 8) , (unique, 0x18f80, 1) *)
	If (Cast CAST_LOW 1 (Var (V_TEMP 0x18f80))) (
		Jmp (Word 0x10004c 64)
	) (* else *) (
		Nop
	)
)

(* 0x0010003c: sub x1,x0,#0x1 *)
(*    1048636: sub x1,x0,#0x1 *)
| 0x10003c => Some (4,
	(* (register, 0x4008, 8) INT_SUB (register, 0x4000, 8) , (const, 0x1, 8) *)
	Move R_X1 (BinOp OP_MINUS (Var R_X0) (Word 0x1 64))
)

(* 0x00100040: ldrb w2,[x19, x1, LSL ] *)
(*    1048640: ldrb w2,[x19, x1, LSL ] *)
| 0x100040 => Some (4,
	(* (unique, 0x5a00, 8) COPY (register, 0x4008, 8) *)
	Move (V_TEMP 0x5a00) (Var R_X1) $;
	(* (unique, 0x7100, 8) COPY (unique, 0x5a00, 8) *)
	Move (V_TEMP 0x7100) (Var (V_TEMP 0x5a00)) $;
	(* (unique, 0x7100, 8) INT_LEFT (unique, 0x7100, 8) , (const, 0x0, 8) *)
	Move (V_TEMP 0x7100) (BinOp OP_LSHIFT (Var (V_TEMP 0x7100)) (Word 0x0 64)) $;
	(* (unique, 0x7580, 8) INT_ADD (register, 0x4098, 8) , (unique, 0x7100, 8) *)
	Move (V_TEMP 0x7580) (BinOp OP_PLUS (Var R_X19) (Var (V_TEMP 0x7100))) $;
	(* (unique, 0x25600, 1) LOAD (const, 0x1b1, 8) , (unique, 0x7580, 8) *)
	Move (V_TEMP 0x25600) (Load (Var V_MEM64) (Var (V_TEMP 0x7580)) LittleE 1) $;
	(* (register, 0x4010, 8) INT_ZEXT (unique, 0x25600, 1) *)
	Move R_X2 (Cast CAST_UNSIGNED 64 (Var (V_TEMP 0x25600)))
)

(* 0x00100044: cmp w2,#0x2f *)
(*    1048644: cmp w2,#0x2f *)
| 0x100044 => Some (4,
	(* (unique, 0x1c980, 4) COPY (const, 0x2f, 4) *)
	Move (V_TEMP 0x1c980) (Word 0x2f 32) $;
	(* (register, 0x105, 1) INT_LESSEQUAL (const, 0x2f, 4) , (register, 0x4010, 4) *)
	Move R_TMPCY (Cast CAST_UNSIGNED 8 (BinOp OP_LE (Word 0x2f 32) (Extract 31 0 (Var R_X2)))) $;
	(* (register, 0x106, 1) INT_SBORROW (register, 0x4010, 4) , (const, 0x2f, 4) *)
	Move R_TMPOV (Cast CAST_LOW 8 (BinOp OP_AND (BinOp OP_XOR (BinOp OP_AND (BinOp OP_RSHIFT (Extract 31 0 (Var R_X2)) (Word 31 32)) (Word 1 32)) (BinOp OP_AND (BinOp OP_RSHIFT (BinOp OP_MINUS (Extract 31 0 (Var R_X2)) (Word 0x2f 32)) (Word 31 32)) (Word 1 32))) (BinOp OP_XOR (BinOp OP_XOR (BinOp OP_AND (BinOp OP_RSHIFT (BinOp OP_MINUS (Extract 31 0 (Var R_X2)) (Word 0x2f 32)) (Word 31 32)) (Word 1 32)) (BinOp OP_AND (BinOp OP_RSHIFT (Word 0x2f 32) (Word 31 32)) (Word 1 32))) (Word 1 32)))) $;
	(* (unique, 0x1ca80, 4) INT_SUB (register, 0x4010, 4) , (unique, 0x1c980, 4) *)
	Move (V_TEMP 0x1ca80) (BinOp OP_MINUS (Extract 31 0 (Var R_X2)) (Var (V_TEMP 0x1c980))) $;
	(* (register, 0x107, 1) INT_SLESS (unique, 0x1ca80, 4) , (const, 0x0, 4) *)
	Move R_TMPNG (Cast CAST_UNSIGNED 8 (BinOp OP_SLT (Var (V_TEMP 0x1ca80)) (Word 0x0 32))) $;
	(* (register, 0x108, 1) INT_EQUAL (unique, 0x1ca80, 4) , (const, 0x0, 4) *)
	Move R_TMPZR (Cast CAST_UNSIGNED 8 (BinOp OP_EQ (Var (V_TEMP 0x1ca80)) (Word 0x0 32))) $;
	(* (register, 0x100, 1) COPY (register, 0x107, 1) *)
	Move R_NG (Var R_TMPNG) $;
	(* (register, 0x101, 1) COPY (register, 0x108, 1) *)
	Move R_ZR (Var R_TMPZR) $;
	(* (register, 0x102, 1) COPY (register, 0x105, 1) *)
	Move R_CY (Var R_TMPCY) $;
	(* (register, 0x103, 1) COPY (register, 0x106, 1) *)
	Move R_OV (Var R_TMPOV)
)

(* 0x00100048: b.ne 0x00100064 *)
(*    1048648: b.ne 0x00100064 *)
| 0x100048 => Some (4,
	(* (unique, 0xa00, 1) BOOL_NEGATE (register, 0x101, 1) *)
	Move (V_TEMP 0xa00) (UnOp OP_NOT (Var R_ZR)) $;
	(*  ---  CBRANCH (ram, 0x100064, 8) , (unique, 0xa00, 1) *)
	If (Cast CAST_LOW 1 (Var (V_TEMP 0xa00))) (
		Jmp (Word 0x100064 64)
	) (* else *) (
		Nop
	)
)

(* 0x0010004c: add x0,x19,x0 *)
(*    1048652: add x0,x19,x0 *)
| 0x10004c => Some (4,
	(* (unique, 0x12380, 8) COPY (register, 0x4000, 8) *)
	Move (V_TEMP 0x12380) (Var R_X0) $;
	(* (register, 0x105, 1) INT_CARRY (register, 0x4098, 8) , (unique, 0x12380, 8) *)
	Move R_TMPCY (Cast CAST_UNSIGNED 8 (BinOp OP_LT (BinOp OP_PLUS (Var R_X19) (Var (V_TEMP 0x12380))) (Var R_X19))) $;
	(* (register, 0x106, 1) INT_SCARRY (register, 0x4098, 8) , (unique, 0x12380, 8) *)
	Move R_TMPOV (Cast CAST_LOW 8 (BinOp OP_AND (BinOp OP_XOR (BinOp OP_AND (BinOp OP_RSHIFT (BinOp OP_PLUS (Var R_X19) (Var (V_TEMP 0x12380))) (Word 63 64)) (Word 1 64)) (BinOp OP_AND (BinOp OP_RSHIFT (Var R_X19) (Word 63 64)) (Word 1 64))) (BinOp OP_XOR (BinOp OP_XOR (BinOp OP_AND (BinOp OP_RSHIFT (Var R_X19) (Word 63 64)) (Word 1 64)) (BinOp OP_AND (BinOp OP_RSHIFT (Var (V_TEMP 0x12380)) (Word 63 64)) (Word 1 64))) (Word 1 64)))) $;
	(* (unique, 0x12480, 8) INT_ADD (register, 0x4098, 8) , (unique, 0x12380, 8) *)
	Move (V_TEMP 0x12480) (BinOp OP_PLUS (Var R_X19) (Var (V_TEMP 0x12380))) $;
	(* (register, 0x107, 1) INT_SLESS (unique, 0x12480, 8) , (const, 0x0, 8) *)
	Move R_TMPNG (Cast CAST_UNSIGNED 8 (BinOp OP_SLT (Var (V_TEMP 0x12480)) (Word 0x0 64))) $;
	(* (register, 0x108, 1) INT_EQUAL (unique, 0x12480, 8) , (const, 0x0, 8) *)
	Move R_TMPZR (Cast CAST_UNSIGNED 8 (BinOp OP_EQ (Var (V_TEMP 0x12480)) (Word 0x0 64))) $;
	(* (register, 0x4000, 8) COPY (unique, 0x12480, 8) *)
	Move R_X0 (Var (V_TEMP 0x12480))
)

(* 0x00100050: ldr x19,[sp, #0x10] *)
(*    1048656: ldr x19,[sp, #0x10] *)
| 0x100050 => Some (4,
	(* (unique, 0x6500, 8) INT_ADD (register, 0x8, 8) , (const, 0x10, 8) *)
	Move (V_TEMP 0x6500) (BinOp OP_PLUS (Var R_SP) (Word 0x10 64)) $;
	(* (register, 0x4098, 8) LOAD (const, 0x1b1, 8) , (unique, 0x6500, 8) *)
	Move R_X19 (Load (Var V_MEM64) (Var (V_TEMP 0x6500)) LittleE 8)
)

(* 0x00100054: ldp x29,x30,[sp], #0x20 *)
(*    1048660: ldp x29,x30,[sp], #0x20 *)
| 0x100054 => Some (4,
	(* (unique, 0x7c80, 8) COPY (register, 0x8, 8) *)
	Move (V_TEMP 0x7c80) (Var R_SP) $;
	(* (register, 0x8, 8) INT_ADD (register, 0x8, 8) , (const, 0x20, 8) *)
	Move R_SP (BinOp OP_PLUS (Var R_SP) (Word 0x20 64)) $;
	(* (unique, 0x24680, 8) LOAD (const, 0x1b1, 8) , (unique, 0x7c80, 8) *)
	Move (V_TEMP 0x24680) (Load (Var V_MEM64) (Var (V_TEMP 0x7c80)) LittleE 8) $;
	(* (unique, 0x24700, 8) INT_ADD (unique, 0x7c80, 8) , (const, 0x8, 8) *)
	Move (V_TEMP 0x24700) (BinOp OP_PLUS (Var (V_TEMP 0x7c80)) (Word 0x8 64)) $;
	(* (unique, 0x24800, 8) LOAD (const, 0x1b1, 8) , (unique, 0x24700, 8) *)
	Move (V_TEMP 0x24800) (Load (Var V_MEM64) (Var (V_TEMP 0x24700)) LittleE 8) $;
	(* (register, 0x40e8, 8) COPY (unique, 0x24680, 8) *)
	Move R_X29 (Var (V_TEMP 0x24680)) $;
	(* (register, 0x40f0, 8) COPY (unique, 0x24800, 8) *)
	Move R_X30 (Var (V_TEMP 0x24800))
)

(* 0x00100058: ret *)
(*    1048664: ret *)
| 0x100058 => Some (4,
	(* (register, 0x0, 8) COPY (register, 0x40f0, 8) *)
	Move R_PC (Var R_X30) $;
	(*  ---  RETURN (register, 0x0, 8) *)
	Jmp (Var R_PC)
)

(* 0x0010005c: strb wzr,[x19, x0, LSL ] *)
(*    1048668: strb wzr,[x19, x0, LSL ] *)
| 0x10005c => Some (4,
	(* (unique, 0x300, 4) COPY (const, 0x0, 4) *)
	Move (V_TEMP 0x300) (Word 0x0 32) $;
	(* (unique, 0x3ab00, 4) COPY (unique, 0x300, 4) *)
	Move (V_TEMP 0x3ab00) (Var (V_TEMP 0x300)) $;
	(* (unique, 0x5a00, 8) COPY (register, 0x4000, 8) *)
	Move (V_TEMP 0x5a00) (Var R_X0) $;
	(* (unique, 0x7100, 8) COPY (unique, 0x5a00, 8) *)
	Move (V_TEMP 0x7100) (Var (V_TEMP 0x5a00)) $;
	(* (unique, 0x7100, 8) INT_LEFT (unique, 0x7100, 8) , (const, 0x0, 8) *)
	Move (V_TEMP 0x7100) (BinOp OP_LSHIFT (Var (V_TEMP 0x7100)) (Word 0x0 64)) $;
	(* (unique, 0x7580, 8) INT_ADD (register, 0x4098, 8) , (unique, 0x7100, 8) *)
	Move (V_TEMP 0x7580) (BinOp OP_PLUS (Var R_X19) (Var (V_TEMP 0x7100))) $;
	(* (unique, 0x3ab80, 1) SUBPIECE (unique, 0x3ab00, 4) , (const, 0x0, 4) *)
	Move (V_TEMP 0x3ab80) (Cast CAST_LOW 8 (BinOp OP_RSHIFT (Var (V_TEMP 0x3ab00)) (Word 0 32))) $;
	(*  ---  STORE (const, 0x1b1, 8) , (unique, 0x7580, 8) , (unique, 0x3ab80, 1) *)
	Move V_MEM64 (Store (Var V_MEM64) (Var (V_TEMP 0x7580)) (Cast CAST_LOW 8 (Var (V_TEMP 0x3ab80))) LittleE 1)
)

(* 0x00100060: b 0x00100024 *)
(*    1048672: b 0x00100024 *)
| 0x100060 => Some (4,
	(*  ---  BRANCH (ram, 0x100024, 8) *)
	Jmp (Word 0x100024 64)
)

(* 0x00100064: mov x0,x1 *)
(*    1048676: mov x0,x1 *)
| 0x100064 => Some (4,
	(* (register, 0x4000, 8) COPY (register, 0x4008, 8) *)
	Move R_X0 (Var R_X1)
)

(* 0x00100068: b 0x00100038 *)
(*    1048680: b 0x00100038 *)
| 0x100068 => Some (4,
	(*  ---  BRANCH (ram, 0x100038, 8) *)
	Jmp (Word 0x100038 64)
)

(* 0x0010006c: adrp x0,0x100000 *)
(*    1048684: adrp x0,0x100000 *)
| 0x10006c => Some (4,
	(* (register, 0x4000, 8) COPY (const, 0x100000, 8) *)
	Move R_X0 (Word 0x100000 64)
)

(* 0x00100070: add x0,x0,#0x0 *)
(*    1048688: add x0,x0,#0x0 *)
| 0x100070 => Some (4,
	(* (unique, 0x11e80, 8) COPY (const, 0x0, 8) *)
	Move (V_TEMP 0x11e80) (Word 0x0 64) $;
	(* (register, 0x105, 1) INT_CARRY (register, 0x4000, 8) , (unique, 0x11e80, 8) *)
	Move R_TMPCY (Cast CAST_UNSIGNED 8 (BinOp OP_LT (BinOp OP_PLUS (Var R_X0) (Var (V_TEMP 0x11e80))) (Var R_X0))) $;
	(* (register, 0x106, 1) INT_SCARRY (register, 0x4000, 8) , (unique, 0x11e80, 8) *)
	Move R_TMPOV (Cast CAST_LOW 8 (BinOp OP_AND (BinOp OP_XOR (BinOp OP_AND (BinOp OP_RSHIFT (BinOp OP_PLUS (Var R_X0) (Var (V_TEMP 0x11e80))) (Word 63 64)) (Word 1 64)) (BinOp OP_AND (BinOp OP_RSHIFT (Var R_X0) (Word 63 64)) (Word 1 64))) (BinOp OP_XOR (BinOp OP_XOR (BinOp OP_AND (BinOp OP_RSHIFT (Var R_X0) (Word 63 64)) (Word 1 64)) (BinOp OP_AND (BinOp OP_RSHIFT (Var (V_TEMP 0x11e80)) (Word 63 64)) (Word 1 64))) (Word 1 64)))) $;
	(* (unique, 0x11f80, 8) INT_ADD (register, 0x4000, 8) , (unique, 0x11e80, 8) *)
	Move (V_TEMP 0x11f80) (BinOp OP_PLUS (Var R_X0) (Var (V_TEMP 0x11e80))) $;
	(* (register, 0x107, 1) INT_SLESS (unique, 0x11f80, 8) , (const, 0x0, 8) *)
	Move R_TMPNG (Cast CAST_UNSIGNED 8 (BinOp OP_SLT (Var (V_TEMP 0x11f80)) (Word 0x0 64))) $;
	(* (register, 0x108, 1) INT_EQUAL (unique, 0x11f80, 8) , (const, 0x0, 8) *)
	Move R_TMPZR (Cast CAST_UNSIGNED 8 (BinOp OP_EQ (Var (V_TEMP 0x11f80)) (Word 0x0 64))) $;
	(* (register, 0x4000, 8) COPY (unique, 0x11f80, 8) *)
	Move R_X0 (Var (V_TEMP 0x11f80))
)

(* 0x00100074: ret *)
(*    1048692: ret *)
| 0x100074 => Some (4,
	(* (register, 0x0, 8) COPY (register, 0x40f0, 8) *)
	Move R_PC (Var R_X30) $;
	(*  ---  RETURN (register, 0x0, 8) *)
	Jmp (Var R_PC)
)

(* 0x00100078: adrp x0,0x100000 *)
(*    1048696: adrp x0,0x100000 *)
| 0x100078 => Some (4,
	(* (register, 0x4000, 8) COPY (const, 0x100000, 8) *)
	Move R_X0 (Word 0x100000 64)
)

(* 0x0010007c: add x0,x0,#0x0 *)
(*    1048700: add x0,x0,#0x0 *)
| 0x10007c => Some (4,
	(* (unique, 0x11e80, 8) COPY (const, 0x0, 8) *)
	Move (V_TEMP 0x11e80) (Word 0x0 64) $;
	(* (register, 0x105, 1) INT_CARRY (register, 0x4000, 8) , (unique, 0x11e80, 8) *)
	Move R_TMPCY (Cast CAST_UNSIGNED 8 (BinOp OP_LT (BinOp OP_PLUS (Var R_X0) (Var (V_TEMP 0x11e80))) (Var R_X0))) $;
	(* (register, 0x106, 1) INT_SCARRY (register, 0x4000, 8) , (unique, 0x11e80, 8) *)
	Move R_TMPOV (Cast CAST_LOW 8 (BinOp OP_AND (BinOp OP_XOR (BinOp OP_AND (BinOp OP_RSHIFT (BinOp OP_PLUS (Var R_X0) (Var (V_TEMP 0x11e80))) (Word 63 64)) (Word 1 64)) (BinOp OP_AND (BinOp OP_RSHIFT (Var R_X0) (Word 63 64)) (Word 1 64))) (BinOp OP_XOR (BinOp OP_XOR (BinOp OP_AND (BinOp OP_RSHIFT (Var R_X0) (Word 63 64)) (Word 1 64)) (BinOp OP_AND (BinOp OP_RSHIFT (Var (V_TEMP 0x11e80)) (Word 63 64)) (Word 1 64))) (Word 1 64)))) $;
	(* (unique, 0x11f80, 8) INT_ADD (register, 0x4000, 8) , (unique, 0x11e80, 8) *)
	Move (V_TEMP 0x11f80) (BinOp OP_PLUS (Var R_X0) (Var (V_TEMP 0x11e80))) $;
	(* (register, 0x107, 1) INT_SLESS (unique, 0x11f80, 8) , (const, 0x0, 8) *)
	Move R_TMPNG (Cast CAST_UNSIGNED 8 (BinOp OP_SLT (Var (V_TEMP 0x11f80)) (Word 0x0 64))) $;
	(* (register, 0x108, 1) INT_EQUAL (unique, 0x11f80, 8) , (const, 0x0, 8) *)
	Move R_TMPZR (Cast CAST_UNSIGNED 8 (BinOp OP_EQ (Var (V_TEMP 0x11f80)) (Word 0x0 64))) $;
	(* (register, 0x4000, 8) COPY (unique, 0x11f80, 8) *)
	Move R_X0 (Var (V_TEMP 0x11f80))
)

(* 0x00100080: b 0x00100050 *)
(*    1048704: b 0x00100050 *)
| 0x100080 => Some (4,
	(*  ---  BRANCH (ram, 0x100050, 8) *)
	Jmp (Word 0x100050 64)
)

(* begin strlen *)
(* 0x00200000: mov x1,x0 *)
| 0x200000 => Some (4,
	Move R_X1 (Var R_X0)
)

(* 0x00200004: tst x1,#0x7 *)
| 0x200004 => Some (4,
	Move (V_TEMP 0x3ff00) (BinOp OP_AND (Var R_X1) (Word 0x7 64)) $;
	Move R_TMPNG (Cast CAST_UNSIGNED 8 (BinOp OP_SLT (Var (V_TEMP 0x3ff00)) (Word 0x0 64))) $;
	Move R_TMPZR (Cast CAST_UNSIGNED 8 (BinOp OP_EQ (Var (V_TEMP 0x3ff00)) (Word 0x0 64))) $;
	Move R_NG (Var R_TMPNG) $;
	Move R_ZR (Var R_TMPZR) $;
	Move R_CY (Word 0x0 8) $;
	Move R_OV (Word 0x0 8)
)

(* 0x00200008: b.ne 0x00200038 *)
| 0x200008 => Some (4,
	Move (V_TEMP 0xa00) (UnOp OP_NOT (Var R_ZR)) $;
	If (Cast CAST_LOW 1 (Var (V_TEMP 0xa00))) (
		Jmp (Word 0x200038 64)
	) (* else *) (
		Nop
	)
)

(* 0x0020000c: orr x4,xzr,#-0x101010101010102 *)
| 0x20000c => Some (4,
	Move (V_TEMP 0x580) (Word 0x0 64) $;
	Move R_X4 (BinOp OP_OR (Var (V_TEMP 0x580)) (Word 0xfefefefefefefefe 64))
)

(* 0x00200010: movk x4,#0xfeff *)
| 0x200010 => Some (4,
	Move R_X4 (BinOp OP_AND (Var R_X4) (Word 0xffffffffffff0000 64)) $;
	Move R_X4 (BinOp OP_OR (Var R_X4) (Word 0xfeff 64))
)

(* 0x00200014: ldr x2,[x1] *)
| 0x200014 => Some (4,
	Move (V_TEMP 0x6800) (Var R_X1) $;
	Move R_X2 (Load (Var V_MEM64) (Var (V_TEMP 0x6800)) LittleE 8)
)

(* 0x00200018: add x3,x2,x4 *)
| 0x200018 => Some (4,
	Move (V_TEMP 0x12380) (Var R_X4) $;
	Move R_TMPCY (Cast CAST_UNSIGNED 8 (BinOp OP_LT (BinOp OP_PLUS (Var R_X2) (Var (V_TEMP 0x12380))) (Var R_X2))) $;
	Move R_TMPOV (Cast CAST_LOW 8 (BinOp OP_AND (BinOp OP_XOR (BinOp OP_AND (BinOp OP_RSHIFT (BinOp OP_PLUS (Var R_X2) (Var (V_TEMP 0x12380))) (Word 63 64)) (Word 1 64)) (BinOp OP_AND (BinOp OP_RSHIFT (Var R_X2) (Word 63 64)) (Word 1 64))) (BinOp OP_XOR (BinOp OP_XOR (BinOp OP_AND (BinOp OP_RSHIFT (Var R_X2) (Word 63 64)) (Word 1 64)) (BinOp OP_AND (BinOp OP_RSHIFT (Var (V_TEMP 0x12380)) (Word 63 64)) (Word 1 64))) (Word 1 64)))) $;
	Move (V_TEMP 0x12480) (BinOp OP_PLUS (Var R_X2) (Var (V_TEMP 0x12380))) $;
	Move R_TMPNG (Cast CAST_UNSIGNED 8 (BinOp OP_SLT (Var (V_TEMP 0x12480)) (Word 0x0 64))) $;
	Move R_TMPZR (Cast CAST_UNSIGNED 8 (BinOp OP_EQ (Var (V_TEMP 0x12480)) (Word 0x0 64))) $;
	Move R_X3 (Var (V_TEMP 0x12480))
)

(* 0x0020001c: bic x2,x3,x2 *)
| 0x20001c => Some (4,
	Move (V_TEMP 0x16200) (UnOp OP_NEG (Word 0x1 64)) $;
	Move (V_TEMP 0x16300) (BinOp OP_XOR (Var R_X2) (Var (V_TEMP 0x16200))) $;
	Move R_X2 (BinOp OP_AND (Var R_X3) (Var (V_TEMP 0x16300)))
)

(* 0x00200020: tst x2,#-0x7f7f7f7f7f7f7f80 *)
| 0x200020 => Some (4,
	Move (V_TEMP 0x3ff00) (BinOp OP_AND (Var R_X2) (Word 0x8080808080808080 64)) $;
	Move R_TMPNG (Cast CAST_UNSIGNED 8 (BinOp OP_SLT (Var (V_TEMP 0x3ff00)) (Word 0x0 64))) $;
	Move R_TMPZR (Cast CAST_UNSIGNED 8 (BinOp OP_EQ (Var (V_TEMP 0x3ff00)) (Word 0x0 64))) $;
	Move R_NG (Var R_TMPNG) $;
	Move R_ZR (Var R_TMPZR) $;
	Move R_CY (Word 0x0 8) $;
	Move R_OV (Word 0x0 8)
)

(* 0x00200024: b.eq 0x00200050 *)
| 0x200024 => Some (4,
	If (Cast CAST_LOW 1 (Var R_ZR)) (
		Jmp (Word 0x200050 64)
	) (* else *) (
		Nop
	)
)

(* 0x00200028: ldrb w2,[x1] *)
| 0x200028 => Some (4,
	Move (V_TEMP 0x6680) (Var R_X1) $;
	Move (V_TEMP 0x25500) (Load (Var V_MEM64) (Var (V_TEMP 0x6680)) LittleE 1) $;
	Move R_X2 (Cast CAST_UNSIGNED 64 (Var (V_TEMP 0x25500)))
)

(* 0x0020002c: cbz w2,0x00200040 *)
| 0x20002c => Some (4,
	Move (V_TEMP 0x18f00) (Cast CAST_UNSIGNED 8 (BinOp OP_EQ (Extract 31 0 (Var R_X2)) (Word 0x0 32))) $;
	If (Cast CAST_LOW 1 (Var (V_TEMP 0x18f00))) (
		Jmp (Word 0x200040 64)
	) (* else *) (
		Nop
	)
)

(* 0x00200030: add x1,x1,#0x1 *)
| 0x200030 => Some (4,
	Move (V_TEMP 0x11e80) (Word 0x1 64) $;
	Move R_TMPCY (Cast CAST_UNSIGNED 8 (BinOp OP_LT (BinOp OP_PLUS (Var R_X1) (Var (V_TEMP 0x11e80))) (Var R_X1))) $;
	Move R_TMPOV (Cast CAST_LOW 8 (BinOp OP_AND (BinOp OP_XOR (BinOp OP_AND (BinOp OP_RSHIFT (BinOp OP_PLUS (Var R_X1) (Var (V_TEMP 0x11e80))) (Word 63 64)) (Word 1 64)) (BinOp OP_AND (BinOp OP_RSHIFT (Var R_X1) (Word 63 64)) (Word 1 64))) (BinOp OP_XOR (BinOp OP_XOR (BinOp OP_AND (BinOp OP_RSHIFT (Var R_X1) (Word 63 64)) (Word 1 64)) (BinOp OP_AND (BinOp OP_RSHIFT (Var (V_TEMP 0x11e80)) (Word 63 64)) (Word 1 64))) (Word 1 64)))) $;
	Move (V_TEMP 0x11f80) (BinOp OP_PLUS (Var R_X1) (Var (V_TEMP 0x11e80))) $;
	Move R_TMPNG (Cast CAST_UNSIGNED 8 (BinOp OP_SLT (Var (V_TEMP 0x11f80)) (Word 0x0 64))) $;
	Move R_TMPZR (Cast CAST_UNSIGNED 8 (BinOp OP_EQ (Var (V_TEMP 0x11f80)) (Word 0x0 64))) $;
	Move R_X1 (Var (V_TEMP 0x11f80))
)

(* 0x00200034: b 0x00200028 *)
| 0x200034 => Some (4,
	Jmp (Word 0x200028 64)
)

(* 0x00200038: ldrb w2,[x1] *)
| 0x200038 => Some (4,
	Move (V_TEMP 0x6680) (Var R_X1) $;
	Move (V_TEMP 0x25500) (Load (Var V_MEM64) (Var (V_TEMP 0x6680)) LittleE 1) $;
	Move R_X2 (Cast CAST_UNSIGNED 64 (Var (V_TEMP 0x25500)))
)

(* 0x0020003c: cbnz w2,0x00200048 *)
| 0x20003c => Some (4,
	Move (V_TEMP 0x18e00) (Cast CAST_UNSIGNED 8 (BinOp OP_NEQ (Extract 31 0 (Var R_X2)) (Word 0x0 32))) $;
	If (Cast CAST_LOW 1 (Var (V_TEMP 0x18e00))) (
		Jmp (Word 0x200048 64)
	) (* else *) (
		Nop
	)
)

(* 0x00200040: sub x0,x1,x0 *)
| 0x200040 => Some (4,
	Move R_X0 (BinOp OP_MINUS (Var R_X1) (Var R_X0))
)

(* 0x00200044: ret *)
| 0x200044 => Some (4,
	Move R_PC (Var R_X30) $;
	Jmp (Var R_PC)
)

(* 0x00200048: add x1,x1,#0x1 *)
| 0x200048 => Some (4,
	Move (V_TEMP 0x11e80) (Word 0x1 64) $;
	Move R_TMPCY (Cast CAST_UNSIGNED 8 (BinOp OP_LT (BinOp OP_PLUS (Var R_X1) (Var (V_TEMP 0x11e80))) (Var R_X1))) $;
	Move R_TMPOV (Cast CAST_LOW 8 (BinOp OP_AND (BinOp OP_XOR (BinOp OP_AND (BinOp OP_RSHIFT (BinOp OP_PLUS (Var R_X1) (Var (V_TEMP 0x11e80))) (Word 63 64)) (Word 1 64)) (BinOp OP_AND (BinOp OP_RSHIFT (Var R_X1) (Word 63 64)) (Word 1 64))) (BinOp OP_XOR (BinOp OP_XOR (BinOp OP_AND (BinOp OP_RSHIFT (Var R_X1) (Word 63 64)) (Word 1 64)) (BinOp OP_AND (BinOp OP_RSHIFT (Var (V_TEMP 0x11e80)) (Word 63 64)) (Word 1 64))) (Word 1 64)))) $;
	Move (V_TEMP 0x11f80) (BinOp OP_PLUS (Var R_X1) (Var (V_TEMP 0x11e80))) $;
	Move R_TMPNG (Cast CAST_UNSIGNED 8 (BinOp OP_SLT (Var (V_TEMP 0x11f80)) (Word 0x0 64))) $;
	Move R_TMPZR (Cast CAST_UNSIGNED 8 (BinOp OP_EQ (Var (V_TEMP 0x11f80)) (Word 0x0 64))) $;
	Move R_X1 (Var (V_TEMP 0x11f80))
)

(* 0x0020004c: b 0x00200004 *)
| 0x20004c => Some (4,
	Jmp (Word 0x200004 64)
)

(* 0x00200050: add x1,x1,#0x8 *)
| 0x200050 => Some (4,
	Move (V_TEMP 0x11e80) (Word 0x8 64) $;
	Move R_TMPCY (Cast CAST_UNSIGNED 8 (BinOp OP_LT (BinOp OP_PLUS (Var R_X1) (Var (V_TEMP 0x11e80))) (Var R_X1))) $;
	Move R_TMPOV (Cast CAST_LOW 8 (BinOp OP_AND (BinOp OP_XOR (BinOp OP_AND (BinOp OP_RSHIFT (BinOp OP_PLUS (Var R_X1) (Var (V_TEMP 0x11e80))) (Word 63 64)) (Word 1 64)) (BinOp OP_AND (BinOp OP_RSHIFT (Var R_X1) (Word 63 64)) (Word 1 64))) (BinOp OP_XOR (BinOp OP_XOR (BinOp OP_AND (BinOp OP_RSHIFT (Var R_X1) (Word 63 64)) (Word 1 64)) (BinOp OP_AND (BinOp OP_RSHIFT (Var (V_TEMP 0x11e80)) (Word 63 64)) (Word 1 64))) (Word 1 64)))) $;
	Move (V_TEMP 0x11f80) (BinOp OP_PLUS (Var R_X1) (Var (V_TEMP 0x11e80))) $;
	Move R_TMPNG (Cast CAST_UNSIGNED 8 (BinOp OP_SLT (Var (V_TEMP 0x11f80)) (Word 0x0 64))) $;
	Move R_TMPZR (Cast CAST_UNSIGNED 8 (BinOp OP_EQ (Var (V_TEMP 0x11f80)) (Word 0x0 64))) $;
	Move R_X1 (Var (V_TEMP 0x11f80))
)

(* 0x00200054: b 0x00200014 *)
| 0x200054 => Some (4,
	Jmp (Word 0x200014 64)
)


| _ => None
end.


(* * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 *                                                         *
 *                  Well-typed Theorem                     *
 *                                                         *
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *)

Theorem welltyped: welltyped_prog arm8typctx basename.
Proof. Picinae_typecheck. Qed.