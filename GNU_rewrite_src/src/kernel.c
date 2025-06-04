#include <kernel.h>

void test2(){

    char* str = "Dont print this2222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222!";
    char* vga = (char*)0xB8000;
    while (*str) {
        *vga = *str | 0x0F00;
        str++;
        vga+=2;
    }

}

extern void kernelMain() {
    
    char* str = "Hello, Kernel!";
    char* vga = (char*)0xB8000;
    while (*str) {
        *vga = *str | 0x0F00;
        str++;
        vga+=2;
    }
    while (1) {
        
    }
}

void test(char* vga){

    char* str = " Dont print thissssssssssss!";
    while (*str) {
        *vga = *str | 0x0F00;
        str++;
        vga+=2;
    }

}