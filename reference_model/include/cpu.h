//
// Created by admin on 13/07/2026.
//

#ifndef INSTRUCTION_SET_SIMULATOR_CPU_H
#define INSTRUCTION_SET_SIMULATOR_CPU_H

#include <stdint.h>
#include "instruction.h"
#include <stdbool.h>

typedef struct {
    uint16_t reg[8];
    uint16_t pc;
    uint16_t halted;
} CPU;


typedef struct {
    Instruction inst;
    uint16_t pc;
    uint16_t instr;
    uint16_t rs_val;
    uint16_t rt_val;
} IF_ID;

typedef struct {
    Instruction inst;
    uint16_t instr;
    uint16_t result;
    uint16_t rs_val;
    uint16_t rt_val;
    uint16_t dest_reg;
} ID_EXE;

typedef struct {
    Instruction inst;
    uint16_t result;
    uint16_t rs_val;
    uint16_t rt_val;
    uint16_t dest_reg;
} EXE_MEM;

typedef struct {
    Instruction inst;
    uint16_t result;
    uint16_t rs_val;
    uint16_t rt_val;
    uint16_t dest_reg;
} MEM_WB;


void cpu_init(CPU *cpu);
void cpu_set(CPU *cpu);
void cpu_run(CPU *cpu);
void cpu_tick();


void IF(CPU *cpu, IF_ID *if_id_next);
void ID(CPU *cpu, IF_ID *if_id_cur, ID_EXE *id_exe_next);
void EXE(CPU *cpu, ID_EXE *id_exe_cur, EXE_MEM *exe_mem_next, EXE_MEM *exe_mem_cur, MEM_WB *mem_wb_cur);
void MEM(CPU *cpu, EXE_MEM *exe_mem_cur, MEM_WB *mem_wb_next);
void WB(CPU *cpu, MEM_WB *mem_wb_cur);

int cpu_LOAD(CPU *cpu, Instruction inst);
int cpu_LOADI(CPU *cpu, Instruction inst);
int cpu_STORE(CPU *cpu, Instruction inst);

int cpu_BNE(CPU *cpu, Instruction inst);
int cpu_BEQ(CPU *cpu, Instruction inst);

int cpu_HALT(CPU *cpu, Instruction inst);

#endif //INSTRUCTION_SET_SIMULATOR_CPU_H
