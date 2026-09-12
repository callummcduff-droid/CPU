`include "define.svh"

module id_ex_reg(
    input logic clk,
    input logic reset,
    input logic stall,
    input logic flush,
    input id_ex_t id_ex_next,
    output id_ex_t id_ex_cur

);

    id_ex_t hold;

    always_comb begin
        id_ex_cur = hold;
    end
    
    always_ff @(posedge clk) begin
        if (reset || stall || flush) begin
            hold <= '0;
        end
        else begin
            hold <= id_ex_next;
        end

    end

endmodule