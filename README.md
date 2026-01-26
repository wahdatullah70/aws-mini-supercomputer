# AWS Mini Supercomputer (Small Cluster)

Build a **small, professional, reproducible “supercomputer” cluster on AWS** for **distributed ML** and **general parallel compute**. This repo documents **architecture, infrastructure steps, diagrams, benchmarks, costs, security, and troubleshooting** so anyone can follow along.

## What you’ll build
- A small **Slurm-based cluster** using **AWS ParallelCluster**
- **Head node + compute nodes + shared storage**
- Workflows for **distributed ML** (PyTorch Distributed) and **MPI** jobs
- **Benchmarks** and **results tables** you can reproduce

## Repo structure
- `docs/` — architecture, setup, benchmarks, costs, security, troubleshooting
- `docs/diagrams/` — architecture and data-flow diagrams (Mermaid)
- `infra/pcluster/` — AWS ParallelCluster config
- `scripts/benchmarks/` — quick benchmark scripts

## Quick start
1. Read the architecture: `docs/architecture.md`
2. Provision the cluster: `docs/setup-aws.md`
3. Run distributed ML: `docs/distributed-ml.md`
4. Run MPI jobs: `docs/parallel-compute.md`
5. Benchmark and record results: `docs/benchmarking.md`

## Diagrams
- Cluster architecture: `docs/diagrams/cluster-architecture.md`
- ML data flow: `docs/diagrams/data-flow-ml.md`

## Results
See `docs/benchmarking.md` for a reproducible process and a results table template.

## License
MIT (add your preferred license if different)