# Architecture

This project uses **AWS ParallelCluster** to build a small, professional HPC-style cluster that behaves like a “mini supercomputer.”

## High-level components
- **Head node**: runs Slurm controller, shared services, and login
- **Compute nodes**: autoscaled worker nodes for ML and MPI jobs
- **Shared storage**: EFS (home) or FSx for Lustre (high performance)
- **Networking**: VPC with public/private subnets, security groups
- **Scheduler**: Slurm

## Design goals
- **Reproducible**: Infrastructure as code and scripted benchmarks
- **Cost-aware**: Small default sizes, documented cost drivers
- **Scalable**: Autoscaling compute nodes
- **Portable**: Clear mapping for other clouds (later docs)

## Diagram
See: `docs/diagrams/cluster-architecture.md`