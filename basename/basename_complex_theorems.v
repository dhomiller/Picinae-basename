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

Definition nilfree (m:memory) (p:addr) (k:N) := forall i, i < k -> m Ⓑ[p+i] <> 0.

Definition empty (m:memory) (p:addr) := m Ⓑ[p] = 0.

(* Define string length correctness *)
Definition strlen (m:memory) (p:addr) (k:N) :=
  nilfree m p k /\ 0 = m Ⓑ[p+k].

(* Define binary length-bounded string equality. *)
(*Definition memeq (m1 m2:memory) (p1 p2: addr) (k: N) :=
  forall i, i < k -> tolower (m Ⓑ[p1+i]) = tolower (m Ⓑ[p2+i]) /\ 0 < m Ⓑ[p1+i].*)

Section Invariants.

  Variable sp : N          (* initial stack pointer *).
  Variable mem : memory    (* initial memory state *).
  Variable raddr : N       (* return address (R_X30) *).
  Variable arg1 : N        (* strcasecmp: 1st pointer arg (R_X0)
                              tolower: input character (R_X0) *).
  Variable x19 x20 x21 : N     (* tolower: R_X20, R_X21 (callee-save regs) *).

  Definition mem' fbytes := setmem 64 LittleE 24 mem (sp ⊖ 32) fbytes.
  Definition mem'' k p sbytes fbytes := setmem 64 LittleE k (mem' fbytes) p sbytes.

  (* The post-condition says that interpreting x0 as a signed integer z
     whose sign equals the comparison of the kth byte in the two input
     strings, where the two strings are identical before k, and z may only be
     zero if the kth bytes are both nil. *)
  Definition postcondition (s:store) :=
    exists fb,
    arg1 <> 0 -> 
    ((mem' fb)Ⓑ[arg1] <> 0) ->
      (arg1 < (sp ⊖ 48) \/ arg1 > sp) /\ not (nilfree (mem' fb) arg1 (sp ⊖ 48 ⊖ arg1)) ->
        (s R_X0 = arg1 \/ (mem' fb)Ⓑ[(s R_X0)-1]=47).

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
    (* basename entry point *)
    | 1048580 => Inv 1 (
        s R_SP = sp /\ s V_MEM64 = mem /\ s R_X0 = arg1
      )

    (* loop invariant *)
    | 0x100028 => Inv 1 ((*exists p k (*fb*),
        s R_X0 = p-1 /\
        strlen mem p k (*/\
        s V_MEM64 = mem'' k p sb fb*)
      *) True)

    (* loop invariant *)
    | 0x100038 => Inv 1 (exists p k (*fb*),
        s R_X0 = p /\
        strlen mem p k (*/\
        s V_MEM64 = mem'' k p sb fb*)
      )

    (* basename return site 1 (null)*)
    | 0x100074 => Post 1 (postcondition s)

    (* basename return site 2 main cases*)
    | 0x100058 => Post 1 (postcondition s)

    (* strlen entry point *)
    | 0x200000 => Inv 0 (s R_X0 = arg1 /\
         s R_X19 = x19 /\ s R_X20 = x20 /\ s R_X21 = x21 /\
         s R_X30 = raddr /\ s R_SP = sp /\ s V_MEM64 = mem)

    (* strlen return point *)
    | 0x200044 => Post 0 (strlen mem arg1 (s R_X0) /\
         s R_X19 = x19 /\ s R_X20 = x20 /\ s R_X21 = x21 /\
         s R_X30 = raddr /\ s R_SP = sp /\ s V_MEM64 = mem)

    | _ => NoInv
    end.

  (* Picinae's helper functions make_exits and make_invs are next leveraged to
     define appropriate invariant sets for each subroutine by extracting them
     from the above.  Note that these definitions receive the same extra hidden
     parameters as invs above, so are actually invariant set families. *)
  Definition exits0 := make_exits 0 basename invs.
  Definition invs0 := make_invs 0 basename invs.
  Definition exits1 := make_exits 1 basename invs.
  Definition invs1 := make_invs 1 basename invs.

End Invariants.

(* Create a step tactic that prints a progress message (for demos). *)
Ltac step := time arm8_step.

(* Prove that each subroutine satisfies the invariant set, starting with callees
   and proceeding to callers.  In this case, we start with subroutine strlen: *)
Theorem strlen_correctness:
  forall s sp mem t xs' arg1 arg2 a'
         (ENTRY: startof t xs' = (Addr 0x200000, s))
         (MDL: models arm8typctx s)
         (SP: s R_SP = sp) (MEM: s V_MEM64 = mem)
         (X0: s R_X0 = arg1) (X19: s R_X19 = arg2)
         (X30: s R_X30 = a'),
  satisfies_all basename (invs0  sp mem a' arg1 arg2 (s R_X20) (s R_X21))
                           (exits0 sp mem a' arg1 arg2 (s R_X20) (s R_X21)) (xs'::t).
Proof.
(*
(* Use prove_invs to initiate a proof by induction. *)
  intros. apply prove_invs.

(* Base case: The invariant at the subroutine entry point is satisfied. *)
  simpl. rewrite ENTRY. step. repeat split; assumption.

intros.
  erewrite startof_prefix in ENTRY; try eassumption.
  eapply models_at_invariant; try eassumption. apply welltyped. intro MDL1.
  clear - PRE MDL1. rename t1 into t.

(* Break the proof into cases, one for each internal invariant-point. *)
  destruct_inv 64 PRE.

destruct PRE as (X0 & X19 & X20 & X21 & X30 & SP & MEM).
  step. step. step.
*)
Admitted.

(* Now prove correctness of the main basename subroutine,
   using our earlier proof of tolower at subroutine calls. *)
Theorem basename_partial_correctness:
  forall s sp mem t s' x' arg1 arg2 a'
         (ENTRY: startof t (x',s') = (Addr 0x100004, s))
         (MDL: models arm8typctx s)
         (SP: s R_SP = sp) (MEM: s V_MEM64 = mem) (X30: s R_X30 = a')
         (RX0: s R_X0 = arg1) (RX1: s R_X1 = arg2),
  satisfies_all basename (invs1  sp mem a' arg1 arg2 (s R_X20) (s R_X21))
                           (exits1 sp mem a' arg1 arg2 (s R_X20) (s R_X21)) ((x',s')::t).
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
  destruct PRE as (SP & MEM & X0).

  (* case 1: nullptr*)
  step. step. step. exists 0. intros. destruct H. apply Neqb_ok in BC. rewrite BC. reflexivity.

  (* case 2: empty string *)
  step. step. step. step. step. 
  generalize_frame mem as fb. (*modified memory*)
  step. step. step. step. step. step. exists fb. intros. apply Neqb_ok in BC0. psimpl in H0. destruct H1. destruct H0. assumption.

  (* case 3: legit string *)
        step.
        set (s1 := update _ _ _).
        eapply models_after_steps. eassumption. apply welltyped. intro MDL1.
        eapply (perform_call 0). reflexivity.
        intros. eapply strlen_correctness; (eassumption || reflexivity).
        reflexivity.

  (* Clean up the proof context after the call by creating hypotheses
           about the post-call cpu state s1 and discarding hypotheses about
           old cpu states. *)
        intros.
        unfold s1 in PRE. psimpl in PRE.
        assert (MDL': models arm8typctx s').
          eapply preservation_exec_prog; try eassumption.
          apply welltyped.
        set (t' := t2++t0++_::t) in *. clearbody s1 t'.
        set (x21' := s R_X21) in PRE. clearbody x21'.
        clear - BC BC0 PRE MDL'.
        rename MDL' into MDL. rename t' into t. rename a'0 into a.

  (* Separate the proof into one subgoal for each subroutine exit point.
           (In the case of strlen, there's only one exit point. *)
        destruct_inv 64 PRE.

        destruct PRE as (X0 & X19 & X20 & X21 & X30 & SP & MEM).
        clear X21 x21'. (* This particular call site ignores x21, so delete it. *)

  (* reached invariant. strlen is called. *)
Admitted.
  
        
         