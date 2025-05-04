SUDO=
PORT=/dev/ttyUSB0
LOADER=loader.bin
LOADERTMP=loader_t.bin
PYTHON=python3
DEL=rm -f
BLOCK_HEX=0a
BULK=bulk.csv

.PHONY: all
all: $(LOADER)

.PHONY: flash
flash: $(LOADER) $(BULK)
	$(SUDO) $(PYTHON) fnxmgr.zip --port $(PORT) --flash-bulk $(BULK)

$(LOADER): $(LOADERTMP)
	$(PYTHON) pad_binary.py $(LOADERTMP)  $(LOADER)

$(LOADERTMP): flashloader.asm
	64tass --nostart -o $(LOADERTMP) flashloader.asm

$(BULK):
	echo $(BLOCK_HEX),$(LOADER) > $(BULK)

.PHONY: clean
clean:
	$(DEL) $(LOADER)
	$(DEL) $(LOADERTMP)
	$(DEL) $(BULK)
