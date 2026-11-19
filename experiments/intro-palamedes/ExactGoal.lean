import Palamedes.Synthesizer
open Gen CorrectGen

-- Unary structural translation of figures/intro-reformulation.tex.
inductive F : Nat → Prop where
  | F0 : F 0
  | FS : ∀ x, F x → F (Nat.succ (Nat.succ x))

inductive G : Nat → Prop where
  | G0 : G 0
  | GS : ∀ x, G x → G (Nat.succ (Nat.succ (Nat.succ x)))

inductive Goal : Nat → Prop where
  | GoalI : ∀ x, F x → G x → Goal x

-- No additional facts, generator rules, or reformulation supplied.
def genGoal : Gen Nat := by
  generator_search (fun x => Goal x)
