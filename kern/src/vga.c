#include "vga.h"
#include "types.h"

uint16_t *vga = (uint16_t *)0xB8000;
uint16_t column = 0;
uint16_t line = 0;
const uint16_t defaultColor = (COLOR8_BLACK << 8) | (COLOR8_LIGHT_GREY << 12);
uint16_t currentColor = defaultColor;

void clearScreen()
{
    column = 0;
    line = 0;
    currentColor = defaultColor;

    for (uint16_t y = 0; y < HEIGHT; y++)
        for (uint16_t x = 0; x < WIDTH; x++)
            vga[y * WIDTH + x] = currentColor | ' ';
}

void newLine()
{
    if (line < HEIGHT - 1)
    {
        line += 1;
        column = 0;
    }
}

void scrollUp()
{
}

void print(const char *)
{
}