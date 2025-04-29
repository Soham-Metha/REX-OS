#include "kernel.h"

extern void kernel_main(){
    char* display = 0xb8000;
    display[0] = 'H'; display[1] = 0x07;
    display[2] = 'e'; display[3] = 0x07;
    display[4] = 'l'; display[5] = 0x07;
    display[6] = 'l'; display[7] = 0x07;
    display[8] = 'o'; display[9] = 0x07;
    display[10] = ' '; display[11] = 0x07;
    display[12] = 'W'; display[13] = 0x07;
    display[14] = 'o'; display[15] = 0x07;
    display[16] = 'r'; display[17] = 0x07;
    display[18] = 'l'; display[19] = 0x07;
    display[20] = 'd'; display[21] = 0x07;
    display[22] = '!'; display[23] = 0x07;

    return;
}