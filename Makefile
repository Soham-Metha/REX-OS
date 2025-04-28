

boot:
	@nasm -f bin ./src/boot.asm -o ./bin/boot.bin
	@echo " BOOT FILE UPDATED "

chkboot:
	@make boot &&
	@bless ./bin/boot.bin

execboot:
	@make boot

clean:
	rm -f ./bin/boot.bin