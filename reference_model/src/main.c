#include "cpu.h"
#include "assembler.h"


int main() {
    //CPU variable containing architectural states
    CPU cpu;

    //Initialising architectural states
    cpu_init(&cpu);

    //
    ParsedLine parse[1000] = {0};

    //Lookup table for assembler, matching token with associated value
    Lookup key[] = {
        {"R0", 0x0},
        {"R1", 0x1},
        {"R2", 0x2},
        {"R3", 0x3},
        {"R4", 0x4},
        {"R5", 0x5},
        {"R6", 0x6},
        {"R7", 0x7}
    };


    //Defines example instruction
    int num_lines;

    //Reads assembly text and produces array of lines
    char **lines =read_assembly(&num_lines);

    Assembled assembled = {0};
    //Size of lookup key for searching
    int size_key = sizeof(key)/sizeof(key[0]);

    //Splits each line into tokens
    parser(parse, lines, num_lines);

    //Assigns location counter to lines and produces final binary instruction
    pass(parse, num_lines, size_key, key, &assembled);

    //Performs FDE until HALTED
    cpu_run(&cpu);
}