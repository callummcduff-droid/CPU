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
        if (id_ex_mem_read && id_ex_target != 3'b000 &&
        (id_ex_target == if_id_rs || id_ex_target == if_id_rt)) begin
            stall = 1;
        end
        if (id_ex_branch) begin
            if ((id_ex_is == OP_BEQ && zero) || (id_ex_is == OP_BNE && !zero)) begin
                flush = 1;
            end
        end
        else if (id_ex_is == OP_JMP) begin
            flush = 1;
        end
        else if (halt) begin
            flush = 1;
        end
    end
endmodule
