import Palamedes.Synthesizer
open Gen CorrectGen

def palamedesPositiveControl : Gen Nat := by
  generator_search (fun x => x = 2)
#print palamedesPositiveControl
