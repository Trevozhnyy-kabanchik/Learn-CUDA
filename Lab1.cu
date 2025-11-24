#include <iostream>
#include "stdio.h"
__global__ void sum2(double number_one, double number_two){
    printf("Result: %f, %d, %d", number_one + number_two, blockIdx.x, threadIdx.x);
}

int main(){
    double one, two;
    std::cout << "Введите 2 числа:\n";
    std::cin >> one >> two;
    sum2<<<1,1>>>(one, two);
    cudaDeviceSynchronize();
    return 0;
}