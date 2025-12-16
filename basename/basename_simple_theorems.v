Require Import Picinae_armv8.
Require Import NArith.
Require Import Lia.
Open Scope N.
Require Import Picinae.basename.basename.
Import ARM8Notations.

(* The ARMv8 lifter models non-writable code. *)
Theorem strcasecmp_nwc:
	forall s2 s1, basename s1 = basename s2.
Proof.
	reflexivity.
Qed.

Section Invariants.

  Variable sp : N          (* initial stack pointer *).
  Variable mem : memory    (* initial memory state *).
  Variable raddr : N       (* return address (R_X30) *).
  Variable arg1 : N        (* first argument *).

  Definition mem' fbytes := setmem 64 LittleE 40 mem (sp ⊖ 48) fbytes.
  Definition mem'' k p sbytes fbytes := setmem 64 LittleE k (mem' fbytes) p sbytes.

  Definition postcondition (s:store) :=
      (arg1 <> 0 -> 
      (s R_X0 = arg1 \/ (s V_MEM64)Ⓑ[(s R_X0)⊖1]=47)).

  (* Invariant sets f for multi-subroutine properties have the following signature:
        f (T:Type) (Invs Post: inv_type T) (NoInv:T) (s:store) (a:addr) : T
     where inv_type T = N -> Prop -> T.  They thereby map addresses a:addr to
     internal invariants (Invs n P), post-conditions (Post n P), or no-invariant (NoInv),
     where n:N is a subroutine identifier number and P:Prop is the invariant.
     Polymorphic parameters Invs, Post, and NoInv act like constructors of return type T.
     Property P usually references store s, and is therefore a property of s.
     Identifiers n are unique to each subroutine in the code, and establish a
     partial order over subroutines:  A caller with identifier m may use Picinae's
     perform_call theorem to call a callee with identifier n whenever m > n.
     (To verify mutually recursive nests of subroutines, they must be assigned a
     common identifier and verified as a single recursive subroutine.)

     Note that because of the "Variable" declarations above, the following invariant
     set definition "invs" actually has extra initial hidden parameters, one for each
     sectional Variable it references:
       invs sp mem raddr ... T Inv Post NoInv s a
     It therefore actually defines an invariant set family, one invariant set for each
     possible instantiation of the Variable parameters before T.  To allow a caller to
     call a callee with a different invariant set from the same family using perform_call,
     the two invariant sets f and g must satisfy (same_invset_family f g), which stipulates
     that f and g agree on whether an internal invariant or post-condition exists at each
     address, though they may differ on what the invariant P is.  The same_invset_family
     obligation is provable by reflexivity as long as your definition only refers to
     (hidden) parameters before T within the P arguments of Inv and Post. *)
  Definition invs T (Inv Post: inv_type T) (NoInv:T) (s:store) (a:addr) : T :=
    match a with
    (* basename entry point and loop invariant *)
    | 0x100038 => Inv 1 (
        s V_MEM64 = mem /\ s R_X19 = arg1
      )

    (* basename return site 1 (null)*)
    | 0x100074 => Post 1 (postcondition s)

    (* basename return site 2 main cases*)
    | 0x100058 => Post 1 (postcondition s)


    | _ => NoInv
    end.

  (* Picinae's helper functions make_exits and make_invs are next leveraged to
     define appropriate invariant sets for each subroutine by extracting them
     from the above.  Note that these definitions receive the same extra hidden
     parameters as invs above, so are actually invariant set families. *)
  Definition exits1 := make_exits 1 basename invs.
  Definition invs1 := make_invs 1 basename invs.


End Invariants.

(* Create a step tactic that prints a progress message (for demos). *)
Ltac step := time arm8_step.

(* Now prove correctness of the main basename subroutine,
   using our earlier proof of tolower at subroutine calls. *)
Theorem basename_partial_correctness:
  forall s sp mem t s' x' arg1 arg2 a'
         (ENTRY: startof t (x',s') = (Addr 0x100038, s))
         (MDL: models arm8typctx s)
         (SP: s R_SP = sp) (MEM: s V_MEM64 = mem) (X30: s R_X30 = a')
         (RX0: s R_X19 = arg1) (RX1: s R_X1 = arg2),
  satisfies_all basename (invs1  mem arg1)
                           (exits1 mem arg1) ((x',s')::t).
Proof.
  (* Use prove_invs to initiate a proof by induction. *)
  intros. apply prove_invs.

  (* Base case: The invariant at the subroutine entry point is satisfied. *)
  simpl. rewrite ENTRY. step. repeat split; assumption.

  (* Change assumptions about s into assumptions about s1. *)
  intros.
  erewrite startof_prefix in ENTRY; try eassumption.
  eapply models_at_invariant; try eassumption. apply welltyped. intro MDL1.
  set (x20 := s R_X20) in *. set (x21 := s R_X21) in *. clearbody x20 x21.
  clear - PRE MDL1. rename t1 into t. rename s1 into s. rename MDL1 into MDL.

  (* Break the proof into cases, one for each internal invariant-point. *)
  destruct_inv 64 PRE.

  (* Address 1048576: strcasecmp entry point *)
  destruct PRE as (MEM & X0).

  (* case 1: entry -> index 0 exit*)
  step. step. step. step.
  intros. left. apply Neqb_ok in BC. rewrite BC. psimpl. reflexivity.

  (* case 2: entry -> prev char is slash *)
  step. step. step. step. step. step. step.
  intro. right. apply Neqb_ok in BC0. assumption.


  (* case 3: loop invariant -> entry *)
  step. step.
  split; reflexivity.

Qed.
         


