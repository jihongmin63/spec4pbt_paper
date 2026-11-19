import Palamedes.Synthesizer
open Gen CorrectGen

-- Structural translation of the agent's zero/+6 reformulation.
inductive Agentic : Nat → Prop where
  | Six0 : Agentic 0
  | SixS : ∀ x, Agentic x →
      Agentic (Nat.succ (Nat.succ (Nat.succ (Nat.succ (Nat.succ (Nat.succ x))))))

def genAgentic : Gen Nat := by
  generator_search (fun x => Agentic x)
