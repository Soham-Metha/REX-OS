[ORG 0x7C00]

section .data
dataStart:
    CODE_OFFSET equ 0x8
    DATA_OFFSET equ 0x10
    gdtStart:
        dd 0
        dd 0

        db 0xFFFF
        DB 0x0000
        DB 0x00
        DB 10011010b
        DB 11001111b
        DB 0x00
        
        db 0xFFFF
        DB 0x0000
        DB 0x00
        DB 10010010b
        DB 11001111b
        DB 0x00

    gdt:
        DW gdt-gdtStart-1
        DD gdtStart

    bootable: DW 0xAA55
datalen: EQU $-dataStart

section .text

_start:
    CLI
    MOV AX, CS
    MOV DS, AX
    MOV ES, AX
    MOV SS, AX
    MOV SP, 0x7C00
    STI

loadProtectedMode:
    CLI
    LGDT [gdt]
    MOV EAX,CR0
    OR AL, 1
    MOV CR0,EAX

main:
    MOV AX, DATA_OFFSET
    MOV DS, AX
    MOV ES, AX
    MOV FS, AX
    MOV GS, AX
    MOV SS, AX
    MOV EBP,0x9C00
    MOV ESP,EBP

    IN AL, 0x92
    OR AL, 2
    OUT 0x92, AL

    JMP $

exit:
    CLI
    HLT

    TIMES (510-($-$$)-datalen) DB 0