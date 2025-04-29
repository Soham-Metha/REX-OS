ENTRY(_start)
OUTPUT_FORMAT(binary)
SECTIONS
{
    . = 0x0100000;
    .text : ALIGN(4096)
    {
        *(.text)
    }
    .code : ALIGN(4096)
    {
        *(.code)
    }

    .rodata : ALIGN(4096)
    {
        *(.rodata)
    }

    .data : ALIGN(4096)
    {
        *(.data)
    }

    .bss : ALIGN(4096)
    {
        *(COMMON)
        *(.bss)
    }
}