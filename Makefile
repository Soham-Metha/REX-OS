export PREFIX := ./libs/cross
export PATH := $(PREFIX)/bin:$(PATH)

CC = i686-elf-gcc
AS = i686-elf-as
LD = i686-elf-ld

K_HEAD = ./kern/headers
K_CODE = ./kern/src

FORMAT = ./linker.ld
REXDIR = ./REX-OS/

BOOT_D = ./REX-OS/boot
KERN_F = ./REX-OS/boot/kernel
BOOT_A = ./src/boot.S

CFLAGS = -ffreestanding -Wall -O3 -std=gnu99 -c -I $(K_HEAD)
LFLAGS = -m elf_i386 -T $(FORMAT)

execboot: REX-OS.iso
	@qemu-system-i386 	-drive format=raw,file="$^"
	@make clean

chkboot: REX-OS.iso
	@qemu-system-i386 	-drive format=raw,file="$^"
	@bless $(KERN_F)
	@make clean

REX-OS.iso: kernel
	@grub-mkrescue 		-o $@ $(REXDIR)
	@echo " 	REX ISO UPDATED "

kernel: boot.o kernel.o vga.o gdt.o
	@$(LD) $(LFLAGS) 	-o $@ $^
	@echo " 	KERNEL LINKED "

	@mv $@ $(KERN_F)
	@echo " 	REX DIR UPDATED "

boot.o:
	@$(AS) $(BOOT_A) 	-o $@ --32
	@echo " 	BOOT FILE UPDATED "

kernel.o:
	@$(CC) $(CFLAGS) 	-o $@ $(K_CODE)/kernel.c
	@echo " 	KERNEL C FILE PROCESSED "

vga.o:
	@$(CC) $(CFLAGS) 	-o $@ $(K_CODE)/vga.c
	@echo " 	VGA C FILE PROCESSED "

gdt.o:
	@$(CC) $(CFLAGS) 	-o $@ $(K_CODE)/gdt.c
	@echo " 	GDT C FILE PROCESSED "

clean:
	@rm -f ./*.bin
	@rm -f ./*.o
	@rm -f ./*.iso