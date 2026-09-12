//
// Created by admin on 13/07/2026.
//

#ifndef INSTRUCTION_SET_SIMULATOR_MEMORY_H
#define INSTRUCTION_SET_SIMULATOR_MEMORY_H

#include <stdlib.h>

// Defines memory array
#define MEMORY_SIZE 65536

extern uint16_t data_mem[MEMORY_SIZE];
extern uint16_t inst_mem[MEMORY_SIZE];

//Fetches instruction
uint16_t inst_read(uint16_t address);

//Writes instruction
void inst_write(uint16_t address, uint16_t value);

//Reads from memory
uint16_t data_read(uint16_t address);

//Writes to memory
uint16_t data_write(uint16_t address, uint16_t value);

//Clears memory after executing instruction
void mem_clear();

#endif //INSTRUCTION_SET_SIMULATOR_MEMORY_H
