NAME_FILE = xderm-trigger
VERSION = 1.1.1

OUT_FILE := $(NAME_FILE)-$(VERSION).ipk

TOP = $(shell pwd)
SRC_DIR = src
BUILD_DIR = build
OUT_DIR = out
SOURCES := $(shell find $(SRC_DIR) -name "*.c")
OBJECTS := $(SOURCES:%=$(BUILD_DIR)/%.o)
TARGET := xderm-trigger
CFLAGS ?= -lcurl

.PHONY: all
all: $(OUT_DIR)/$(TARGET)
$(BUILD_DIR)/%.c.o: %.c
	$(MKDIR_P) $(dir $@)
	$(CC) $(CFLAGS) -c $< -o $@

$(OUT_DIR)/$(TARGET): $(OBJECTS)
	$(MKDIR_P) $(dir $@)
	$(CC) $(OBJECTS) $(CFLAGS) -o $@

.PHONY: ipk
ipk: all
	@echo "Archive source"
	$(MKDIR_P) $(OUT_DIR)/data/usr/bin
	@mv $(OUT_DIR)/$(TARGET) $(OUT_DIR)/data/usr/bin
	@cd $(OUT_DIR)/data && tar czvf ../data.tar.gz * && cd $(TOP)
	@cd $(SRC_DIR)/control && tar czvf $(TOP)/$(OUT_DIR)/control.tar.gz * && cd $(TOP)
	@echo 2.0 > $(OUT_DIR)/debian-binary
	@cd $(OUT_DIR) && tar czvf $(OUT_FILE) debian-binary data.tar.gz control.tar.gz
	@echo "Complete file $(OUT_FILE) on folder out"

.PHONY: clean
clean:
	$(RM) -r $(OUT_DIR) $(BUILD_DIR)

MKDIR_P ?= @mkdir -p
