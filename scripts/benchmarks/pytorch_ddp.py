import os
import time
import torch
import torch.distributed as dist
from torch.nn import Linear

def main():
    dist.init_process_group(backend="nccl")
    local_rank = int(os.environ.get("LOCAL_RANK", 0))
    torch.cuda.set_device(local_rank)

    model = Linear(1024, 1024).cuda()
    data = torch.randn(2048, 1024, device="cuda")

    # Warmup
    for _ in range(5):
        out = model(data)
        out.sum().backward()

    torch.cuda.synchronize()
    start = time.time()

    for _ in range(20):
        out = model(data)
        out.sum().backward()

    torch.cuda.synchronize()
    elapsed = time.time() - start

    if dist.get_rank() == 0:
        print(f"Elapsed: {elapsed:.2f}s")

    dist.destroy_process_group()


if __name__ == "__main__":
    main()