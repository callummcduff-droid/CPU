`ifndef DEFINE_SVH
`define DEFINE_SVH

    typedef enum logic[3:0]{
        OP_NOP = 4'h0,
        OP_LOADI = 4'h1,
        OP_ADD = 4'h3,
        OP_SUB = 4'h4,
        OP_AND = 4'h5,
        OP_OR = 4'h6,
        OP_XOR = 4'h7,
        OP_LOAD = 4'h9,
        OP_STORE = 4'hA,
        OP_JMP = 4'hB,
        OP_BEQ = 4'hC,
        OP_BNE = 4'hD,
        OP_HALT = 4'hE
    } opcode;

    typedef enum logic[2:0]{
        ALU_ADD,
        ALU_SUB,
        ALU_AND,
        ALU_OR,
        ALU_XOR,
        ALU_SLT
    } alu_op_t;

    typedef struct packed {
        bit [3:0] op;
        bit [2:0] rs;
        bit [2:0] rt;
        bit [2:0] rd;
        bit [5:0] immediate;
        bit [11:0] address;
    } fields_t; 

    typedef struct packed {
        logic reg_write;
        logic mem_read;
        logic mem_write;
        logic reg_dst;
        logic alu_src;
        logic mem_to_reg;
        logic branch;
        logic halt;
        logic jump;
        alu_op_t alu_op;
    } control_t; 

    typedef struct packed {
        //Fetched instruction
        logic [15:0] instruction;
        //PC value associated with instruction
        logic [15:0] pc;
        //Decoded fields
        fields_t fields;
        //logic valid;
    } if_id_t;

    typedef struct packed {
        logic [15:0] pc;
        //Control fields
        control_t control;
        //Decoded fields
        fields_t fields;
        //Data from source and target registers
        logic [15:0] reg_data1;
        logic [15:0] reg_data2;
        //Sign extended immediate/address
        logic[15:0] extended_imm;
        logic [15:0] extended_add;
        //logic valid;
    } id_ex_t;

    typedef struct packed {
        logic [15:0] pc;
        //Control fields
        control_t control;
        //Decoded fields
        fields_t fields;
        //ALU values
        logic [15:0] alu_result;
        logic zero;
        //Sign extended address for JMP instruction
        logic [15:0] extended_add;
        //Value from register (read_data2)
        logic [15:0] store_data;
        //Register to write to decided by reg_dst control signal
        logic [2:0] write_reg;
        //logic valid;
    } ex_mem_t;

    typedef struct packed {
        //Control fields
        control_t control;
        //Data to be read from memory
        logic [15:0] read_mem_data;
        //Register to be written to
        logic [2:0] write_reg;
        //ALU result passed over from exe/mem
        logic [15:0] alu_result;
        //logic valid;
    } mem_wb_t;


`endif