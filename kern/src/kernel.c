#include <kernel.h>
#include <vga.h>

extern void kernelMain()
{
    setBG(COLOR8_BROWN);
    clearScreen();
    print("Hello, kernel!");
}
