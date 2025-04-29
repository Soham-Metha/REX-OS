
extern void kernel_main() {
    
    char* str = "Hello, Kernel!";
    *(char*)0xB8000 = *str;

    while (1) {
        
    }
}
