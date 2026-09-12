//
// Created by admin on 23/07/2026.
//

#include <stdbool.h>
#include <stdint.h>

#ifndef INSTRUCTION_SET_SIMULATOR_ASSEMBLER_H
#define INSTRUCTION_SET_SIMULATOR_ASSEMBLER_H

typedef struct{
    char label[256];
    char mnemonic[32];
    char op1[32];
    char op2[32];
    char op3[32];
    int location;
    bool initialised;
} ParsedLine;

typedef struct {
    char name[32];
    uint16_t value;
} Lookup;

extern Lookup key[];

typedef struct {
    uint16_t opcode;
    uint16_t rs;
    uint16_t rt;
    uint16_t rd;
    uint16_t imm;
    uint16_t final;
} Assembled;

char **read_assembly(int *num_lines, char const *filename);
void parser(ParsedLine *parse, char **lines, int size);
void pass(ParsedLine *parse, int size_line, int size_key, Lookup key[], Assembled *assembled, const char *filename);
void R_type(ParsedLine *parse, Lookup key[], int size_key, Assembled *assembled, int elmnt);
void Imm_type(ParsedLine *parse, Lookup key[], int size_key, Assembled *assembled, int elmnt);
void Jump_type(ParsedLine *parse, Assembled *assembled, int elmnt, int size_line);
void Branch_type(ParsedLine *parse, Assembled *assembled, Lookup key[], int size_key, int elmnt, int size_line);
#endif //INSTRUCTION_SET_SIMULATOR_ASSEMBLER_H
