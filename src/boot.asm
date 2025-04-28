section .data
    hlo: db "Test?",0

section .text

_start:
    MOV CS, 0x07C0
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

    TIMES 510-($$-$) DB 0
    DW 0xAA55