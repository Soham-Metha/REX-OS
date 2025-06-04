#include <kernel.h>
#include <vga.h>

extern void kernelMain()
{
    setBG(COLOR8_RED);
    clearScreen();
    print("Hello, kernel!");
}
