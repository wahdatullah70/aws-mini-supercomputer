#!/usr/bin/env bash
#SBATCH --job-name=mpi-pi
#SBATCH --nodes=2
#SBATCH --ntasks-per-node=2
#SBATCH --time=00:10:00

module load python || true

srun python3 scripts/benchmarks/mpi_pi.sh
