//
// Created by admin on 23/07/2026.
//

#include "../include/assembler.h"
#include <stdio.h>
#include <string.h>
#include <stdbool.h>
#include "memory.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

//Produces file of dynamically allocated strings of assembly code from Assembly.txt
char **read_assembly(int *num_lines){
    FILE *fptr = fopen("../Assembly.txt", "r");
    if (!fptr)
        return NULL;

    int capacity = 8;
    int count = 0;

    char **lines = malloc(capacity * sizeof(char *));
    char buffer[256];

    while (fgets(buffer, sizeof(buffer), fptr)) {

        if (count == capacity) {
            capacity *= 2;
            char **temp = realloc(lines, capacity * sizeof(char *));
            if (!temp) {
                fclose(fptr);
                return NULL;
            }
            lines = temp;
        }

        lines[count] = malloc(strlen(buffer) + 1);
        strcpy(lines[count], buffer);
        count++;
    }

    fclose(fptr);

    *num_lines = count;
    return lines;
}


void parser(ParsedLine *parse, char **lines, int size){
    //For loop iterating through
    for (int elmnt = 0; elmnt < size; elmnt++){
        char buffer[256];
        strcpy(buffer, lines[elmnt]);

        //Removes \n
        buffer[strcspn(buffer, "\n")] = '\0';

        //Searches for colon and separates label
        char *colon = strchr(buffer, ':');
        char * restrict rest;
        if (colon != NULL){
            *colon = '\0';
            strcpy(parse[elmnt].label, buffer);
            parse[elmnt].initialised = true;
            //printf("Label %s\n", parse[elmnt].label);
            rest = colon + 1;
        }

        //Splits rest of line into tokens
        else{
            rest = buffer;
            parse[elmnt].initialised = false;
        }
        char *tok = strtok(rest, " ,");
        strcpy(parse[elmnt].mnemonic, tok);
        //printf("Mnemonic %s\n", parse[elmnt].mnemonic);
        int i = 1;
        int token_null = 0;
        while (token_null ==0){
            tok = strtok(NULL, " ,");
            if (tok != NULL){
                switch(i){
                case 1:
                    strcpy(parse[elmnt].op1, tok);
                    //printf("Op1 %s\n", parse[elmnt].op1);
                    i++;
                    break;
                case 2:
                    strcpy(parse[elmnt].op2, tok);
                    //printf("Op2 %s\n", parse[elmnt].op2);
                    i++;
                    break;
                case 3:
                    strcpy(parse[elmnt].op3, tok);
                    //printf("Op3 %s\n", parse[elmnt].op3);
                    i++;
                    break;

            }

            }
            else {
                token_null ++;
            }


    }
    }

}

//Assembles instruction for R-type instructions
void R_type(ParsedLine *parse, Lookup key[], int size_key, Assembled *assembled, int elmnt) {
    //Searches key array and assigns fields
    for (int i = 0; i < size_key; i++) {
        if (strcmp(parse[elmnt].op1, key[i].name) == 0) {
            assembled->rd = key[i].value;
            //printf("Destination %s\n", key[i].name);
        }
        if (strcmp(parse[elmnt].op2, key[i].name) == 0) {
            assembled->rt = key[i].value;
            //printf("Target %s\n", key[i].name);
        }
        if (strcmp(parse[elmnt].op3, key[i].name) == 0) {
            assembled->rs = key[i].value;
            //printf("Source %s\n", key[i].name);
        }
    }
    //Builds assembled instruction
    assembled->final = (assembled->opcode << 12) | (assembled->rs << 9) | (assembled->rt << 6) | (assembled->rd << 3);
    //printf("%x\n", assembled->final);

}

//Assembles instruction for Imm-type instructions
void Imm_type(ParsedLine *parse, Lookup key[], int size_key, Assembled *assembled, int elmnt) {

    //Searches key array and assigns field for op1
    for (int i = 0; i < size_key; i++) {
        if (strcmp(parse[elmnt].op1, key[i].name) == 0) {
            assembled->rt = key[i].value;
            //printf("Target %s\n", key[i].name);
        }
    }

    //Breaks down memory token into base register + offset
    //Passes op2 of given line into buffer intermediate
    char buffer [256];
    strcpy(buffer, parse[elmnt].op2);

    //Checks if there is a bracket, if not treat op2 as integer value
    char *bracket = strchr(buffer, '(');
    char * restrict rest;
    if (bracket != NULL){
        //Splits offset from register inside brackets
        *bracket = '\0';
        //Immediate value assigned
        assembled->imm = strtol(buffer, NULL, 10);
        //printf("Immediate %d\n", assembled.imm);

        //Looks at rest of op2
        rest = bracket + 1;

        //Isolates base register from brackets
        char *tok = strtok(rest, " )");
        //printf("%s\n", tok);

        //Checks if isolated register value is a valid register
        for (int i = 0; i < size_key; i++) {
            if (strcmp(tok, key[i].name) == 0) {
                assembled->rs = key[i].value;
                //printf("Source %s\n", key[i].name);
            }
        }


    }

    //Converts string to integer
    else {
        assembled->rs = 0x0;
        //printf("Source %d\n", assembled.rs);
        assembled->imm = strtol(parse[elmnt].op2, NULL, 10);
        //printf("Immediate %d\n", assembled.imm);

    }

    //Builds assembled instruction
    assembled->final = (assembled->opcode << 12) | (assembled->rs << 9) | (assembled->rt << 6) | assembled->imm;
    //printf("Final %x\n", assembled.final);
}

//Assembles instruction for Jump-type instructions
void Jump_type(ParsedLine *parse, Assembled *assembled, int elmnt, int size_line) {
    for (int i = 0; i < size_line; i++) {
        if (strcmp(parse[elmnt].op1, parse[i].label) == 0) {
            assembled->imm = parse[i].location;
            //printf("%x\n", assembled.imm);
        }
    }
    assembled->final = (assembled->opcode << 12) | assembled->imm;
    //printf("%x\n", assembled.final);
}

//Assembles instruction for Branch-type instructions
void Branch_type(ParsedLine *parse, Assembled *assembled, Lookup key[], int size_key, int elmnt, int size_line) {
    for (int i = 0; i < size_key; i++) {
        if (strcmp(parse[elmnt].op1, key[i].name) == 0) {
            assembled->rt = key[i].value;
            //printf("Destination %s\n", key[i].name);
        }
        if (strcmp(parse[elmnt].op2, key[i].name) == 0) {
            assembled->rs = key[i].value;
            //printf("Target %s\n", key[i].name);
        }
    }

    for (int i = 0; i < size_line; i++) {
        if (strcmp(parse[elmnt].op3, parse[i].label) == 0) {
            assembled->imm = parse[i].location;
            //printf("%x\n", assembled.imm);
        }
    }
        assembled->final = (assembled->opcode << 12) | (assembled->rs << 9) | (assembled->rt << 6) | assembled->imm;
}

void pass(ParsedLine *parse, int size_line, int size_key, Lookup key[], Assembled *assembled){
    //Assigns location counter value
    for (int elmnt = 0; elmnt < size_line; elmnt++){
        if(parse[elmnt].initialised){
            parse[elmnt].location = 2*elmnt;
            //printf("Does have a label\n");
        }

    }
    // Iterates through instructions to assign opcode to mnemonic token
    for (int elmnt = 0; elmnt < size_line; elmnt++){
        if (strcmp(parse[elmnt].mnemonic, "NOP") == 0){
            assembled->opcode = 0x0;
            assembled->final = assembled->opcode << 12;
            inst_write(elmnt, assembled->final);
            //printf("NOP");
        }
        else if (strcmp(parse[elmnt].mnemonic, "LOADI") == 0){
            assembled->opcode = 0x1;
            Imm_type(parse, key, size_key, assembled, elmnt);
            inst_write(elmnt, assembled->final);
            //printf("LOADI");
        }
        else if (strcmp(parse[elmnt].mnemonic, "ADD") == 0){
            //printf("ADD");
            assembled->opcode = 0x3;
            R_type(parse, key, size_key, assembled, elmnt);
            inst_write(elmnt, assembled->final);

        }
        else if (strcmp(parse[elmnt].mnemonic, "SUB") == 0){
            //printf("SUB");
            assembled->opcode = 0x4;
            R_type(parse, key, size_key, assembled, elmnt);
            inst_write(elmnt, assembled->final);

        }
        else if (strcmp(parse[elmnt].mnemonic, "AND") == 0){
            //printf("AND");
            assembled->opcode = 0x5;
            R_type(parse, key, size_key, assembled, elmnt);
            inst_write(elmnt, assembled->final);

        }
        else if (strcmp(parse[elmnt].mnemonic, "OR") == 0){
            //printf("OR");
            assembled->opcode = 0x6;
            R_type(parse, key, size_key, assembled, elmnt);
            inst_write(elmnt, assembled->final);

        }
        else if (strcmp(parse[elmnt].mnemonic, "XOR") == 0){
            //printf("XOR");
            assembled->opcode = 0x7;
            R_type(parse, key, size_key, assembled, elmnt);
            inst_write(elmnt, assembled->final);

        }
        else if (strcmp(parse[elmnt].mnemonic, "NOT") == 0){
            assembled->opcode = 0x8;
            //printf("NOT");
        }
        else if (strcmp(parse[elmnt].mnemonic, "LOAD") == 0){
            assembled->opcode = 0x9;
            Imm_type(parse, key, size_key, assembled, elmnt);
            inst_write(elmnt, assembled->final);
            //printf("LOAD");
        }
        else if (strcmp(parse[elmnt].mnemonic, "STORE") == 0){
            assembled->opcode = 0xA;
            Imm_type(parse, key, size_key, assembled, elmnt);
            inst_write(elmnt, assembled->final);

            //printf("STORE");
        }
        else if (strcmp(parse[elmnt].mnemonic, "JMP") == 0){
            assembled->opcode = 0xB;
            Jump_type(parse, assembled, elmnt, size_line);
            inst_write(elmnt, assembled->final);
            //printf("JMP");
        }
        else if (strcmp(parse[elmnt].mnemonic, "BEQ") == 0){
            assembled->opcode = 0xC;
            Branch_type(parse, assembled, key, size_key, elmnt, size_line);
            inst_write(elmnt, assembled->final);
            //printf("BEQ");
        }
        else if (strcmp(parse[elmnt].mnemonic, "BNE") == 0){
            assembled->opcode = 0xD;
            Branch_type(parse, assembled, key, size_key, elmnt, size_line);
            inst_write(elmnt, assembled->final);
            //printf("BNE");
        }
        else if (strcmp(parse[elmnt].mnemonic, "HALT") == 0){
            assembled->opcode = 0xE;
            assembled->final = assembled->opcode << 12;
            inst_write(elmnt, assembled->final);

            //printf("HALT");
        }
        /*else {
            printf("Invalid operation\n");
            exit(EXIT_FAILURE);
        }*/

        }


    }
