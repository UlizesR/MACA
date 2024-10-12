# Compiler and Flags
CC := clang
CFLAGS := -std=c17 -O3 -march=native
FRAMEWORKS := -framework Cocoa -framework Metal -framework MetalKit -framework QuartzCore -framework ModelIO
INCLUDES := -I./include

# Directories and Sources
SRC_DIR := src
BUILD_DIR := build
SRC := $(wildcard $(SRC_DIR)/*.{c,m})

all:
	mkdir -p $(BUILD_DIR)
	mkdir -p $(BUILD_DIR)/example

EXAMPLE_SRC := $(wildcard example/*.c)
# build example: takes an example name as an argument and builds it
build_example
	$(CC) $(CFLAGS) $(INCLUDES) $(FRAMEWORKS) $(EXAMPLE_SRC) $(SRC) -o $(BUILD_DIR)/example

run_example: $(BUILD_DIR)/example
	$(BUILD_DIR)/example

# Clean build artifacts
clean:
	rm -rf $(BUILD_DIR)

# Declare phony targets
.PHONY: all clean
