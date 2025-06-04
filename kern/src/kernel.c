#include <kernel.h>
#include <vga.h>

extern void kernelMain()
{
    clearScreen();
    print("Hello, kernel!");
}
