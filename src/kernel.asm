[BITS 32]
.text
global _start
extern kernel_main

_start:
    call kernel_main
    jmp$

times 512-($ - $$) db 0