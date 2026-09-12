//
// Created by admin on 23/07/2026.
//
#include "assembler.h"
#include "memory.h"
#include <assert.h>
#include <stdio.h>


int main() {

    ParsedLine parse[1000] = {0};

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

    char **lines =read_assembly(&num_lines);

    Assembled assembled = {0};
    int size_key = sizeof(key)/sizeof(key[0]);

    parser(parse, lines, num_lines);
    pass(parse, num_lines, size_key, key, &assembled);

    return 0;
}