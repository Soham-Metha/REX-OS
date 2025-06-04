[BITS 32]

section .text
    ; MULTIBOOT HEADER of size 8 bytes
    ALIGN   4
    DD      0x1BADB002
    DD      0x00000000
    ; checksum
    DD      -( 0x1BADB002 + 0x00000000 )

global start
extern kernelMain

start:
    LJMP    0x7C00,_start

_start:
    CLI
    MOV     ESP, stackSpace
    CALL    kernelMain
    HLT

haltKernel:
    CLI
    HLT
    JMP     haltKernel

section .bss
    RESB    8192
stackSpace: