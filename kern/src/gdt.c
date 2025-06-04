#include "gdt.h";

extern void gdt(addr_t);

Descriptor gdtEntries[5];
GdtPtr gdtPtr;

void initGdt()
{
    gdtPtr.limit = (sizeof(Descriptor)*5)-1;
    gdtPtr.base = &gdtEntries;
}
void setGdtEntry(uint32_t num, uint32_t base, uint32_t limit, uint8_t access, uint8_t flags);