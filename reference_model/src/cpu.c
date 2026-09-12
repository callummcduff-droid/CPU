//
// Created by admin on 13/07/2026.
//

#include "cpu.h"
#include "decoder.h"
#include "memory.h"
#include "alu.h"
#include "instruction.h"
#include <stdio.h>


//LOAD function
int cpu_LOAD(CPU *cpu, Instruction inst) {
    return cpu->reg[inst.rs] + inst.offset;
}

//LOADI function
int cpu_LOADI(CPU *cpu, Instruction inst) {
    return inst.offset;

}

//STORE function
int cpu_STORE(CPU *cpu, Instruction inst) {
    return cpu->reg[inst.rs] + inst.offset;

}

//HALT function
int cpu_HALT(CPU *cpu, Instruction inst) {
    cpu->halted = 1;
    return cpu->halted;
}

//BNE function
int cpu_BNE(CPU *cpu, Instruction inst) {
    if (cpu->reg[inst.rs] != cpu->reg[inst.rt]) {
        cpu->pc = (inst.offset / 2);
    }
    else {
        cpu->pc +=1;
    }
    return cpu->pc;
}

//BEQ function
int cpu_BEQ(CPU *cpu, Instruction inst) {
    if (cpu->reg[inst.rs] == cpu->reg[inst.rt]) {
        cpu->pc = (inst.offset / 2);
    }
    else {
        cpu->pc +=1;
    }
    return cpu->pc;
}

//Initialises CPU values
void cpu_init(CPU *cpu) {
    cpu->halted = 0;
    cpu->pc = 0;
    for (int i = 0; i < 8; i++) {
        cpu->reg[i] = 0;
    }
}

//FDE cycle
void cpu_set(CPU *cpu) {
    printf("PC %d\n", cpu->pc);

    Instruction inst = decode(inst_read(cpu->pc));
    //Control Unit determines which operation to run based off of decoded instruction
    switch (inst.opcode) {
        case OP_ADD:
            printf("Operation ADD\n");
            cpu->reg[inst.rd] = alu_ADD(cpu,inst);
            printf("Result %d\n", cpu->reg[inst.rd] );
            cpu->pc +=1;
            break;
        case OP_SUB:
            printf("Operation SUB\n");
            cpu->reg[inst.rd] = alu_SUB(cpu,inst);
            printf("Result %d\n", cpu->reg[inst.rd] );
            cpu->pc +=1;
            break;
        case OP_AND:
            printf("Operation AND\n");
            cpu->reg[inst.rd] = alu_AND(cpu,inst);
            printf("Result %d\n", cpu->reg[inst.rd] );
            cpu->pc +=1;
            break;
        case OP_OR:
            printf("Operation OR\n");
            cpu->reg[inst.rd] = alu_OR(cpu,inst);
            printf("Result %d\n", cpu->reg[inst.rd] );
            cpu->pc +=1;
            break;
        case OP_XOR:
            printf("Operation XOR\n");
            cpu->reg[inst.rd] = alu_XOR(cpu,inst);
            printf("Result %d\n", cpu->reg[inst.rd] );
            cpu->pc +=1;
            break;
        case OP_LOAD:
            printf("Operation LOAD\n");
            cpu->reg[inst.rt] = cpu_LOAD(cpu,inst);
            printf("Result %d\n", cpu->reg[inst.rt]);
            cpu->pc +=1;
            break;
        case OP_STORE:
            printf("Operation STORE\n");
            printf("Result %d\n", data_write(cpu_STORE(cpu,inst), cpu->reg[inst.rt]));
            cpu->pc +=1;
            break;
        case OP_NOP:
            printf("No Operation\n");
            cpu->pc +=1;
            break;
        case OP_LOADI:
            printf("Operation LOADI\n");
            cpu->reg[inst.rt] = cpu_LOADI(cpu,inst);
            printf("Result %d\n", cpu->reg[inst.rt]);
            cpu->pc +=1;
            break;
        case OP_JMP:
            printf("Operation JMP\n");
            cpu->pc = inst.offset / 2;
            break;
        case OP_BEQ:
            printf("Operation BEQ\n");
            printf("Result %d\n", cpu_BEQ(cpu, inst));
            break;
        case OP_BNE:
            printf("Operation BNE\n");
            printf("Result %d\n", cpu_BNE(cpu, inst));
            break;
        case OP_HALT:
            printf("Operation HALT\n");
            cpu->halted = 1;
            break;
    }
    printf("R0 %d\n", cpu->reg[0]);
    printf("R1 %d\n", cpu->reg[1]);
    printf("R2 %d\n", cpu->reg[2]);
    printf("R3 %d\n", cpu->reg[3]);
    printf("R4 %d\n", cpu->reg[4]);
    printf("R5 %d\n", cpu->reg[5]);
    printf("R6 %d\n", cpu->reg[6]);
    printf("R7 %d\n", cpu->reg[7]);

}

//Runs CPU until HALT or Error
void cpu_run(CPU *cpu) {
    while (cpu->halted != 1) {
        cpu_set(cpu);
    }
}


