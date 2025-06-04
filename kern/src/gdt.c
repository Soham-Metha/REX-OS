#include "gdt.h";

extern void gdt(addr_t);

Descriptor gdtEntries[5];
GdtPtr gdtPtr;

void initGdt()
{
    gdtPtr.limit = (sizeof(Descriptor) * 5) - 1;
    gdtPtr.base = &gdtEntries;

    setGdtEntry(0, 0, 0, 0, 0);
    setGdtEntry(1, 0, 0xFFFFFFFF, 0x9A, 0xCF);
    setGdtEntry(2, 0, 0xFFFFFFFF, 0x92, 0xCF);
    setGdtEntry(3, 0, 0xFFFFFFFF, 0xFA, 0xCF);
    setGdtEntry(4, 0, 0xFFFFFFFF, 0xF2, 0xCF);
}
void setGdtEntry(uint32_t num, uint32_t base, uint32_t limit, uint8_t access, uint8_t flags);