#pragma once
#include "types.h"

typedef enum {
    COLOR8_BLACK,
    COLOR8_BLUE,
    COLOR8_GREEN,
    COLOR8_CYAN,
    COLOR8_RED,
    COLOR8_MAGENTA,
    COLOR8_BROWN,
    COLOR8_LIGHT_GREY,
    COLOR8_DARK_GREY,
    COLOR8_LIGHT_BLUE,
    COLOR8_LIGHT_GREEN,
    COLOR8_LIGHT_CYAN,
    COLOR8_LIGHT_RED,
    COLOR8_LIGHT_MAGENTA,
    COLOR8_LIGHT_BROWN,
    COLOR8_WHITE
} Color;

#define WIDTH 80
#define HEIGHT 25

void print(const char *);
void clearScreen();
void newLine();
void scrollUp();