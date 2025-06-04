#include "types.h"

typedef struct descriptor {
    uint16_t limit_0_15;
    uint16_t base_0_15;
    uint8_t base_16_23;
    uint8_t AccessByte;
    uint8_t limit_16_19_flags;
    uint8_t base_24_31;
} __attribute__((packed)) Descriptor;