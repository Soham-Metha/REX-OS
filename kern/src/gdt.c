#include "gdt.h";

void initGdt();
void setGdtEntry(uint32_t num, uint32_t base, uint32_t limit, uint8_t access, uint8_t flags);