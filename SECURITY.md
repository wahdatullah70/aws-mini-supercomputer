# Security Policy

This repository contains public infrastructure examples. Do not commit credentials or production environment details.

## Never commit

- AWS access keys or session tokens
- private SSH keys
- real account IDs when not required
- secrets embedded in ParallelCluster configuration
- kubeconfig/service-account credentials
- private host inventories or sensitive IP details

Use environment variables, AWS profiles, IAM roles, and secret-management services instead.

## Reporting

If you identify a security problem in the repository, contact the repository owner privately and avoid publishing active credentials or sensitive exploit details in a public issue.

## Infrastructure note

The example ParallelCluster configuration uses placeholders and must be reviewed for IAM, networking, encryption, quotas, and cost before deployment.
