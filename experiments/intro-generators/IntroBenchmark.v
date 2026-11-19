From QuickChick Require Import QuickChick.
From Stdlib Require Import List Arith.
Import ListNotations.
Inductive F : nat -> Prop :=
| F0 : F 0 | FS : forall x, F x -> F (S (S x)).
Inductive G : nat -> Prop :=
| G0 : G 0 | GS : forall x, G x -> G (S (S (S x))).
Inductive Original : nat -> Prop :=
| OriginalI : forall x, F x -> G x -> Original x.
Inductive Reversed : nat -> Prop :=
| ReversedI : forall x, G x -> F x -> Reversed x.
Merge (fun x => F x) With (fun x => G x) As Merged.
Print Merged.
Inductive Agentic : nat -> Prop :=
| Six0 : Agentic 0
| SixS : forall x, Agentic x -> Agentic (S (S (S (S (S (S x)))))).
QuickChick Derive Explain Generator for (fun x => Original x).
QuickChick Derive Explain Generator for (fun x => Reversed x).
QuickChick Derive Explain Generator for (fun x => Merged x).
QuickChick Derive Explain Generator for (fun x => Agentic x).
Definition original size := genSizedST (fun x => Original x) size.
Definition reversed size := genSizedST (fun x => Reversed x) size.
Definition merged size := genSizedST (fun x => Merged x) size.
Definition agentic size := genSizedST (fun x => Agentic x) size.
Definition sample_original size := run (original size) size.
Definition sample_reversed size := run (reversed size) size.
Definition sample_merged size := run (merged size) size.
Definition sample_agentic size := run (agentic size) size.
Extraction "derived.ml" sample_original sample_reversed sample_merged sample_agentic.
