//
// Created by admin on 17/07/2026.
//

#ifndef INSTRUCTION_SET_SIMULATOR_INSTRUCTION_H
#define INSTRUCTION_SET_SIMULATOR_INSTRUCTION_H

#include <stdint.h>

//Defines opcode values
typedef enum {
    OP_NOP = 0x0,
    OP_LOADI = 0x1,
    OP_ADD = 0x3,
    OP_SUB = 0x4,
    OP_AND = 0x5,
    OP_OR = 0x6,
    OP_XOR = 0x7,
    OP_LOAD = 0x9,
    OP_STORE = 0xA,
    OP_JMP = 0xB,
    OP_BEQ = 0xC,
    OP_BNE = 0xD,
    OP_HALT = 0xE,
} Opcode;

//Features of instruction
typedef struct {
    Opcode opcode;
    uint8_t rs;
    uint8_t rd;
    uint8_t rt;
    uint16_t offset;
} Instruction;

#endif //INSTRUCTION_SET_SIMULATOR_INSTRUCTION_H
