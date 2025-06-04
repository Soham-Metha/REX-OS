
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
    MOVL    $stackTop,      %ESP
    CALL    kernelMain
    HLT

haltKernel:
    CLI
    HLT
    JMP     haltKernel

gdtFlush:
    MOVL    4(%esp),    %eax
    LGDT    (%eax)
    MOVL    %eax,       0x10
    MOVL    %DS,        %eax
    MOVL    %ES,        %eax
    MOVL    %FS,        %eax
    MOVL    %GS,        %eax
    MOVL    %SS,        %eax

.section .bss
    .lcomm  stackSpace,     8192
stackTop:
