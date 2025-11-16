#include <stdio.h>

__global__ void HelloWorld(){
    printf("Hello World!, %d, %d\n", blockIdx.x, threadIdx.x);
}

int main(){
    HelloWorld<<<1,1>>>();
    getchar();
    return 0;
}
