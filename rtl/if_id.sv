`include "define.svh"

module if_id_reg(
    input logic clk,
    input logic reset,
    input logic stall,
    input logic flush,
    input if_id_t if_id_next,
    output if_id_t if_id_cur

);

    if_id_t hold;

    always_comb begin
        if_id_cur = hold;
    end
    
    always_ff @(posedge clk) begin
        if (reset || flush) begin
            hold <= '0;
        end
        else if (stall) begin
        end
        else begin
            hold <= if_id_next;
        end

    end

endmodule