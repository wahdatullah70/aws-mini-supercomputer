#!/usr/bin/env bash
set -euo pipefail

# Local convenience wrapper for the real MPI implementation in mpi_pi.c.
# For Slurm/AWS execution use run_mpi.sh instead.

NP="${NP:-4}"
STEPS="${STEPS:-10000000}"

command -v mpicc >/dev/null 2>&1 || { echo "mpicc is required" >&2; exit 1; }
command -v mpirun >/dev/null 2>&1 || { echo "mpirun is required" >&2; exit 1; }

mkdir -p build
mpicc -O2 scripts/benchmarks/mpi_pi.c -lm -o build/mpi_pi

echo "Running local MPI Pi benchmark with ${NP} ranks and ${STEPS} integration steps"
mpirun -np "$NP" build/mpi_pi "$STEPS"
