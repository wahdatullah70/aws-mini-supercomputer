# Security Model

This repository is a learning/reproducibility project, but the infrastructure should still be designed with production-style security thinking.

## Trust boundaries

```text
Developer workstation
      │ AWS API / SSH
      ▼
AWS account + IAM
      │
      ▼
VPC
 ├── Head node
 │    ├── SSH / administration
 │    └── Slurm controller
 │
 ├── Compute nodes
 │    └── scheduled workloads
 │
 └── Shared storage
      └── user/job data
```

## Key controls

### IAM

Use least-privilege IAM permissions for cluster creation and administration. Avoid using root credentials or long-lived credentials in source files.

Never commit:

- AWS access keys;
- secret access keys;
- session tokens;
- private SSH keys;
- privileged IAM policy credentials.

### Network exposure

Prefer:

- restricted SSH source CIDRs;
- private compute nodes;
- security groups that allow only required traffic;
- no public IPs on worker nodes unless explicitly needed.

### SSH

Keep private keys outside the repository:

```text
~/.ssh/my-hpc-key.pem
```

Protect them:

```bash
chmod 600 ~/.ssh/my-hpc-key.pem
```

### Shared storage

Treat shared storage as a multi-user boundary. Use Linux ownership/permissions appropriately and avoid storing secrets in world-readable paths.

### Workload isolation

Slurm schedules jobs but does not replace good host security. Consider:

- separate Linux users;
- resource limits;
- restricted sudo;
- controlled software installation;
- container isolation where appropriate;
- auditing/logging.

## Credential flow

```text
AWS CLI credentials
      │
      ├── used locally to call AWS APIs
      ▼
AWS control plane
      │
      ├── provisions cluster resources
      ▼
EC2 instances
      │
      └── instance roles / service permissions
```

Application/job credentials should be injected at runtime using appropriate secret-management mechanisms rather than written into job scripts.

## Public-repository checklist

Before committing:

```bash
git diff --cached
```

Look specifically for:

- access keys;
- `.pem` files;
- tokens;
- private endpoint details;
- internal datasets;
- account identifiers that should remain private.

## Security review questions

- Does any worker need a public IP?
- Who can SSH to the head node?
- Are security groups broader than necessary?
- Are secrets stored outside Git?
- Are logs retained long enough to diagnose incidents?
- Can a compromised job access credentials it does not need?

These questions are intentionally documented because infrastructure engineering is as much about safe operation as successful provisioning.
