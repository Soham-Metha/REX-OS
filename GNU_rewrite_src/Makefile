
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

chkboot: REX-OS.iso
	@qemu-system-i386 $^
	@bless $(KERN_F)

boot.o:
	@$(AS) $(BOOT_A) -o $@ -f elf32

kernel.o:
	@$(CC) $(CFLAGS) -c $(KERN_C) -o $@

kernel: boot.o kernel.o
	@$(LD) $(LFLAGS) -o $@ $^
	@mv $@ $(KERN_F)

REX-OS.iso: kernel
	@grub-mkrescue -o $@ $(REXDIR)

clean:
	@rm -f ./*.bin
	@rm -f ./*.o