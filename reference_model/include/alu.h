//
// Created by admin on 13/07/2026.
//

#ifndef INSTRUCTION_SET_SIMULATOR_ALU_H
#define INSTRUCTION_SET_SIMULATOR_ALU_H

#include <stdint.h>
#include "cpu.h"


int alu_ADD(CPU *cpu, Instruction inst);
int alu_SUB(CPU *cpu, Instruction inst);
int alu_AND(CPU *cpu, Instruction inst);
int alu_OR(CPU *cpu, Instruction inst);
int alu_XOR(CPU *cpu, Instruction inst);
//int alu_NOT(CPU *cpu, Instruction inst);

#endif //INSTRUCTION_SET_SIMULATOR_ALU_H
