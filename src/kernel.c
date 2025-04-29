#include "kernel.h"

void kernel_main(){
    *(char*)0xb8000 = "HELLO WORLD!";
    return;
}