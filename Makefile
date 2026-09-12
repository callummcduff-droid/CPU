VERILATOR = verilator
VERILATOR_FLAGS = -Irtl
BUILD_DIR = build
WAVE_DIR  = waves

# Selected assembly program, without .asm/.hex
TEST ?= test_alu

TEST_ID_test_alu = 0
TEST_ID_test_memory = 1
TEST_ID_test_forwarding = 2
TEST_ID_test_load_use = 3
TEST_ID_test_store_forwarding = 4
TEST_ID_test_beq_taken = 5
TEST_ID_test_beq_not_taken = 6
TEST_ID_test_bne_taken = 7
TEST_ID_test_bne_not_taken = 8
TEST_ID_test_jump = 9
TEST_ID_test_halt = 10

TEST_ID = $(TEST_ID_$(TEST))

PROGRAM_DIR = programs
PROGRAM_BASE = $(PROGRAM_DIR)/$(TEST)
PROGRAM_ASM = $(PROGRAM_BASE).asm
PROGRAM_HEX = $(PROGRAM_BASE).hex
CURRENT_HEX = $(PROGRAM_DIR)/current.hex


.PHONY: alu decoder cu pc registers data_mem inst_mem cpu clean

alu:
	$(VERILATOR) $(VERILATOR_FLAGS) --binary --timing --trace \
		rtl/alu.sv \
		tb/alu_tb.sv \
		--top-module alu_tb \
		--Mdir $(BUILD_DIR)/alu_tb
	./$(BUILD_DIR)/alu_tb/Valu_tb

decoder:
	$(VERILATOR) --binary --timing --trace \
		rtl/decoder.sv \
		tb/decoder_tb.sv \
		--top-module decoder_tb \
		--Mdir $(BUILD_DIR)/decoder_tb
	./$(BUILD_DIR)/decoder_tb/Vdecoder_tb

cu:
	$(VERILATOR) $(VERILATOR_FLAGS) --binary --timing --trace \
		rtl/cu.sv \
		tb/cu_tb.sv \
		--top-module cu_tb \
		--Mdir $(BUILD_DIR)/cu_tb
	./$(BUILD_DIR)/cu_tb/Vcu_tb

pc:
	$(VERILATOR) $(VERILATOR_FLAGS) --binary --timing --trace \
		rtl/pc.sv \
		tb/pc_tb.sv \
		--top-module pc_tb \
		--Mdir $(BUILD_DIR)/pc_tb
	./$(BUILD_DIR)/pc_tb/Vpc_tb

registers:
	$(VERILATOR) $(VERILATOR_FLAGS)--binary --timing --trace \
		rtl/registers.sv \
		tb/registers_tb.sv \
		--top-module registers_tb \
		--Mdir $(BUILD_DIR)/registers_tb
	./$(BUILD_DIR)/registers_tb/Vregisters_tb

data_mem:
	$(VERILATOR) $(VERILATOR_FLAGS) --binary --timing --trace \
		rtl/data_mem.sv \
		tb/data_mem_tb.sv \
		--top-module data_mem_tb \
		--Mdir $(BUILD_DIR)/data_mem_tb
	./$(BUILD_DIR)/data_mem_tb/Vdata_mem_tb

inst_mem:
	$(VERILATOR) $(VERILATOR_FLAGS) --binary --timing --trace \
		rtl/inst_mem.sv \
		tb/inst_mem_tb.sv \
		--top-module inst_mem_tb \
		--Mdir $(BUILD_DIR)/inst_mem_tb
	./$(BUILD_DIR)/inst_mem_tb/Vinst_mem_tb

cpu_pipeline:
	$(VERILATOR) $(VERILATOR_FLAGS) --binary --timing --trace \
		-GTEST_ID=$(TEST_ID) \
		rtl/alu.sv \
		rtl/decoder.sv \
		rtl/cu.sv \
		rtl/pc.sv \
		rtl/registers.sv \
		rtl/data_mem.sv \
		rtl/inst_mem.sv \
		rtl/sign_ext.sv \
		rtl/if_id.sv \
		rtl/id_ex.sv \
		rtl/ex_mem.sv \
		rtl/mem_wb.sv \
		rtl/forwarding_unit.sv \
		rtl/hazard_unit.sv \
		rtl/cpu_pipeline.sv \
		tb/cpu_pipeline_tb.sv \
		--top-module test_cpu \
		--Mdir $(BUILD_DIR)/cpu_pipeline_tb
	./$(BUILD_DIR)/cpu_pipeline_tb/Vtest_cpu

clean:
	rm -rf $(BUILD_DIR) obj_dir

# -------------------------
# C Assembler
# -------------------------

CC = gcc
CFLAGS = -Wall -Wextra -std=c11

ASSEMBLER_SRC = assembler/main.c assembler/assembler.c
ASSEMBLER_HDR = assembler/assembler.h
ASSEMBLER = build/assembler


.PHONY: assembler assemble run-cpu regression

assemble: assembler
	@echo "ASSEMBLING $(PROGRAM_BASE)"
	./$(ASSEMBLER) $(PROGRAM_BASE)
	cp $(PROGRAM_HEX) $(CURRENT_HEX)

# -------------------------
# Full CPU test
# -------------------------

.PHONY: run-cpu

run-cpu:
	$(MAKE) assemble TEST=$(TEST)
	$(MAKE) cpu_pipeline TEST=$(TEST) TEST_ID=$(TEST_ID)

REGRESSION_TESTS = \
	test_alu \
	test_memory \
	test_forwarding \
	test_load_use \
	test_store_forwarding \
	test_beq_taken \
	test_beq_not_taken \
	test_bne_taken \
	test_bne_not_taken \
	test_jump \
	test_halt

.PHONY: regression

regression:
	@for test in $(REGRESSION_TESTS); do \
		echo "================================"; \
		echo "Running $$test"; \
		echo "================================"; \
		$(MAKE) run-cpu TEST=$$test || exit 1; \
	done
	@echo "================================"
	@echo "ALL REGRESSION TESTS PASSED"
	@echo "================================"