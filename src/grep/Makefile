.PHONY: all test s21_cat s21_grep
override MYCFLAGS = -Wall -Wextra -Werror -std=c11 -c -D_GNU_SOURCE
CC=gcc
EXE=s21_grep
RUN=$(EXE) -v e s21_de.txt


all: s21_grep

%.o: %.c
	$(CC) $(MYCFLAGS) $^

$(EXE): $(EXE).o
	$(CC) $^ -o $@

test: $(EXE)
	sh ./s21_grep_test.sh

check:
	cp ../../materials/linters/CPPLINT.cfg .
	-python3 ../../materials/linters/cpplint.py --extensions=c *.c *.h
	cppcheck --enable=all --suppress=missingIncludeSystem *.c
ifeq ($(shell uname -s), Darwin)
	CK_FORK=no leaks --atExit -- ./$(RUN)
else
	CK_FORK=no valgrind --vgdb=no --leak-check=full --show-leak-kinds=all --track-origins=yes --verbose --log-file=RESULT_VALGRIND.txt ./$(RUN)
endif

clean:
	ls |  grep -v 's21_[a-z_]*[.][c|h|txt|sh]\|Makefile' | xargs  $(RM)
	@rm -rf *.h.gch