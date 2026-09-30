# Contributing

This project aims to keep HPC examples reproducible, cost-aware, and safe to run.

## Before opening a pull request

1. Create a focused branch.
2. Run Python syntax checks:

```bash
python -m compileall scripts
```

3. Validate shell scripts:

```bash
find scripts -type f -name '*.sh' -print0 | while IFS= read -r -d '' f; do bash -n "$f"; done
```

4. Validate YAML configuration and confirm placeholders remain placeholders.
5. Do not commit AWS credentials, SSH private keys, or environment-specific secrets.
6. Update docs when changing architecture, instance assumptions, Slurm layout, or benchmark methodology.

## Benchmark contributions

Include:

- date/time
- AWS region
- instance type
- node count
- software versions
- exact command/job script
- raw output or artifact
- notes about failed/partial runs

Do not submit invented or estimated benchmark numbers as measured results.
