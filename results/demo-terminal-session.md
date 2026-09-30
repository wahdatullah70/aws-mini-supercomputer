# Demo Terminal Session — Synthetic Evidence

> **Status: SYNTHETIC / ILLUSTRATIVE.** This transcript is included to show what a healthy workflow looks like. It is **not** a preserved historical AWS session and must not be cited as measured production evidence.

## 1. Cluster health check

```text
$ sinfo
PARTITION AVAIL  TIMELIMIT  NODES  STATE NODELIST
compute*      up   infinite      2   idle compute-dy-c6ilarge-[1-2]
```

Interpretation:

- Slurm partition is available.
- Two compute nodes are visible.
- Both nodes are idle and ready for jobs.

## 2. Queue check

```text
$ squeue
JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
```

Interpretation: no jobs are currently queued or running.

## 3. Submit MPI benchmark

```text
$ sbatch scripts/benchmarks/run_mpi.sh
Submitted batch job 42
```

## 4. Observe job

```text
$ squeue
JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
42    compute     mpi-pi   ec2-user  R       0:03      2 compute-dy-c6ilarge-[1-2]
```

## 5. Example job output

```text
Running MPI Pi benchmark with 4 ranks and 10000000 integration steps
MPI ranks: 4
Integration steps: 10000000
Estimated Pi: 3.141592653590
Absolute error: 0.000000000000e+00
Runtime (max rank): <MEASURED_AT_RUNTIME> s
```

The runtime placeholder is intentional: performance must be measured on an actual cluster because it depends on instance type, placement, network, CPU frequency, MPI implementation, load, and AWS environment.

## 6. DDP workflow shape

```text
$ sbatch scripts/benchmarks/run_ddp.sh
Submitted batch job 43

$ squeue
JOBID PARTITION     NAME       USER ST       TIME  NODES NODELIST(REASON)
43    compute     ddp-bench  ec2-user  R       0:06      2 compute-dy-gpu-[1-2]
```

Example output shape:

```text
Elapsed: <MEASURED_AT_RUNTIME>s
```

## Replacing this file with real evidence

When a real cluster is available, capture commands such as:

```bash
sinfo > results/sinfo.txt
squeue > results/squeue.txt
scontrol show nodes > results/slurm-nodes.txt
sbatch scripts/benchmarks/run_mpi.sh
sbatch scripts/benchmarks/run_ddp.sh
```

Then save the corresponding Slurm output files and record the environment in `results/environment.md`.
