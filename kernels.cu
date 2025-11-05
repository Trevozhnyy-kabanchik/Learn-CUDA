#include <iostream>
#include <algorithm>
#include <random>

#define N 16

__global__ void MatAdd(float A[N][N], float B[N][N], float C[N][N]){
    int i = blockIdx.x * blockDim.x + threadIdx.x;
    int j = blockIdx.y * blockDim.y + threadIdx.y;
    if (i < N && j < N){
        C[i][j] = A[i][j] + B[i][j];
    }
}

int main(){
    float A[N][N], B[N][N], C[N][N];
    for (int i = 0; i < N; ++i){
        for (int j = 0; j < N; ++j){
            A[i][j] = rand();
            B[i][j] = rand();
        }
    }

    dim3 threadsPerBlock(4,4);
    dim3 numBlocks((N + 3) / threadsPerBlock.x, (N + 3) / threadsPerBlock.y);
    MatAdd<<<numBlocks, threadsPerBlock>>>(A,B,C);
    for (int i = 0; i < N; ++i){
        for (int j = 0; j < N; ++j){
            std::cout << C[i][j] << " ";
        }
        std::cout << "\n";
    }


    return 0;
}