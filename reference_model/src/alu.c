//
// Created by admin on 13/07/2026.
//

#include "alu.h"
#include "cpu.h"
#include "instruction.h"
#include <stdio.h>
#include "memory.h"


//ADD function
int alu_ADD(CPU *cpu, Instruction inst) {
    return cpu->reg[inst.rs] + cpu->reg[inst.rt];
}
//SUB function
int alu_SUB(CPU *cpu, Instruction inst) {
    return cpu->reg[inst.rt] - cpu->reg[inst.rs];
}
//AND function
int alu_AND(CPU *cpu, Instruction inst) {
    return cpu->reg[inst.rs] & cpu->reg[inst.rt];
}
//OR function
int alu_OR(CPU *cpu, Instruction inst) {
    return cpu->reg[inst.rs] | cpu->reg[inst.rt];

}
//XOR function
int alu_XOR(CPU *cpu, Instruction inst) {
    return cpu->reg[inst.rs] ^ cpu->reg[inst.rt];

}












