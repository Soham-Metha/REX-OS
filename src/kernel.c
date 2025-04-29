
extern void kernel_main() {
    
    char* str = "Hello, Kernel!";
    char* vga = (char*)0xB8000;
    while (*str) {
        *vga = *str | 0x0F00;
        str++;
        vga+=2;
    }

    while (1) {
        
    }
}
