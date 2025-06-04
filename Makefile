CC = gcc
AS = nasm
LD = ld

K_HEAD = ./kern/headers
K_CODE = ./kern/src

FORMAT = ./linker.ld
REXDIR = ./REX-OS/

BOOT_D = ./REX-OS/boot
KERN_F = ./REX-OS/boot/kernel
BOOT_A = ./src/boot.S

CFLAGS = -m32 -ffreestanding -Wall -O3 -std=gnu99 -c -I $(K_HEAD)
LFLAGS = -m elf_i386 -T $(FORMAT)

execboot: REX-OS.iso
	@qemu-system-i386 $^
	@make clean

chkboot: REX-OS.iso
	@qemu-system-i386 $^
	@bless $(KERN_F)
	@make clean

REX-OS.iso: kernel
	@grub-mkrescue -o $@ $(REXDIR)
	@echo " 	REX ISO UPDATED "

kernel: boot.o kernel.o vga.c
	@$(LD) $(LFLAGS) -o $@ $^
	@echo " 	KERNEL LINKED "

	@mv $@ $(KERN_F)
	@echo " 	REX DIR UPDATED "

boot.o:
	@$(AS) $(BOOT_A) -o $@ -f elf32
	@echo " 	BOOT FILE UPDATED "

kernel.o:
	@$(CC) $(CFLAGS) -o $@ $(K_CODE)/kernel.c
	@echo " 	KERNEL C FILE PROCESSED "

vga.o:
	@$(CC) $(CFLAGS) -o $@ $(K_CODE)/vga.c
	@echo " 	KERNEL C FILE PROCESSED "

clean:
	@rm -f ./*.bin
	@rm -f ./*.o
	@rm -f ./*.iso