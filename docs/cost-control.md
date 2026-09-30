# Cost Control

Cloud HPC can become expensive quickly because compute, storage, data transfer, logging, and idle resources can all create charges.

## Main cost drivers

- EC2 head node runtime
- EC2 compute-node runtime
- EBS volumes
- EFS / FSx for Lustre
- snapshots
- data transfer
- CloudWatch logs/metrics

## Cost-aware design choices

1. Keep the head node small for demos.
2. Set compute queues to scale down when idle.
3. Use small `MaxCount` values during development.
4. Avoid high-performance storage until the workload actually requires it.
5. Delete clusters after experiments.
6. Keep benchmark durations short while validating scripts.

## Before creating a cluster

Record:

```text
Region:
Head node type:
Compute node type:
Minimum nodes:
Maximum nodes:
Storage type:
Expected test duration:
```

Use AWS Pricing Calculator or the current AWS pricing pages before provisioning. Prices vary by region and time, so this repository intentionally does not hard-code a dollar estimate.

## During experiments

Check scheduler state:

```bash
sinfo
squeue
```

If workers are running with no useful jobs, investigate autoscaling configuration.

## After experiments

Delete the cluster:

```bash
pcluster delete-cluster --cluster-name mini-hpc
```

Then inspect the AWS console for remaining:

- EBS volumes;
- snapshots;
- EFS/FSx filesystems;
- Elastic IPs;
- NAT gateways;
- log groups;
- manually created supporting resources.

## Professional practice

For each benchmark, document both performance and infrastructure shape. A result without knowing how many resources produced it is incomplete, and a cloud benchmark without cost awareness is operationally incomplete.
