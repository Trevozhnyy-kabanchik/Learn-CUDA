#include <iostream>
#include <cstdlib>
#include <ctime>

#define N 16 //узнать как по-другому надо, потому что сейчас это кастыль

__global__ void MatAdd(float A[N][N], float B[N][N], float C[N][N]){
    int i = blockIdx.x * blockDim.x + threadIdx.x;
    int j = blockIdx.y * blockDim.y + threadIdx.y;
    if (i < N && j < N){
        C[i][j] = A[i][j] + B[i][j];
    }
}

int main(){
    srand(time(0));
    float A[N][N], B[N][N], C[N][N]; //нельзя в мейне инициализировать массивы для GPU, потому что 
    for (int i = 0; i < N; ++i){
        for (int j = 0; j < N; ++j){
            A[i][j] = rand(); //изменить инициализацию случайных данных
            B[i][j] = rand(); //изменить инициализацию случайных данных
        }
    }

    int T = 4;
    dim3 threadsPerBlock(T,T);
    dim3 numBlocks((N + T - 1) / threadsPerBlock.x, (N + T - 1) / threadsPerBlock.y);
    MatAdd<<<numBlocks, threadsPerBlock>>>(A,B,C);
    for (int i = 0; i < N; ++i){ //вывожу не дожидаясь завершения вычислений на GPU, начинается гонка
        for (int j = 0; j < N; ++j){
            std::cout << C[i][j] << " ";
        }
        std::cout << "\n";
    }


    return 0;
}