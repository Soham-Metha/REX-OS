
.section .text
    .code32

    /* MULTIBOOT HEADER */
    .align 4
    .long 0x1BADB002          /* magic */
    .long 0x00000000          /* flags */
    .long -(0x1BADB002 + 0x00000000)  /* checksum */

    .globl start
    .extern kernelMain

start:
    ljmp $0x7C00, $_start     /* Far jump to flush prefetch */

_start:
    cli
    movl $stackSpace, %esp
    call kernelMain
    hlt

haltKernel:
    cli
    hlt
    jmp haltKernel

/* Stack space */
    .section .bss
    .lcomm stackSpace, 8192   /* Reserve 8KB stack */
/*
.text
    /* MULTIBOOT HEADER of size 8 bytes */
    ALIGN   4
    DD      0x1BADB002
    DD      0x00000000
    ; checksum
    DD      -( 0x1BADB002 + 0x00000000 )

.global start
extern kernelMain

start:
    LJMP    0x7C00,$_start

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
stackSpace:*/