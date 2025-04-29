[BITS 32]

global _start

_start:

    [extern kernel_main]
    call kernel_main

times 512-($ - $$) db 0