#include <kernel.h>
#include <vga.h>

extern void kernelMain()
{
    setBG(COLOR8_BLUE);
    clearScreen();
    print("Hello, kernel!");
}
