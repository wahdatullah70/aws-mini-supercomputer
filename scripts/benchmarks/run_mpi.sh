#!/usr/bin/env bash
#SBATCH --job-name=mpi-pi
#SBATCH --nodes=2
#SBATCH --ntasks-per-node=2
#SBATCH --time=00:10:00

set -euo pipefail

module load gcc || true
module load openmpi || true

mkdir -p build
mpicc -O2 scripts/benchmarks/mpi_pi.c -lm -o build/mpi_pi

STEPS="${STEPS:-10000000}"
echo "Running MPI Pi benchmark with ${SLURM_NTASKS:-4} ranks and ${STEPS} integration steps"
srun build/mpi_pi "$STEPS"
