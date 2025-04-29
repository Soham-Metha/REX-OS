[BITS 32]

global _start

_start:
    [BITS 32]
    [extern kernel_main]
    call kernel_main
    HLT
