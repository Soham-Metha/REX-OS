
extern void kernel_main() {
    
    char* str = "Hello, Kernel!";
    while (*str) {
        *(char*)0xB8000 = *str | 0x0F00;
        str++;
    }

    while (1) {
        
    }
}
