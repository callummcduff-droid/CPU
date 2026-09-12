//
// Created by admin on 14/07/2026.
//
#include <stdio.h>
#include "instruction.h"
#include <assert.h>
#include "decoder.h"

int main(void) {
    Instruction inst = decode();
    printf("Decoded opcode %d\n", inst.opcode);
    printf("Decoded rs %u\n", inst.rs);
    printf("Decoded rt %u\n", inst.rt);
    printf("Decoded rd %u\n", inst.rd);
    return 0;
}