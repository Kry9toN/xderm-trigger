.PHONY: all clean

NAME_FILE = xderm-trigger
VERSION = 1.0.1

PWD = $(shell pwd)
SRC_DIR = $(PWD)/src
OUT_DIR = $(PWD)/out
OUT_FILE = $(NAME_FILE)-$(VERSION).ipk

all: clean-out out-dir ipk-file
clean: clean-out

clean-out:
	@rm -rf $(OUT_DIR)

out-dir:
	@test ! -d $(OUT_DIR) && mkdir $(OUT_DIR)

ipk-file:
	@echo "Archive source"
	@cd $(SRC_DIR)/data && tar czvf $(OUT_DIR)/data.tar.gz * && cd $(PWD)
	@cd $(SRC_DIR)/control && tar czvf $(OUT_DIR)/control.tar.gz * && cd $(PWD)
	@echo 2.0 > $(OUT_DIR)/debian-binary
	@cd $(OUT_DIR) && tar czvf $(OUT_FILE) debian-binary data.tar.gz control.tar.gz
	@echo "Complete file $(OUT_FILE) on folder out"
