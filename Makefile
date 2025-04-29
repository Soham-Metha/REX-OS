CC = i686-elf-gcc
LD = i686-elf-ld
IDIR = ./src
BINFORMAT = ./binFormat.ld
FLAGS = -g -ffreestanding -nostdlib -nostartfiles -nodefaultlibs -Wall -O0 -Iinc 
FILES = ./bin/kernelWrapper.o ./bin/kernel.o

boot:
	@nasm 	-f bin	./src/boot.asm 			-o ./bin/boot.bin 			
	@nasm  -g 	./src/kernel.asm 		-o ./bin/kernelWrapper.o 	-f elf
	@$(CC) -c 	./src/kernel.c 			-o ./bin/kernel.o 			-std=gnu99 	-I $(IDIR) $(FLAGS) 
	@$(LD) -g  	$(FILES) 				-o ./bin/kernel.bin 		-Ttext 0x1000 --oformat binary

	@dd 		if=./bin/boot.bin 			>> ./bin/os.bin
	@dd 		if=./bin/kernel.bin 		>> ./bin/os.bin
#	@dd 		if=/dev/zero bs=512 count=8 >> ./bin/os.bin

	@echo " BOOT FILE UPDATED "

chkboot:
	@make boot
	@bless ./bin/os.bin

execboot:
	@make boot
	@qemu-system-x86_64 -drive format=raw,file="./bin/os.bin",index=0,if=floppy,  -m 128M

clean:
	@rm -f ./bin/*
