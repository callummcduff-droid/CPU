//
// Created by admin on 13/07/2026.
//
#include <stdio.h>
#include "decoder.h"
#include "instruction.h"

Instruction decode(uint16_t loaded) {
    Instruction inst ={0};
    inst.opcode = (loaded >> 12) & 0xF;
    printf("Opcode %x\n", inst.opcode);
    switch (inst.opcode) {
        // Defining fields for R-type instructions
        case OP_ADD:
        case OP_SUB:
        case OP_AND:
        case OP_OR:
        case OP_XOR:
            inst.rs = (loaded >> 9) & 0x7;
            inst.rt = (loaded >> 6) & 0x7;
            inst.rd = (loaded >> 3) & 0x7;
            printf("Source %x\n", inst.rs);
            printf("Target %x\n", inst.rt);
            printf("Destination %x\n", inst.rd);
            break;
        // Defining fields for Immediate-type instructions
        // Special case for LOAD and STORE
        case OP_LOAD:
        case OP_LOADI:
        case OP_STORE:
            inst.rs = (loaded >> 9) & 0x7;
            inst.rt = (loaded >> 6) & 0x7;
            inst.offset = (loaded) & 0x3F;
            printf("Source %x\n", inst.rs);
            printf("Target %x\n", inst.rt);
            printf("Offset %x\n", inst.offset);
            break;
        case OP_NOP:
            break;
        // Defining fields for jump-type instructions
        case OP_JMP:
            inst.offset = (loaded) & 0xFFF;
            printf("Offset %x\n", inst.offset);

        case OP_BEQ:
        case OP_BNE:
            inst.rs = (loaded >> 9) & 0x7;
            inst.rt = (loaded >> 6) & 0x7;
            inst.offset = (loaded) & 0x3F;
            printf("Source %x\n", inst.rs);
            printf("Target %x\n", inst.rt);
            printf("Offset %x\n", inst.offset);
            break;
        case OP_HALT:
            break;
        default:
            printf("Invalid opcode");
    }
    return inst;

}



