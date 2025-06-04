
CC = gcc
AS = nasm
LD = ld

FORMAT = ./linker.ld
CFLAGS = -m32 -ffreestanding -nostdlib -nostartfiles -nodefaultlibs -Wall -O3 -Iinc -std=gnu99 -c -I ./src
LFLAGS = -m elf_i386 -T $(FORMAT)

BOOT_A = ./src/boot.S
KERN_C = $(wildcard ./src/*.c)

REXDIR = ./REX-OS/
BOOT_D = ./REX-OS/boot
KERN_F = ./REX-OS/boot/kernel

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

kernel: boot.o kernel.o
	@$(LD) $(LFLAGS) -o $@ $^
	@echo " 	KERNEL LINKED "
	@mv $@ $(KERN_F)
	@echo " 	REX DIR UPDATED "

boot.o:
	@$(AS) $(BOOT_A) -o $@ -f elf32
	@echo " 	BOOT FILE UPDATED "

kernel.o:
	@$(CC) $(CFLAGS) -c $(KERN_C) -o $@
	@echo " 	KERNEL C FILE PROCESSED "

clean:
	@rm -f ./*.bin
	@rm -f ./*.o
	@rm -f ./*.iso