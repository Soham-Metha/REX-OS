#include "kernel.h"

extern void kernel_main(){
    return;
    char* vga = (char*) 0xb8000;
    vga[0] = 'H'; vga[1] = 0x07;
    vga[2] = 'e'; vga[3] = 0x07;
    vga[4] = 'l'; vga[5] = 0x07;
    vga[6] = 'l'; vga[7] = 0x07;
    vga[8] = 'o'; vga[9] = 0x07;
    vga[10] = ' '; vga[11] = 0x07;
    vga[12] = 'W'; vga[13] = 0x07;
    vga[14] = 'o'; vga[15] = 0x07;
    vga[16] = 'r'; vga[17] = 0x07;
    vga[18] = 'l'; vga[19] = 0x07;
    vga[20] = 'd'; vga[21] = 0x07;
    vga[22] = '!'; vga[23] = 0x07;

    return;
}