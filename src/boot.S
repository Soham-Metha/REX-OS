
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
    /* stack extends downwards, so ESP should be 'after' the space allocated */
    CALL    kernelMain
    HLT

haltKernel:
    CLI
    HLT
    JMP     haltKernel

gdtFlush:
    MOVL    4(%ESP),    %EAX
    LGDT    (%EAX)
    MOVW    $0x10,      %AX
    MOVW    %AX,        %DS
    MOVW    %AX,        %ES
    MOVW    %AX,        %FS
    MOVW    %AX,        %GS
    MOVW    %AX,        %SS
    LJMP    $0x08,      $flush /* LJMP to update the CS */

flush:
    RET

.section .bss
    .lcomm  stackSpace,     8192
