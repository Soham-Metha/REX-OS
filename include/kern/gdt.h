#include "types.h"

typedef struct descriptor {
    uint16_t limit_00_15;
    uint16_t base_00_15;
    uint8_t  base_16_23;
    uint8_t  AccessByte;
    uint8_t  limit_16_19_flags;
    uint8_t  base_24_31;
} __attribute__((packed)) Descriptor;

typedef struct gdtPtr {
    uint16_t limit;
    uint32_t base;
} __attribute__((packed)) GdtPtr;

void initGdt();
void setGdtEntry(uint32_t, uint32_t, uint32_t, uint8_t, uint8_t);