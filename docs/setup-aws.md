# AWS ParallelCluster Setup

This guide documents a reproducible path for provisioning the mini-HPC environment described in this repository.

> The configuration is intentionally conservative and uses placeholders. Review AWS pricing, quotas, networking, IAM, and instance availability in your region before creating resources.

## 1. Prerequisites

Install and configure:

```bash
aws --version
pcluster version
aws sts get-caller-identity
```

You need:

- an AWS account with appropriate permissions;
- AWS CLI credentials configured locally;
- AWS ParallelCluster CLI;
- an EC2 key pair;
- a VPC/subnet appropriate for the cluster;
- enough service quota for the selected EC2 instance types.

## 2. Configure the cluster

Start from:

```text
infra/pcluster/cluster-config.example.yaml
```

Copy it before editing:

```bash
cp infra/pcluster/cluster-config.example.yaml cluster-config.yaml
```

Replace the placeholder values for:

- `YOUR_KEY_NAME`
- `subnet-xxxxxxxx`
- Region-specific AMI/instance requirements if needed

Validate the configuration:

```bash
pcluster create-cluster \
  --cluster-name mini-hpc \
  --cluster-configuration cluster-config.yaml \
  --dryrun true
```

## 3. Create the cluster

```bash
pcluster create-cluster \
  --cluster-name mini-hpc \
  --cluster-configuration cluster-config.yaml
```

Follow creation status:

```bash
pcluster describe-cluster --cluster-name mini-hpc
```

## 4. Connect to the head node

```bash
pcluster ssh --cluster-name mini-hpc -i ~/.ssh/YOUR_KEY.pem
```

Once connected, confirm Slurm is healthy:

```bash
sinfo
squeue
scontrol show partition
```

## 5. Smoke test

Submit a tiny Slurm job:

```bash
cat > smoke.sbatch <<'EOF'
#!/bin/bash
#SBATCH --job-name=smoke
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --time=00:02:00

hostname
nproc
free -h
EOF

sbatch smoke.sbatch
squeue
```

Check the generated output after the job completes.

## 6. Run project workloads

MPI:

```bash
sbatch scripts/benchmarks/run_mpi.sh
```

PyTorch DDP:

```bash
sbatch scripts/benchmarks/run_ddp.sh
```

See:

- [Parallel compute](parallel-compute.md)
- [Distributed ML](distributed-ml.md)
- [Benchmarking](benchmarking.md)

## 7. Stop spending when finished

HPC experiments can create billable EC2, storage, networking, and logging resources. Delete the cluster when it is no longer required:

```bash
pcluster delete-cluster --cluster-name mini-hpc
```

Then verify in the AWS console that supporting resources you no longer need have also been removed.

## Validation checklist

- [ ] AWS identity confirmed
- [ ] ParallelCluster configuration validated
- [ ] Cluster reaches `CREATE_COMPLETE`
- [ ] SSH to head node succeeds
- [ ] `sinfo` reports the partition
- [ ] smoke job completes
- [ ] MPI example completes
- [ ] DDP example completes or documents the missing dependency
- [ ] cluster is deleted after testing when appropriate
