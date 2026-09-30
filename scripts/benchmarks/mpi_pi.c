#include <mpi.h>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char **argv) {
    MPI_Init(&argc, &argv);

    int rank = 0, world = 1;
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &world);

    long long steps = 10000000LL;
    if (argc > 1) {
        steps = atoll(argv[1]);
    }
    if (steps <= 0) {
        if (rank == 0) fprintf(stderr, "steps must be > 0\n");
        MPI_Finalize();
        return 2;
    }

    const double step = 1.0 / (double)steps;
    double local_sum = 0.0;

    double start = MPI_Wtime();
    for (long long i = rank; i < steps; i += world) {
        double x = (i + 0.5) * step;
        local_sum += 4.0 / (1.0 + x * x);
    }
    local_sum *= step;

    double pi = 0.0;
    MPI_Reduce(&local_sum, &pi, 1, MPI_DOUBLE, MPI_SUM, 0, MPI_COMM_WORLD);
    double elapsed = MPI_Wtime() - start;

    double max_elapsed = 0.0;
    MPI_Reduce(&elapsed, &max_elapsed, 1, MPI_DOUBLE, MPI_MAX, 0, MPI_COMM_WORLD);

    if (rank == 0) {
        printf("MPI ranks: %d\n", world);
        printf("Integration steps: %lld\n", steps);
        printf("Estimated Pi: %.12f\n", pi);
        printf("Absolute error: %.12e\n", fabs(M_PI - pi));
        printf("Runtime (max rank): %.6f s\n", max_elapsed);
    }

    MPI_Finalize();
    return 0;
}
