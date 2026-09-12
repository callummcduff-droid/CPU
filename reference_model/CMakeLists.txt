cmake_minimum_required(VERSION 3.20)
project(Instruction_Set_Simulator C)

set(CMAKE_C_STANDARD 11)

add_executable(Instruction_Set_Simulator
        src/main.c
        src/cpu.c
        src/alu.c
        src/decoder.c
        src/memory.c
        include/Instruction.h
        src/assembler.c
        include/assembler.h
)

target_include_directories(Instruction_Set_Simulator PRIVATE include)

add_executable(test_alu
        tests/test_alu.c
        src/alu.c
        tests/test_assembler.c
)

target_include_directories(test_alu PRIVATE include)

add_executable(test_memory
        tests/test_memory.c
        src/memory.c
)

target_include_directories(test_memory PRIVATE include)

add_executable(test_decode
        tests/test_decoder.c
        src/decoder.c
)

target_include_directories(test_decode PRIVATE include)

add_executable(test_cpu
        tests/test_cpu.c
        src/cpu.c
        src/alu.c
        src/decoder.c
        src/memory.c
        src/assembler.c
)

add_executable(test_assembler
tests/test_assembler.c
src/assembler.c
src/memory.c
)

target_include_directories(test_assembler PRIVATE include)

target_include_directories(test_cpu PRIVATE include)

add_custom_command(TARGET Instruction_Set_Simulator POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy_if_different
        ${CMAKE_SOURCE_DIR}/Code.txt
        $<TARGET_FILE_DIR:Instruction_Set_Simulator>/Code.txt
)