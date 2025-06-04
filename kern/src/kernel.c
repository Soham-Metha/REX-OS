#include <kernel.h>
#include <vga.h>

extern void kernelMain()
{
    //char *str = "Hello, Kernel!";
    print("Hello, kernel!");
}
