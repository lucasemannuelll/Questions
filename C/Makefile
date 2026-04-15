CC = gcc
CFLAGS = -Wall -Wextra -Werror
LDFLAGS =

SRC := $(wildcard *.c)

BIN := $(SRC:.c=)

all: $(BIN)

%: %.c
	$(CC) $(CFLAGS) $< -o $@ $(LDFLAGS)

run:
	./$(FILE)

clean:
	rm -f $(BIN)

rebuild: clean all

list:
	@echo "Sources: $(SCR)"
	@echo "Binaries: $(BIN)"

.PHONY: all run clean rebuild list
