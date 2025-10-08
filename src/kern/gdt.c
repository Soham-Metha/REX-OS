#include "gdt.h"

extern void gdtFlush(uint32_t);

Descriptor gdtEntries[5];
GdtPtr gdtPtr;

void initGdt()
{
    gdtPtr.limit = (sizeof(Descriptor) * 5) - 1;
    gdtPtr.base  = (uint32_t)&gdtEntries;

    setGdtEntry(0, 0, 0, 0, 0);
    setGdtEntry(1, 0, 0xFFFFFFFF, 0x9A, 0xCF);
    setGdtEntry(2, 0, 0xFFFFFFFF, 0x92, 0xCF);
    setGdtEntry(3, 0, 0xFFFFFFFF, 0xFA, 0xCF);
    setGdtEntry(4, 0, 0xFFFFFFFF, 0xF2, 0xCF);
    gdtFlush((uint32_t)&gdtPtr);
}

void setGdtEntry(uint32_t num, uint32_t base, uint32_t limit, uint8_t access, uint8_t flags)
{
    gdtEntries[num].base_00_15         = base & 0xFFFF;
    gdtEntries[num].base_16_23         = (base >> 16) & 0xFF;
    gdtEntries[num].base_24_31         = (base >> 24) & 0xFF;

    gdtEntries[num].limit_00_15        = limit & 0xFFFF;
    gdtEntries[num].limit_16_19_flags  = (limit >> 16) & 0x0F;

    gdtEntries[num].limit_16_19_flags |= flags & 0xF0;
    gdtEntries[num].AccessByte         = access;
}
