# @author Isaiah Rondeau
# @date September 25 2020

# Target Name
TARGET = program

# Build Path
BUILD_DIR = bin
# Object Directory
OBJ_DIR = obj
# Source Directory
SRC_DIR = src
# Include Directory
INC_DIR = inc
# Test Directory
TEST_DIR = test

# Source Files
SRC := $(shell find $(SRC_DIR) -name *.cpp)
INC := $(shell find $(INC_DIR) -name *.h -or -name *.hpp)
OBJ := $(patsubst $(SRC_DIR)/%.cpp, $(OBJ_DIR)/$(SRC_DIR)/%.o, $(SRC))

###   TESTING SOURCES   ###

ifdef TEST

# TEST Argument Input Conditions
ifeq ($(TEST), test_name)

TARGET := $(TEST)
SRC = src/main.cpp test/test_name.cpp

endif

# Postcondition statements
BUILD_DIR = bin/test
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
$(filter $(OBJ_DIR)/$(SRC_DIR)/%.o, $(OBJ)): $(OBJ_DIR)/%.o : %.cpp
	@echo "Building dependency" $@ "from" $<
	@$(CXX) $(CXXFLAGS) -c $< -o $@

# Build Test Object Files
$(filter $(OBJ_DIR)/$(TEST_DIR)/%.o, $(OBJ)): $(OBJ_DIR)/%.o : %.cpp
	@echo "Building dependency" $@ "from" $<
	@$(CXX) $(CXXFLAGS) -c $< -o $@

# Clean Build
clean:
	@rm -r $(OBJ) $(BUILD_DIR)/$(TARGET)
	
# Run Target Executable
run: $(BUILD_DIR)/$(TARGET)
	@cd $(BUILD_DIR); ./$(TARGET)