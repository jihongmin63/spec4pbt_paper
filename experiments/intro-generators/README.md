# Introduction generator experiment

These are measurements of the **unary predicates printed in the paper's introduction**, using actual QuickChick-derived generators. They are not measurements of the separate binary example or of handwritten models of the generators.

The key observation is that a generator can return no external `None` while still rejecting candidates internally. Here, QuickChick's generator for `Merged` tries its nonzero constructor first about half the time; that constructor generates `G x` and checks `F (S x)`. Failed checks backtrack to the always-successful zero constructor. Consequently external discard rate alone hides both the failed checks and the substantial bias toward zero.

## Results

Each row below pools five fixed seeds, with 100,000 attempts per seed (500,000 attempts per case and size). “Check failure” is the fraction of attempted top-level premise checks that returned `Some false`. A dash means there were no premise checks. All measured checker `None`/fuel-exhaustion counts were zero. These are fixed-size generator calls, bypassing the property-testing driver's size schedule and stopping rules; “external discard” means a generator returned `None`, rather than the discard count of a complete `QuickChick` property run.

| Size | Generator | External `None` | Check failure | Zero among outputs | Mean output | Maximum | CPU µs/accepted |
|---:|:---|---:|---:|---:|---:|---:|---:|
| 10 | Original, F then G | 63.68% | 63.68% | 24.91% | 9.00 | 18 | 1.442 |
| 10 | Reversed, G then F | 45.47% | 45.47% | 16.59% | 14.99 | 30 | 1.044 |
| 10 | Merged | 0.00% | 54.61% | 77.27% | 4.10 | 30 | 0.322 |
| 10 | Agentic, zero/+6 | 0.00% | — | 9.09% | 29.98 | 60 | 0.412 |
| 30 | Original, F then G | 64.46% | 64.46% | 8.95% | 30.04 | 60 | 3.772 |
| 30 | Reversed, G then F | 48.56% | 48.56% | 6.18% | 45.08 | 90 | 2.983 |
| 30 | Merged | 0.00% | 51.71% | 75.83% | 11.58 | 90 | 0.805 |
| 30 | Agentic, zero/+6 | 0.00% | — | 3.21% | 89.97 | 180 | 1.140 |
| 100 | Original, F then G | 66.31% | 66.31% | 2.93% | 99.14 | 198 | 13.452 |
| 100 | Reversed, G then F | 49.64% | 49.64% | 1.96% | 150.05 | 300 | 10.685 |
| 100 | Merged | 0.00% | 50.47% | 75.24% | 37.89 | 300 | 2.718 |
| 100 | Agentic, zero/+6 | 0.00% | — | 0.96% | 300.22 | 600 | 3.860 |

For size 30, `Merged` performed 250,285 premise checks over 500,000 attempts; 129,430 failed and caused constructor backtracking. Thus about 25.89% of all calls hid a failed check, even though every call returned `Some`. `Agentic` had no such premise checks or failed constructor branches.

The CPU column is the median of 15 uninstrumented runs (five seeds, three repeats), with 100,000 attempts per run. It includes unsuccessful attempts in the numerator and accepted outputs in the denominator. Process startup, generator closure construction, extraction and compilation are outside the measured interval. The loop also counts accepted outputs and sums them to retain an observable result. Raw CPU/wall times and ranges are saved; these are descriptive single-machine measurements, not a statistical performance study.

**Equal numeric QuickChick size does not mean equal generated numeric range or output distribution.** The generated recursive constructor has weight `size` and decrements size, giving uniform recursion depth from 0 through size for these single-recursion predicates (the independent recursion fuel of 10,000 does not bind here). This yields maximum output approximately `2*size` for Original, `3*size` for Reversed and Merged, and `6*size` for Agentic, after the respective checks. Merged is especially fast per accepted output here partly because approximately three quarters of its outputs are zero. These timings do not establish a fair speedup between generators or a benefit at matched numeric support. The robust conclusions are the observed internal candidate rejection, zero bias, and the absence of those failed checks in Agentic. `summary.csv` also records CPU time per nonzero output, explicitly a different denominator rather than a controlled workload comparison.

As a sanity check, the extracted branch weights predict size-30 discard rates of 20/31 for Original and 15/31 for Reversed; Merged predicts 16/31 failures conditional on attempting its premise check and a zero-output probability of 47/62. The measured rates are close. These analytical expectations are not substituted for the observations.

## Reproduction and saved artifacts

From this directory or anywhere else:

```sh
python3 /workspace/spec4pbt_paper/experiments/intro-generators/run.py
```

The defaults reuse this environment's installed QuickChick checkout and opam switch. Override `QUICKCHICK_SRC`, `OPAM_SWITCH`, and `INTRO_BENCH_SCRATCH` for another installation, and optionally `ATTEMPTS`. The protocol uses sizes 10/30/100, seeds 42/1729/2718/31415/2026, three timing repeats, and rotates case order by seed. The saved data use 100,000 attempts. Runs are sequential processes on the current host; CPU scheduling and system conditions can affect timing. The script recompiles and overwrites benchmark outputs in this directory and confines intermediate build products to scratch.

- `IntroBenchmark.v`: exact predicates, an actual `Merge` command, four `QuickChick Derive Explain Generator` commands, and OCaml extraction.
- `derivation.log`: generated explanation identifying the chosen generation/check order, plus extraction warnings.
- `derived.ml`, `derived.mli`: unmodified extracted code used for timing.
- `instrument.py`, `derived_counted.ml`: observational instrumentation of that extracted code. The only changes are counting top-level candidate check results, recursive checker invocations, and generator constructor branches returning `None`.
- `runner.ml`: separate uninstrumented timing and instrumented count/distribution modes. Each run initializes `Random.State.make [|seed|]` and reuses that state across attempts, using QuickChick's extracted random operations. This seed initialization is part of this benchmark protocol, rather than the QuickChick command-line seed adapter.
- `check_instrumentation.ml`, `validation.txt`: 800,000 exact paired plain/instrumented outputs, across all four cases, five seeds, and sizes 0/10/30/100. Each pair agreed; every sampled value was divisible by six.
- `counters.csv`: one raw counter/distribution row per case, size, seed. `candidate_false`/`candidate_unknown` are top-level premise check results, whereas `checker_recursive_calls` counts recursive checker evaluations. `failed_constructor_branches` counts every generated constructor branch returning `None`, including recovered failures. These quantities must not be conflated.
- `timing.csv`: raw counter-free timing rows; accepted counts and output sums match the instrumented run for every case/size/seed and repeat.
- `histograms/`: complete output frequencies for each instrumented run. All saved outputs were checked to be divisible by six.
- `summarize.py`, `summary.csv`, `summary.json`: consistency checks and pooled descriptive statistics. Unique counts are per seed; each run observed every value in that generator's finite support at these sizes.
- `environment.json`: UTC timestamp, CPU, OS, Rocq/OCaml versions, installed packages, QuickChick source commit and clean status, and SHA-256 hashes of source and plugin files and extracted code. This run used Rocq 9.1.1, OCaml 4.14.2, and QuickChick source commit `944bc5066cbfe8b1d9a59313c20e345727ae93af` with a clean checkout.

`IntroBenchmark.v` executes the actual `Merge` command and derives from its result, preserving the automatic constructor order (nonzero `FSGS` first, zero `F0G0` second). This is the figure's relation up to constructor names and order. `run.py` also compiles `MergeCheck.v`; the saved `merge-check.log` prints the automatic relation and confirms that its equivalence with the displayed relation, the displayed relation's equivalence with Goal, and Goal's equivalence with Agentic are all closed under the global context. The benchmark does not test proof-assistant soundness or claim all generators have identical bounded supports.
