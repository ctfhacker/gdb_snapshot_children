all: run

main:
	gcc -ggdb main.c -o main
run: main
	gdb -x gdbcmds ./main
