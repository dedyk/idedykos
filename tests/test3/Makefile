SRC=src
BIN=bin

kernel1: bootsector.bin kernel1.bin

bootsector.bin: ${SRC}/bootsector.asm
	nasm ${SRC}/bootsector.asm -f bin -o ${BIN}/bootsector.bin

kernel1.o: ${SRC}/kernel1.asm
	nasm ${SRC}/kernel1.asm -f elf -o ${BIN}/kernel1.o

kernelc.o: ${SRC}/kernel.c
	gcc -o ${BIN}/kernelc.o -c ${SRC}/kernel.c -Wall -Wextra -nostdlib -nostartfiles -nodefaultlibs

kernel.bin: kernel1.o kernelc.o
	ld -T ${SRC}/linker.ld -o ${BIN}/kernel.bin ${BIN}/kernel1.o ${BIN}/kernelc.o

kernel1makefloppy: kernel.bin
	dd bs=750 count=1 if=/dev/zero of=${BIN}/pad
	cat /boot/grub/stage1 /boot/grub/stage2 ${BIN}/pad ${BIN}/kernel.bin > ${BIN}/kernel1floppy.img
	
clean:
	rm -f ${BIN}/kernel1.s
	rm -f ${BIN}/bootsector.bin
	rm -f ${BIN}/emptyfloppy.img
	rm -f ${BIN}/kernel1floppy.img
