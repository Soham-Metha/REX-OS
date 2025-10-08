#include "vga.h"
#include "types.h"

uint16_t col                          = 0;
uint16_t row                          = 0;
volatile uint16_t (*const vga)[WIDTH] = (volatile uint16_t (*)[WIDTH])0xB8000;     // uint *const = constant pointer, const uint16_t* = pointer pointing to const value
const uint16_t defaultColor           = (COLOR8_BLACK << 12) | (COLOR8_LIGHT_GREY << 8);
uint16_t currentColor                 = defaultColor;

#define writeChar(ch)                        \
    {                                        \
        if (col == WIDTH)                    \
            newLine();                       \
        vga[row][col++] = currentColor | ch; \
    }

void row_clear(int row)
{
    for (uint16_t x = 0; x < WIDTH; x++)
        vga[row][x] = currentColor | ' ';
}

void clearScreen()
{
    col = 0;
    row = 0;

    for (uint16_t y = 0; y < HEIGHT; y++)
        row_clear(y);
}

void newLine()
{
    if (row < HEIGHT - 1)
        row += 1;
    else
        scrollUp();
    col = 0;
}

void scrollUp()
{
    for (uint16_t y = 1; y < HEIGHT; y++)
        for (uint16_t x = 0; x < WIDTH; x++)
            vga[y - 1][x] = vga[y][x];

    row_clear(HEIGHT - 1);
}

void print(const char* s)
{
    while (*s) {
        switch (*s) {
        case '\n':
            newLine();
            break;
        case '\r':
            col = 0;
            break;
        case '\t':
            int tabLen = 4 - (col % 4);
            while (tabLen--)
                writeChar(' ');
            break;
        default:
            writeChar(*s);
            break;
        }
        s += 1;
    }
}

void setBG(Color col)
{
    currentColor = ((currentColor & ~(0x0F << 12)) | (((col) & 0x0F) << 12));
}

void setFG(Color col)
{
    currentColor = ((currentColor & ~(0x0F << 8)) | (((col) & 0x0F) << 8));
}