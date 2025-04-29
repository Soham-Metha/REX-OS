#include "kernel.h"

extern void kernel_main(){
    
    *(char*)0xb8000 = 'H';

    return;
}