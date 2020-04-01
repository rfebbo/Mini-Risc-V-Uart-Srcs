CC=riscv32-unknown-elf-gcc
QEMU=qemu-system-riscv64
LDS=lds/output.ld
OBJCOPY = riscv32-unknown-elf-objcopy
BIN2HEX=./bin2hex.py
CFLAGS=-Wl,-T,$(LDS),-e,0
CFLAGS+=-ffreestanding -nostartfiles -O0
ASM=$(wildcard src/asm/*.S)
ALL_C=$(wildcard src/*.c) 
QEMU_ARGS=-M virt -m 6M -bios none -serial mon:stdio
OUTPUT_DIR=objs/
OUT=os.elf 
OUT_BIN=os.bin 
OUT_COE=os.coe 


all: $(OUT) $(OUT_BIN) $(OUT_COE)

$(OUT_COE): $(OUT_BIN)
	$(BIN2HEX) coe 

$(OUT_BIN): $(OUT) 
	$(OBJCOPY) -O binary $(OUT) $(OUT_BIN) 

$(OUT): $(ASM) $(ALL_C)
	$(CC) $(CFLAGS) -o $(OUT) $(ASM) $(ALL_C) 

runcon: $(OUT) 
	$(QEMU) -nographic $(QEMU_ARGS) -kernel $(OUT)

clean: 
	rm -f $(OUT)
	rm -f $(OUT_BIN)
	rm -f $(OUT_COE)