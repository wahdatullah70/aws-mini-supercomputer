#!/usr/bin/env bash
set -euo pipefail

# Simple MPI Pi benchmark using mpirun
# Replace with a real MPI binary if desired

python3 - <<'PY'
import time

start = time.time()
pi = sum(4.0 * ((-1)**k) / (2*k+1) for k in range(1_000_000))
print(f"Estimated Pi: {pi}")
print(f"Runtime: {time.time()-start:.2f}s")
PY
