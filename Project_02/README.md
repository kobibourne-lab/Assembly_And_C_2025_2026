Assembly Project 2
This converts 68k to x86.
takes ints as inputs and adds them in pairs, after 3 loops it adds the total and displays it

Many changes were made to get it working correctly.
-trap calls for I/O are replacedwith printf and scanf.
-instead of registers D1 , A1 etc we use rdi, rsi eetc.
-i changed the logic to increment the loop instead of decrement
-total kept in rbx and loop counter in r15 , rcx would not work as
gets overwritten
-there is 2 versions of add , one unused , uses the stack to pass parameters,
the version used passes parameters in registers.
-there is added validation for input, a letter/special chars check,
a range check(1-10000) and a buffer clear to prevent infinite looping.

How it runs

Assembly program:
nasm -f elf64 main.asm -o main.o
gcc -no-pie -o main main.o
./main

C version:
gcc -o mainc main.c
./mainc

Tests:
nasm -f elf64 main.asm -o main.o
gcc -no-pie -o test test.c main.o -Wl,--allow-multiple-definition
./test
