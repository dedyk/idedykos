SRC=src
BIN=bin

kernel1: bootsector.bin kernel1.bin

bootsector.bin: ${SRC}/bootsector.asm
	nasm ${SRC}/bootsector.asm -f bin -o ${BIN}/bootsector.bin

kernel1.bin: ${SRC}/kernel1.asm
	nasm ${SRC}/kernel1.asm -f bin -o ${BIN}/kernel1.bin

kernel1makefloppy: kernel1 emptyfloppy
	cp ${BIN}/emptyfloppy.img ${BIN}/kernel1floppy.img
	dd if=${BIN}/bootsector.bin of=${BIN}/kernel1floppy.img conv=notrunc
	dd bs=512 seek=1 if=${BIN}/kernel1.bin of=${BIN}/kernel1floppy.img conv=notrunc

emptyfloppy:
	dd bs=512 count=2880 if=/dev/zero of=${BIN}/emptyfloppy.img

clean:
	rm -f ${BIN}/kernel1.bin
	rm -f ${BIN}/bootsector.bin
	rm -f ${BIN}/emptyfloppy.img
	rm -f ${BIN}/kernel1floppy.img
