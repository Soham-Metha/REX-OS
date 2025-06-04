
.section .text 
    .code32

    /* MULTIBOOT HEADER of 8 bytes + checksum */
    .align  4
    .long   0x1BADB002
    .long   0x00000000
    .long   -(0x1BADB002 + 0x00000000)

    .globl  start
    .globl  gdtFlush
    .extern kernelMain

start:
    CLI
    MOVL    $stackSpace + 8192,      %ESP
    CALL    kernelMain
    HLT

haltKernel:
    CLI
    HLT
    JMP     haltKernel

gdtFlush:
    MOVL    4(%esp),    %eax
    LGDT    (%eax)
    MOVW    $0x10,      %ax
    MOVW    %ax,        %ds
    MOVW    %ax,        %es
    MOVW    %ax,        %fs
    MOVW    %ax,        %gs
    MOVW    %ax,        %ss
    ljmp    $0x08,      $flush

flush:
    RET

.section .bss
    .lcomm  stackSpace,     8192
stackTop:
