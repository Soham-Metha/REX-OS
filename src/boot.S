
.section .text 
    .code32

    /* MULTIBOOT HEADER of 8 bytes + checksum */
    .align  4
    .long   0x1BADB002
    .long   0x00000000
    .long   -(0x1BADB002 + 0x00000000)

    .globl  start
    .extern kernelMain

start:
    CLI
    MOVL    $stackTop,      %ESP
    CALL    kernelMain
    HLT

haltKernel:
    CLI
    HLT
    JMP     haltKernel

.section .bss
    .lcomm  stackSpace,     8192
stackTop:
