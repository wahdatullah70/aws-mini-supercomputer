# Parallel Compute with MPI + Slurm

This project includes a small MPI workflow designed to demonstrate how a parallel workload moves through Slurm.

## Execution flow

```text
User
 │
 │ sbatch
 ▼
Slurm controller
 │
 │ schedules resources
 ▼
Compute node(s)
 │
 │ srun / mpirun
 ▼
MPI ranks
 │
 ├── rank 0
 ├── rank 1
 ├── rank 2
 └── ...
 │
 ▼
Job output + timing
```

## 1. Check the scheduler

```bash
sinfo
squeue
```

## 2. Inspect the benchmark script

The repository provides:

```text
scripts/benchmarks/run_mpi.sh
scripts/benchmarks/mpi_pi.sh
```

The Slurm wrapper requests resources, then launches the MPI workload.

## 3. Submit

```bash
sbatch scripts/benchmarks/run_mpi.sh
```

Track the job:

```bash
squeue -u "$USER"
```

Inspect completed jobs:

```bash
sacct -X --format=JobID,JobName,State,Elapsed,AllocCPUS,NodeList
```

## 4. What to validate

Record:

- node count;
- total MPI ranks;
- elapsed time;
- scheduler wait time;
- successful completion state;
- stdout/stderr;
- scaling behavior when increasing ranks.

## 5. Troubleshooting

### Job stays pending

```bash
squeue -j <JOB_ID> -o "%.18i %.9P %.8j %.8u %.2t %.10M %.6D %R"
scontrol show job <JOB_ID>
```

Typical reasons include unavailable nodes, requested resources exceeding the partition, or dependency constraints.

### MPI command not found

Confirm the MPI implementation is available:

```bash
which mpirun || which mpiexec
```

Load the appropriate environment module when the cluster image uses modules.

### Hosts cannot communicate

Check:

- security-group rules;
- DNS/hostname resolution;
- subnet routing;
- MPI runtime compatibility;
- Slurm node health.

## Engineering objective

The goal is not just to launch a command. The project demonstrates the full path from resource request → scheduler → compute allocation → distributed process launch → measurable result.
