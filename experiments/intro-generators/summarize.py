#!/usr/bin/env python3
"""Validate all saved measurements and aggregate descriptive statistics."""
import csv, json, pathlib, statistics
HERE=pathlib.Path(__file__).resolve().parent
counters=list(csv.DictReader((HERE/'counters.csv').open()))
timing=list(csv.DictReader((HERE/'timing.csv').open()))
assert len(counters)==60 and len(timing)==180
index={}
for r in counters:
    key=(r['case'],r['size'],r['seed'])
    index[key]=r
    num=lambda k:int(r[k])
    assert num('candidate_checks')==sum(num(k) for k in ['candidate_true','candidate_false','candidate_unknown'])
    assert num('attempts')==num('accepted')+num('discarded')
    assert num('failed_constructor_branches')==num('candidate_false')+num('candidate_unknown')
    histogram=list(csv.DictReader((HERE/'histograms'/f"{r['case']}-size{r['size']}-seed{r['seed']}.csv").open()))
    assert all(int(h['value'])%6==0 for h in histogram)
    assert sum(int(h['count']) for h in histogram)==num('accepted')
    r['sum_outputs']=sum(int(h['value'])*int(h['count']) for h in histogram)
for r in timing:
    c=index[(r['case'],r['size'],r['seed'])]
    assert all(r[k]==c[k] for k in ['attempts','accepted','discarded'])
    assert int(r['sum_outputs'])==c['sum_outputs']
rows=[]
for size in [10,30,100]:
    for case in ['original','reversed','merged','agentic']:
        cs=[r for r in counters if r['case']==case and int(r['size'])==size]
        ts=[r for r in timing if r['case']==case and int(r['size'])==size]
        total=lambda k:sum(int(r[k]) for r in cs)
        means=[float(r['cpu_ns_per_accepted']) for r in ts]
        nonzero_ns=[1e9*float(r['cpu_seconds'])/(int(r['accepted'])-int(index[(case,str(size),r['seed'])]['zero'])) for r in ts]
        row=dict(case=case,size=size,attempts=total('attempts'),accepted=total('accepted'),
                 discarded=total('discarded'),discard_percent=100*total('discarded')/total('attempts'),
                 candidate_checks=total('candidate_checks'),candidate_false=total('candidate_false'),
                 candidate_unknown=total('candidate_unknown'),
                 false_checks_per_attempt=total('candidate_false')/total('attempts'),
                 false_percent_of_checks=100*total('candidate_false')/total('candidate_checks') if total('candidate_checks') else None,
                 zero_percent=100*total('zero')/total('accepted'),mean_output=total('sum_outputs')/total('accepted'),
                 max_output=max(int(r['maximum']) for r in cs),unique_min=min(int(r['unique']) for r in cs),unique_max=max(int(r['unique']) for r in cs),
                 cpu_ns_per_accepted_median=statistics.median(means),cpu_ns_per_accepted_min=min(means),cpu_ns_per_accepted_max=max(means),
                 cpu_ns_per_nonzero_accepted_median=statistics.median(nonzero_ns))
        rows.append(row)
with (HERE/'summary.csv').open('w',newline='') as out:
    w=csv.DictWriter(out,fieldnames=rows[0].keys());w.writeheader();w.writerows(rows)
(HERE/'summary.json').write_text(json.dumps(rows,indent=2)+'\n')
for r in rows:
    print(f"size {r['size']:3d} {r['case']:8s} None {r['discard_percent']:6.2f}% false/check {str(None if r['false_percent_of_checks'] is None else round(r['false_percent_of_checks'],2)):>5s}% zero {r['zero_percent']:6.2f}% mean {r['mean_output']:7.3f} max {r['max_output']:3d} ns/accepted {r['cpu_ns_per_accepted_median']:8.1f}")
print('Validated 60 histogram files and 180 timing rows against counter-free counts/sums; all saved outputs divisible by 6.')
