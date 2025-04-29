#/bin/bash

export PREFIX="$HOME/opt/cross"
export TARGET=i686-elf
export PATH="$PREFIX/bin:$PATH"

rm ./bin/os.bin
make $1
i686-elf-objdump -D ./bin/kernel.bin
