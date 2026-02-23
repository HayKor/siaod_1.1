TARGET = out
TARGET_PATH = ./build/$(TARGET)
SOURCE = main.cpp methods.cpp test.cpp util.cpp
HEADERS = include/methods.h include/test.h include/util.h
FLAGS = -I./include

$(TARGET_PATH): $(SOURCE) $(HEADERS)
	clang++ $(FLAGS) $(SOURCE) -o $(TARGET_PATH)

run: $(TARGET_PATH)
	./$(TARGET_PATH)

.PHONY: run clean build
