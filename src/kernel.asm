[BITS 32]

global _start

_start:
    mov al, 'A'
    mov ah, 0x0f
    mov [0xb8000], ax
    [BITS 32]
    [extern kernel_main]
    ;call kernel_main
    HLT

times 512-($ - $$) db 0