# Distributed ML (PyTorch DDP)

This example runs **PyTorch Distributed Data Parallel (DDP)** across multiple nodes.

## Environment setup (head node)
```bash
module load python
python3 -m venv ~/venv
source ~/venv/bin/activate
pip install torch torchvision
```

## Prepare dataset (simple synthetic)
The example uses synthetic data to keep setup minimal.

## Run DDP job
```bash
sbatch scripts/benchmarks/run_ddp.sh
```

## Notes
- The job script uses Slurm to launch multiple processes per node.
- Tune `--nodes` and `--ntasks-per-node` for your cluster size.

## Results to capture
- Epoch time
- Throughput (samples/sec)
- Scaling efficiency
