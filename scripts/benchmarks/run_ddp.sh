#!/usr/bin/env bash
#SBATCH --job-name=ddp-bench
#SBATCH --nodes=2
#SBATCH --ntasks-per-node=4
#SBATCH --gpus-per-node=1
#SBATCH --time=00:20:00

module load cuda || true
source ~/venv/bin/activate

srun --mpi=pmix_v3 python3 scripts/benchmarks/pytorch_ddp.py
