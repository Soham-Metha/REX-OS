#include "vga.h"
#include "types.h"
#define writeChar(ch)                                                                                                  \
    {                                                                                                                  \
        if (column == WIDTH)                                                                                           \
            newLine();                                                                                                 \
        vga[line * WIDTH + (column++)] = ch | currentColor;                                                            \
    }

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
        line += 1;
    else
        scrollUp();
    column = 0;
}

void scrollUp()
{
    for (uint16_t y = 1; y < HEIGHT; y++)
        for (uint16_t x = 0; x < WIDTH; x++)
            vga[(y - 1) * WIDTH + x] = vga[y * WIDTH + x];

    for (uint16_t x = 0; x < WIDTH; x++)
        vga[(HEIGHT - 1) * WIDTH + x] = currentColor | ' ';
}

void print(const char *s)
{
    while (*s)
    {
        switch (*s)
        {
        case '\n':
            newLine();
            break;
        case '\r':
            column = 0;
            break;
        case '\t':
            int tabLen = 4 - (column % 4);
            while (tabLen)
                writeChar(' ');
            break;
        default:
            writeChar(*s);
            break;
        }
        s += 1;
    }
}
