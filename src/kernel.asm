[BITS 32]

global _start

_start:

    [extern kernel_main]
    call kernel_main
    jmp $

times 511-($ - $$) db 0