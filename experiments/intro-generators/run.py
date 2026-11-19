#!/usr/bin/env python3
"""Rebuild exact QuickChick extraction, check counters, run isolated processes."""
import csv, hashlib, json, os, pathlib, platform, shutil, subprocess, time
HERE = pathlib.Path(__file__).resolve().parent
SCRATCH = pathlib.Path(os.environ.get('INTRO_BENCH_SCRATCH', '/tmp/spec4pbt-intro-benchmark')).resolve()
QC = pathlib.Path(os.environ.get('QUICKCHICK_SRC', '/tmp/testing-theorems-artifact-check')).resolve()
SWITCH = os.environ.get('OPAM_SWITCH', '/workspace/spec4pbt/.worktrees/spectec-rocq/build/quickchick-switch')
ATTEMPTS = int(os.environ.get('ATTEMPTS', '100000'))
SIZES = [10, 30, 100]
SEEDS = [42, 1729, 2718, 31415, 2026]
CASES = ['original', 'reversed', 'merged', 'agentic']
REPEATS = 3
SCRATCH.mkdir(parents=True, exist_ok=True)
(HERE/'histograms').mkdir(exist_ok=True)
base = ['opam', 'exec', '--switch='+SWITCH, '--']
def run(args, **kw):
    return subprocess.run(args, check=True, text=True, cwd=SCRATCH, **kw)
def capture(args):
    return run(args, stdout=subprocess.PIPE, stderr=subprocess.STDOUT).stdout.strip()
# Keep Rocq and OCaml build products in scratch; retain reviewable source only.
shutil.copyfile(HERE/'IntroBenchmark.v', SCRATCH/'IntroBenchmark.v')
with (HERE/'derivation.log').open('w') as out:
    run(base+['coqc', '-I', str(QC/'_build/install/default/lib'), '-R', str(QC/'_build/default/src'), 'QuickChick', 'IntroBenchmark.v'], stdout=out, stderr=subprocess.STDOUT)
shutil.copyfile(HERE/'MergeCheck.v', SCRATCH/'MergeCheck.v')
with (HERE/'merge-check.log').open('w') as out:
    run(base+['coqc', '-I', str(QC/'_build/install/default/lib'), '-R', str(QC/'_build/default/src'), 'QuickChick', 'MergeCheck.v'], stdout=out, stderr=subprocess.STDOUT)
for name in ['derived.ml', 'derived.mli']:
    shutil.copyfile(SCRATCH/name, HERE/name)
run(['python3', str(HERE/'instrument.py'), 'derived.ml', 'derived_counted.ml'])
shutil.copyfile(SCRATCH/'derived_counted.ml', HERE/'derived_counted.ml')
for name in ['runner.ml', 'check_instrumentation.ml']:
    shutil.copyfile(HERE/name, SCRATCH/name)
compiler=base+['ocamlfind', 'ocamlopt', '-package', 'zarith,unix', '-linkpkg']
run(compiler+['-o', 'benchmark', 'derived.mli', 'derived.ml', 'derived_counted.ml', 'runner.ml'])
run(compiler+['-o', 'check_instrumentation', 'derived.cmx', 'derived_counted.cmx', 'check_instrumentation.ml'])
validation = capture([str(SCRATCH/'check_instrumentation'), 'validation', '42'])
(HERE/'validation.txt').write_text(validation+'\n')
print(validation, flush=True)
meta = dict(timestamp_utc=time.strftime('%Y-%m-%dT%H:%M:%SZ', time.gmtime()),
            platform=platform.platform(), python=platform.python_version(),
            cpu=pathlib.Path('/proc/cpuinfo').read_text().split('model name')[1].split('\n')[0].split(':', 1)[1].strip(),
            switch=SWITCH, quickchick_source=str(QC), attempts=ATTEMPTS,
            sizes=SIZES, seeds=SEEDS, timing_repeats=REPEATS)
for key, args in {'coqc':base+['coqc','--version'], 'ocaml':base+['ocamlopt','-version'],
                  'quickchick_commit':['git','-C',str(QC),'rev-parse','HEAD'],
                  'quickchick_status':['git','-C',str(QC),'status','--short'],
                  'switch_packages':['opam','list','--switch='+SWITCH,'--installed','--short']}.items():
    meta[key]=capture(args)
# Hash all source files read by the derivation package, including modified files.
meta['quickchick_source_sha256']={str(p.relative_to(QC)):hashlib.sha256(p.read_bytes()).hexdigest()
    for folder in ['src','plugin'] for p in sorted((QC/folder).rglob('*')) if p.is_file() and p.suffix in ('.v','.ml','.mli','.cppo')}
meta['extracted_sha256']=hashlib.sha256((HERE/'derived.ml').read_bytes()).hexdigest()
(HERE/'environment.json').write_text(json.dumps(meta,indent=2)+'\n')
with (HERE/'counters.csv').open('w',newline='') as cf, (HERE/'timing.csv').open('w',newline='') as tf:
    cw,tw=csv.writer(cf),csv.writer(tf)
    cw.writerow('mode case size seed attempts accepted discarded candidate_checks candidate_true candidate_false candidate_unknown failed_constructor_branches checker_recursive_calls zero zero_fraction mean maximum unique'.split())
    tw.writerow('mode case size seed attempts accepted discarded cpu_seconds wall_seconds cpu_ns_per_accepted sum_outputs repeat'.split())
    for size in SIZES:
        for seed in SEEDS:
            # Rotate case order by seed to avoid a fixed timing position.
            offset=SEEDS.index(seed)%len(CASES)
            cases=CASES[offset:]+CASES[:offset]
            for case in cases:
                hist=HERE/'histograms'/f'{case}-size{size}-seed{seed}.csv'
                line=capture([str(SCRATCH/'benchmark'),'counters',str(seed),case,str(size),str(ATTEMPTS),str(hist)])
                cw.writerow(next(csv.reader([line])));cf.flush()
                for repeat in range(REPEATS):
                    line=capture([str(SCRATCH/'benchmark'),'timing',str(seed),case,str(size),str(ATTEMPTS)])
                    tw.writerow(next(csv.reader([line]))+[repeat]);tf.flush()
            print(f'completed size={size} seed={seed}',flush=True)
run(['python3', str(HERE/'summarize.py')])
print('Saved validated counters.csv, timing.csv, histograms/, summaries and provenance.',flush=True)
