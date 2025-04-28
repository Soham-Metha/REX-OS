[ORG 0x7C00]
section .data
    bootable: DW 0xAA55
    hlo: db "Test?",0

section .text

_start:
    CLI
    MOV AX, CS
    MOV DS, AX
    MOV ES, AX
    MOV SS, AX
    MOV SP, 0x7C00
    STI
    MOV SI, hlo

printstr:

    LODSB
    CMP AL,0
    JE  exit
    MOV AH, 0x0E
    INT 10H
    JMP printstr

exit:
    CLI
    HLT