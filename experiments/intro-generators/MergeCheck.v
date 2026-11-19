From QuickChick Require Import QuickChick.
From Stdlib Require Import Arith Lia.

Inductive F : nat -> Prop :=
| F0 : F 0
| FS : forall x, F x -> F (S (S x)).
Inductive G : nat -> Prop :=
| G0 : G 0
| GS : forall x, G x -> G (S (S (S x))).

Merge (fun x => F x) With (fun x => G x) As ToolMerged.
Print ToolMerged.

(* Exact relation displayed in the manuscript. *)
Inductive PaperMerged : nat -> Prop :=
| M0 : PaperMerged 0
| MS : forall x, G x -> F (S x) -> PaperMerged (S (S (S x))).

Theorem tool_matches_paper : forall x, ToolMerged x <-> PaperMerged x.
Proof.
  intro x; split; intro H; destruct H; econstructor; eauto.
Qed.

Inductive Goal : nat -> Prop :=
| GoalI : forall x, F x -> G x -> Goal x.
Inductive Agentic : nat -> Prop :=
| Six0 : Agentic 0
| SixS : forall x, Agentic x -> Agentic (S (S (S (S (S (S x)))))).

Theorem merged_matches_goal : forall x, PaperMerged x <-> Goal x.
Proof.
  intro x; split.
  - intro H; destruct H as [|x HG HF].
    + constructor; constructor.
    + constructor; now constructor.
  - intro H; destruct H as [x HF HG].
    destruct HG as [|x HG].
    + constructor.
    + apply MS; [exact HG|]. inversion HF; assumption.
Qed.

Lemma F_multiple : forall x, F x -> exists k, x = 2 * k.
Proof.
  intros x H; induction H as [|x H [k IH]].
  - exists 0; reflexivity.
  - exists (S k); lia.
Qed.
Lemma G_multiple : forall x, G x -> exists k, x = 3 * k.
Proof.
  intros x H; induction H as [|x H [k IH]].
  - exists 0; reflexivity.
  - exists (S k); lia.
Qed.
Lemma agentic_multiple : forall k, Agentic (6 * k).
Proof.
  induction k as [|k IH].
  - constructor.
  - replace (6 * S k) with (S (S (S (S (S (S (6 * k))))))) by lia.
    now constructor.
Qed.
Theorem goal_matches_agentic : forall x, Goal x <-> Agentic x.
Proof.
  intro x; split.
  - intro H; destruct H as [x HF HG].
    destruct (F_multiple x HF) as [a Ha].
    destruct (G_multiple x HG) as [b Hb].
    destruct (Nat.Even_or_Odd b) as [[k Hk]|[k Hk]].
    + replace x with (6 * k) by lia. apply agentic_multiple.
    + lia.
  - intro H; induction H as [|x H IH].
    + constructor; constructor.
    + destruct IH as [x HF HG]. constructor.
      * apply FS, FS, FS; exact HF.
      * apply GS, GS; exact HG.
Qed.

Print Assumptions tool_matches_paper.
Print Assumptions merged_matches_goal.
Print Assumptions goal_matches_agentic.
