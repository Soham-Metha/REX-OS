[BITS 32]

section .text
    ; MULTIBOOT HEADER of size 8 bytes
    ALIGN   4
    DD      0x1BADB002
    DD      0x00000000
    ; checksum
    DD      -( 0x1BADB002 + 0x00000000 )