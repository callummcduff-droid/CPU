//
// Created by admin on 13/07/2026.
//

#include "../include/memory.h"
#include <stdint.h>

uint16_t data_mem[MEMORY_SIZE];
uint16_t inst_mem[MEMORY_SIZE];

//Reading from instruction memory
uint16_t inst_read(uint16_t address) {
    return inst_mem[address];
}

//Writing to instruction memory
void inst_write(uint16_t address, uint16_t value) {
    inst_mem[address] = value;
}

//Reading from the data memory
uint16_t data_read(uint16_t address) {
    return data_mem[address];

}

//Writing to data memory
uint16_t data_write(uint16_t address, uint16_t value) {
    data_mem[address] = value;
    return data_mem[address];
}

//Clears memory
void mem_clear() {
    for (int i = 0; i < MEMORY_SIZE; i++) {
        data_mem[i] = 0;
    }

}