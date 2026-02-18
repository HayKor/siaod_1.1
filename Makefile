TARGET = out
TARGET_PATH = ./build/$(TARGET)
SOURCE = main.cpp methods.cpp test.cpp util.cpp
HEADERS = methods.h test.h util.h

$(TARGET_PATH): $(SOURCE) $(HEADERS)
	clang++ $(SOURCE) -o $(TARGET_PATH)

run: $(TARGET_PATH)
	./$(TARGET_PATH)

.PHONY: run clean build
