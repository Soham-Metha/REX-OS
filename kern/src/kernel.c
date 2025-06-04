#include <kernel.h>
#include <vga.h>

extern void kernelMain()
{
    setBG(COLOR8_MAGENTA);
    clearScreen();
    print("Hello, kernel!");
}
