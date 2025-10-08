#include <gdt.h>
#include <kernel.h>
#include <vga.h>

extern void kernelMain()
{
    initGdt();
    setBG(COLOR8_BLUE);
    setFG(COLOR8_LIGHT_RED);
    clearScreen();
    print("Hello, kernel!");
}
