# Troubleshooting Runbook

Use this page as a first-response checklist when the cluster or a workload is not behaving as expected.

## 1. Cluster creation problems

Check:

```bash
pcluster describe-cluster --cluster-name mini-hpc
```

Then verify:

- subnet IDs exist in the selected region;
- EC2 instance type is available;
- service quotas are sufficient;
- IAM permissions allow required operations;
- SSH key name is correct.

## 2. Cannot SSH to head node

Validate:

```bash
chmod 600 ~/.ssh/YOUR_KEY.pem
```

Check:

- cluster state is healthy;
- the key matches the configured key pair;
- the head-node security group permits your source IP;
- your local network allows outbound SSH;
- you are using the correct region/profile.

## 3. Slurm node is down/drained

```bash
sinfo -Nel
scontrol show node <NODE>
```

Look at the node reason field. Depending on the cause, investigate daemon state, instance health, filesystem mounts, memory pressure, or workload failures before returning the node to service.

## 4. Job pending

```bash
squeue -j <JOB_ID> -o "%.18i %.9P %.8j %.8u %.2t %.10M %.6D %R"
scontrol show job <JOB_ID>
```

Common reasons:

- `Resources` — requested resources are not currently available;
- invalid partition;
- node constraints cannot be satisfied;
- dependency has not completed;
- account/QoS configuration.

## 5. Job fails immediately

Inspect:

```bash
sacct -j <JOB_ID> --format=JobID,State,ExitCode,Elapsed,NodeList
cat slurm-<JOB_ID>.out
```

Check executable paths, environment modules, Python virtual environments, permissions, and input files.

## 6. Shared storage problems

```bash
df -h
mount | grep -E 'efs|lustre|nfs'
ls -ld "$HOME"
```

Check DNS, mount state, permissions, and capacity/inode exhaustion.

## 7. MPI failure

Confirm:

```bash
which mpirun || which mpiexec
srun hostname
```

Then verify all allocated nodes can resolve each other and use compatible MPI/runtime environments.

## 8. DDP hangs

Check:

- correct world size/rank configuration;
- network connectivity between nodes;
- consistent PyTorch versions;
- selected backend;
- Slurm task count;
- process launch command.

Capture environment variables when debugging:

```bash
env | sort | grep -E 'SLURM|MASTER|WORLD|RANK'
```

## 9. High cost / unexpected resources

List the cluster:

```bash
pcluster list-clusters
```

Delete experiments that are finished and verify EC2/storage resources afterwards.

## Incident note template

```text
Time:
Cluster:
Job ID:
Symptom:
Expected behavior:
Observed behavior:
Commands run:
Relevant logs:
Root cause:
Fix:
Prevention/follow-up:
```

Documenting failures is part of the project: it demonstrates operational reasoning, not just successful happy-path demos.
