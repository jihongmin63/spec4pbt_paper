# Palamedes synthesis check for the introduction example

This experiment checks the exact **unary** predicates currently shown in
`figures/intro-reformulation.tex`: `F` starts at zero and adds two, `G` starts
at zero and adds three, and `GoalI` requires `F x` and `G x` for the same `x`.
It supplies no additional lemmas, registered generators, or synthesis rules.

Run recorded on 2026-11-19 with upstream Palamedes commit
`c2012b84fc4ad8ee03e3528838175b959fcc9cf8` (package version 0.1.0), a clean
source checkout, and Lean 4.31.0. Full tool/version/search-path information is
in `environment.txt`; package pins are in the captured manifests.

| Case | Lean exit status | Observed result |
| --- | ---: | --- |
| `Control.lean` | 0 | Synthesis for `x = 2` succeeds, producing `pure 2`. |
| `ExactGoal.lean` | 1 | Synthesis fails: Aesop makes no progress on `CorrectGen (fun x => Goal x)`. |
| `Agentic.lean` | 1 | Synthesis also fails for the direct unary zero/+6 inductive predicate. |

These are synthesis outcomes, **not sample rejection rates**. No generator
was produced for either inductive predicate, so there is no Palamedes sampling
time or rejection percentage to report. The Agentic result also means this
experiment does not establish that the direct inductive reformulation enables
Palamedes; the paper uses QuickChick for that reformulation.

The positive control establishes that the imported synthesizer works in this
environment. This is a check of the default `generator_search` invocation for
these encodings and this revision, rather than a claim that every possible
Palamedes encoding, custom rule, or manually supplied generator must fail.

Reproduce with a built Lake project whose manifest includes the pinned
Palamedes revision:

```sh
PATH=/root/.elan/bin:$PATH ./run.sh /workspace/spec4pbt
```

For a standalone built Palamedes checkout, pass its path twice (once as the
Lake project, once as the Palamedes source):

```sh
./run.sh /path/to/palamedes /path/to/palamedes
```

The script overwrites the captured environment, manifests, result table, and
three logs. Each log contains complete Lean output, and `results.tsv` records
the individual exit statuses. `run.sh` itself exits successfully after running
all cases, including cases expected to fail synthesis.
