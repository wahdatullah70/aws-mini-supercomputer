# Benchmarking & Evidence Collection

A professional HPC project should show **how performance is measured**, not only that workloads run.

## Benchmark workflow

```text
Define workload
   │
   ▼
Record cluster shape
   │
   ▼
Run baseline
   │
   ▼
Increase nodes / tasks
   │
   ▼
Collect elapsed time + throughput
   │
   ▼
Calculate speedup / efficiency
   │
   ▼
Document results and limitations
```

## Environment record

Before every benchmark, capture:

```bash
date -Is
hostname
uname -a
lscpu
free -h
sinfo -Nel
```

For AWS, also record the instance types and node count used in the experiment.

## Suggested result table

| Run | Workload | Nodes | Tasks | Time (s) | Throughput | Speedup | Efficiency |
|---|---|---:|---:|---:|---:|---:|---:|
| 1 | baseline | 1 | 2 | — | — | 1.00 | 1.00 |
| 2 | scale test | 2 | 4 | — | — | — | — |
| 3 | scale test | 4 | 8 | — | — | — | — |

Do not enter numbers until they have actually been measured.

## Formulas

```text
speedup = baseline_time / parallel_time
parallel_efficiency = speedup / number_of_parallel_units
```

For ML workloads, useful metrics can include:

- samples/second;
- epoch time;
- time to target loss;
- CPU/GPU utilization;
- communication overhead.

## Slurm accounting

Useful commands:

```bash
sacct -X --format=JobID,JobName,State,Elapsed,AllocCPUS,MaxRSS,NodeList
sstat -j <JOB_ID>.batch --format=AveCPU,AveRSS,MaxRSS
```

## Evidence directory convention

For a real run, save evidence under a dated folder outside secrets/configuration:

```text
results/
└── 2026-09-30-ddp-2nodes/
    ├── environment.txt
    ├── slurm-job.txt
    ├── stdout.log
    ├── stderr.log
    └── notes.md
```

## Reproducibility rules

1. Record the exact job script used.
2. Record node/task counts.
3. Capture package/runtime versions.
4. Keep raw logs unchanged.
5. Separate measured results from estimates.
6. Document failed runs instead of silently discarding them when the failure is informative.

This makes the repository useful to both recruiters and engineers reviewing how the experiment was actually conducted.
