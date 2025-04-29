

boot:
	nasm -f bin ./src/boot.asm -o ./bin/boot.bin &&
	echo " BOOT FILE UPDATED "

chkboot:
	make boot &&
	bless ./bin/boot.bin

execboot:
	@make boot &&
	@qemu-system-x86_64 -hda ./bin/boot.bin

clean:
	@rm -f ./bin/boot.bin