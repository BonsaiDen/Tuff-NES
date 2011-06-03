PROGRAM = tuff
SOURCES = tuff.asm
CONFIG_FILE = nes.cfg

ifdef CONFIG_FILE
LDCONFIG_FLAGS = --config $(CONFIG_FILE)
CLCONFIG_FLAGS = -t nes --config $(CONFIG_FILE)
else
LDCONFIG_FLAGS = -t nes
CLCONFIG_FLAGS = -t nes
endif

BUILD_DIR = build

AS	= ca65
ASFLAGS	= -t nes
LD	= ld65
LDFLAGS	= -m $(BUILD_DIR)/$(PROGRAM).map $(CONFIG_FLAGS)
CL	= cl65
CLFLAGS	= -t nes $(CLCONFIG_FLAGS) -m $(BUILD_DIR)/$(PROGRAM).map -Ln $(BUILD_DIR)/$(PROGRAM).lbl


OBJECTS = $(BUILD_DIR)/$(SOURCES:BUILD_DIR.asm=.o)

all: dirs $(BUILD_DIR)/$(PROGRAM).nes

$(BUILD_DIR)/$(PROGRAM).nes: graphics
	$(CL) $(CLFLAGS) -o $(PROGRAM).nes $(SOURCES)
	mv $(PROGRAM).o $(BUILD_DIR)/$(PROGRAM).o

open: $(BUILD_DIR)/$(PROGRAM).nes
	nestra $(PROGRAM).nes

clean:
	$(RM) $(PROGRAM).nes
	$(RM) -rf $(BUILD_DIR)
	$(RM) graphics/*.plt graphics/*.chr

dirs:
	mkdir -p $(BUILD_DIR)

graphics:
	tools/img2nes graphics/tuff.png

.PHONY: all dirs graphics clean open $(BUILD_DIR)/$(PROGRAM).nes

