#!/usr/bin/env python3
"""Add observational counters to extracted OCaml; do not replace generator logic."""
from pathlib import Path
import re, sys
src = Path(sys.argv[1]).read_text()
prelude = '''let candidate_checks = ref 0
let candidate_true = ref 0
let candidate_false = ref 0
let candidate_unknown = ref 0
let checker_calls = ref 0
let failed_branches = ref 0
let observe_check x =
  incr candidate_checks;
  (match x with Some true -> incr candidate_true
              | Some false -> incr candidate_false
              | None -> incr candidate_unknown); x

'''
# There are exactly three generation/check boundaries in these four derivations.
pattern = r'match (let .*?) with\n        \| Some b ->'
src, n = re.subn(pattern, r'match observe_check (\1) with\n        | Some b ->', src, flags=re.S)
assert n == 3, n
# Count every generator constructor branch returning None, including branches
# whose failure is recovered by backtracking to another constructor.
old = "| None -> backtrackFuel fuel' (subn tot k) gs'"
assert src.count(old) == 1
src = src.replace(old, "| None -> incr failed_branches; backtrackFuel fuel' (subn tot k) gs'")
old = 'let checker_backtrack l =\n'
assert src.count(old) == 1
src = src.replace(old, old + '  incr checker_calls;\n')
Path(sys.argv[2]).write_text(prelude + src)
