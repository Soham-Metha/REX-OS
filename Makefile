export PREFIX := $(HOME)/opt/cross
export TARGET := i686-elf
export PATH := $(PREFIX)/bin:$(PATH)

CC = i686-elf-gcc
AS = nasm
LD = i686-elf-ld

BINFORMAT = ./binFormat.ld
CFLAGS = -ffreestanding -nostdlib -nostartfiles -nodefaultlibs -Wall -O3 -Iinc -std=gnu99 -c -I ./src

BOOT_A   = ./src/boot.asm
KERNEL_A = $(filter-out $(BOOT_A), $(wildcard ./src/*.asm))
KERNEL_C = $(wildcard ./src/*.c)

KERNEL_A_OBJ = ./kernelWrapper.o
KERNEL_C_OBJ = ./kernel.o
FILES = 	   $(KERNEL_A_OBJ) 	   $(KERNEL_C_OBJ)

execboot: all clean
	@qemu-system-x86_64 -drive format=raw,file="./os.bin",index=0,if=floppy,  -m 128M

chkboot: execboot
	@bless 	./os.bin

all: boot.bin kernel.bin

	@dd 	if=./boot.bin 				>> ./os.bin
	@dd 	if=./kernel.bin 			>> ./os.bin
#	@dd 	if=/dev/zero bs=512 count=8 >> ./os.bin
	@echo " 	OS BINARY UPDATED "

kernel.bin:
	@$(AS)	$(KERNEL_A) -o $(KERNEL_A_OBJ) -f elf
	@echo " 	KERNEL ASSEMBLY FILE PROCESSED "
	@$(CC)  $(KERNEL_C) -o $(KERNEL_C_OBJ) $(CFLAGS)
	@echo " 	KERNEL C FILE PROCESSED "
	
	@$(LD)  $(FILES) 	-o $@ -Ttext 0x1000 --oformat binary
	@echo " 	KERNEL LINKED "

boot.bin:
	@$(AS) 	$(BOOT_A) 	-o $@ -f bin

	@echo " 	BOOT FILE UPDATED "

clean:
	@rm -f ./*.bin
	@rm -f ./*.o