# Benchmark Results

This directory is reserved for **measured** execution evidence from real cluster runs.

No benchmark values should be added unless they were actually produced by a documented environment.

## Recommended evidence structure

```text
results/
├── README.md
├── environment.md
├── mpi-results.csv
├── ddp-results.csv
└── raw/
    └── <job-output-files>
```

## Environment record

Record at minimum:

- AWS region
- ParallelCluster version
- operating system image
- head-node instance type
- compute instance type
- node count
- processes/tasks per node
- storage type
- Python/PyTorch/MPI versions
- Slurm version
- experiment timestamp

## MPI CSV schema

```text
run_id,nodes,tasks,instance_type,runtime_seconds,speedup,notes
```

## DDP CSV schema

```text
run_id,nodes,gpus_per_node,instance_type,elapsed_seconds,throughput,notes
```

## Reproducibility rule

Every result should point to the exact script/configuration used to generate it. Failed or partial runs are useful evidence too when clearly labeled.
