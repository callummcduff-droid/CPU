`include "define.svh"

module hazard_unit (
    input logic clk,
    input logic id_ex_mem_read,
    input logic id_ex_branch,
    input logic halt,
    input logic [3:0] id_ex_is,
    input logic [2:0] id_ex_target,
    input logic [2:0] if_id_rs,
    input logic [2:0] if_id_rt,
    input logic zero,
    output logic stall,
    output logic flush
    );


    always_comb begin
        stall = 0;
        flush = 0;
        /*Deals with load-use hazard, if the current instruction in the ID/EX register features a source or
        target register whose value is yet to be loaded from memory, the pipeline will have to stall until WB*/
        if (id_ex_mem_read && id_ex_target != 3'b000 &&
        (id_ex_target == if_id_rs || id_ex_target == if_id_rt)) begin
            stall = 1;
        end
        //Branch handling
        if (id_ex_branch) begin
        //If a branch is taken, flush
            if ((id_ex_is == OP_BEQ && zero) || (id_ex_is == OP_BNE && !zero)) begin
                flush = 1;
            end
        end
        /*If the instruction in the ID/EX register is JMP, flush so the instructions immediately following JMP
        aren't executed*/
        else if (id_ex_is == OP_JMP) begin
            flush = 1;
        end
        //If the program has finished, flush the instructions currently in the pipeline to prevent subsequent execution
        else if (halt) begin
            flush = 1;
        end
    end
endmodule
