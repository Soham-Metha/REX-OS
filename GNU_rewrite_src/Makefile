
CC = gcc
AS = nasm
LD = ld

BINFORMAT = ./linker.ld
CFLAGS = -m32 -ffreestanding -nostdlib -nostartfiles -nodefaultlibs -Wall -O3 -Iinc -std=gnu99 -c -I ./src

BOOT_A = ./src/boot.S
KERN_C = $(wildcard ./src/*.c)

all: kernel.o boot.o
	$(LD) -m elf_i386 -T linker.ld -o kernel boot.o kernel.o
	mv kernel ./REX-OS/boot/kernel
	grub-mkrescue -o REX-OS.iso REX-OS/
	qemu-system-i386 REX-OS.iso

boot.o:
	$(AS) $(BOOT_A) -o $@ -f elf32

kernel.o:
	$(CC) $(CFLAGS) -c $(KERN_C) -o $@