# @author Isaiah Rondeau
# @date September 25 2020

# Target Name
TARGET = program

# Source Directory
SRC_DIR = src
# Include Directory
INC_DIR = inc
# Test Directory
TEST_DIR = test
# Object Directory
OBJ_DIR = obj
# Build Path
BUILD_DIR = bin/$(SRC_DIR)

# Source Files
SRC := $(wildcard $(SRC_DIR)/*.cpp)
INC := $(wildcard $(INC_DIR)/*.h)
INC += $(wildcard $(INC_DIR)/*.hpp)
OBJ := $(patsubst $(SRC_DIR)/%.cpp, $(OBJ_DIR)/$(SRC_DIR)/%.o, $(SRC))

###   TESTING SOURCES   ###

ifdef TEST

# TEST Argument Input Conditions
ifeq ($(TEST), test_name)

TARGET := $(TEST)
SRC = src/main.cpp test/test_name.cpp

endif

# Postcondition statements
BUILD_DIR = bin/$(TEST_DIR)
OBJ := $(patsubst $(SRC_DIR)/%.cpp, $(OBJ_DIR)/$(SRC_DIR)/%.o, $(SRC))
OBJ := $(patsubst $(TEST_DIR)/%.cpp, $(OBJ_DIR)/$(TEST_DIR)/%.o, $(OBJ))

endif

### END TESTING SOURCES ###

# CPP Compiler
CXX = g++
# CPP Compiler Flags
CXXFLAGS := -I$(INC_DIR) -g -ggdb -Wall -std=c++17

.PHONY: all clean run

# Build Default
all: $(BUILD_DIR)/$(TARGET)

# Build Target Executable
$(BUILD_DIR)/$(TARGET): $(OBJ)
	@echo "Building target" $@ "from" $<
	@$(CXX) $(CXXFLAGS) $(OBJ) -o $@

# Build Source Object Files
$(OBJ_DIR)/$(SRC_DIR)/%.o: $(SRC_DIR)/%.c
	@echo "Building dependency" $@ "from" $<
	@$(CXX) $(CXXFLAGS) -c $< -o $@

# Build Test Object Files
$(OBJ_DIR)/$(TEST_DIR)/%.o: $(TEST_DIR)/%.c
	@echo "Building dependency" $@ "from" $<
	@$(CXX) $(CXXFLAGS) -c $< -o $@

# Clean Build
clean:
	@-rm $(OBJ) $(BUILD_DIR)/$(TARGET)
	
# Run Target Executable
run: $(BUILD_DIR)/$(TARGET)
	@cd $(BUILD_DIR); ./$(TARGET)
