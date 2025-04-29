[ORG 0x7C00]

section .text

startRealMode:
    MOV AL, 8   ; SECTORS TO READ?
    MOV CH, 0   ; C
    MOV DH, 0   ; H
    MOV CL, 2   ; S
    MOV BX, KERNEL_BASE
    MOV AH, 2
    INT 0x13

    jc exit

    CLI
    MOV AX, CS
    MOV DS, AX
    MOV ES, AX
    MOV SS, AX
    MOV SP, 0x7C00
    STI

    MOV AH, 0x00
    MOV AL,0x03
    INT 0x10
    ;load Protected Mode
    CLI
    LGDT [gdt]
    MOV EAX,CR0
    OR AL, 1
    MOV CR0,EAX
    JMP CODE_OFFSET:startProtectedMode

[BITS 32]
startProtectedMode:
    ; After entering Protected Mode, the segment registers must be selectors that point to entries in the GDT
    MOV AX, DATA_OFFSET
    MOV DS, AX
    MOV ES, AX
    MOV FS, AX
    MOV GS, AX
    MOV SS, AX
    MOV EBP,0x9C00
    MOV ESP,EBP

    ; Trick to enable pin A20
    IN AL, 0x92
    OR AL, 2
    OUT 0x92, AL

    JMP CODE_OFFSET:KERNEL_BASE

exit:
    CLI
    HLT


dataStart:
    KERNEL_BASE  equ 0x1000      ; segment base address for kernel

    gdtStart:
        dd 0
        dd 0

    codeDescriptor:             ;   |---------------------------------|------------------------------------|
        dW 0xFFFF               ;   |       BASE ADDRESS              |         SEGMENT LIMIT              |    First 16 bits of limit
        DW 0x0000               ;   |           0 - 15                |             0 - 15                 |    First 16 bits of base
        DB 0x00                 ;   |----------------------------------------------------------------------|    Next 8 bits of base
        DB 10011010b            ;   | BASE  | G | D | L | AVL | LIMIT | P | DPL | S | E | C | R | A | BASE |    Present [1], DPL [00], System [1], Type(Executable,Conforming,Read) [101], Access [0]
        DB 11001111b            ;   | 24-31 |   |   |   |     |       |   |     |   |           |          |    G [1], D[1], L [0], AVL [0], Limit [1111]
        DB 0x00                 ;   |---------------------------------|------------------------------------|    Last 16 bits of base

    dataDescriptor:             ;
        dW 0xFFFF               ;
        DW 0x0000               ;
        DB 0x00                 ;
        DB 10010010b            ;
        DB 11001111b            ;
        DB 0x00                 ;

    gdt:
        DW gdt-gdtStart-1
        DD gdtStart

    CODE_OFFSET equ codeDescriptor-gdtStart
    DATA_OFFSET equ dataDescriptor-gdtStart

TIMES 510-($-$$) DB 0
DW 0xAA55