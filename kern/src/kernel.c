#include <kernel.h>
#include <vga.h>

extern void kernelMain()
{
    setBG(COLOR8_CYAN);
    clearScreen();
    print("Hello, kernel!");
}
