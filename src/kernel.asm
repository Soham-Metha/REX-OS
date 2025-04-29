section .text
    mov al, 'Z'
    mov ah, 0x0f
    mov [0xb8000], ax
    [BITS 32]
    [extern kernel_main]
    call 0x100000
    jmp $