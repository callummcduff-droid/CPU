`include "define.svh"

module fwd_unit (
    input logic[2:0] id_ex_rs,
    input logic[2:0] id_ex_rt,
    input logic id_ex_alu_src,
    input logic [3:0] id_ex_is,
    input logic[2:0] ex_mem_rd,
    input logic[2:0] mem_wb_rd,
    input logic ex_mem_write,
    input logic mem_wb_write,
    input logic [3:0] ex_mem_is,
    output logic [1:0] fwd_a,
    output logic [1:0] fwd_b,
    output logic [1:0] fwd_store_data
);

    always_comb begin
        //Default values
        fwd_a = 2'b00;
        fwd_b = 2'b00;
        fwd_store_data = 2'b00;
        //Assigning forward A value
        //When the proceeding instruction's target register value depends on the ALU result of the preceeding instruction
        if (!id_ex_alu_src && ex_mem_write && ex_mem_rd == id_ex_rt && ex_mem_is != OP_LOAD) begin
            fwd_a = 2'b10;
        end
        /*When the proceeding instruction's target register depends on the write-back result of the instruction 
        two lines previous*/
        else if (!id_ex_alu_src && mem_wb_write && mem_wb_rd == id_ex_rt) begin
            fwd_a = 2'b01;
        end

        //Assigning forward B value
        //When the proceeding instruction's source register value depends on the ALU result of the preceeding instruction
        if (ex_mem_write && ex_mem_rd == id_ex_rs && ex_mem_is != OP_LOAD) begin
            fwd_b = 2'b10;
        end
        /*When the proceeding instruction's source register depends on the write-back result of the instruction 
        two lines previous*/
        else if (mem_wb_write && mem_wb_rd == id_ex_rs) begin
            fwd_b = 2'b01;
        end

        //STORE-data forwarding
        /*When the insturction in ID/EX register is STORE and the value in the target register to
        be stored depends on the ALU result of the previous instruction and when the previous
        instruction is not LOAD to avoid a load-use hazard*/
        if (id_ex_is == OP_STORE && ex_mem_is != OP_LOAD && ex_mem_write && 
        ex_mem_rd == id_ex_rt) begin
            fwd_store_data = 2'b10;
        end
        /*When the instruction in ID/EX register is STORE and the value in the target register to
        be stored depends on the write-back result of the instruction two lines previous*/
        else if (id_ex_is == OP_STORE && mem_wb_write && mem_wb_rd == id_ex_rt) begin
            fwd_store_data = 2'b01;
        end



    end



endmodule