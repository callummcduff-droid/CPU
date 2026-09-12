`include "define.svh"

module mem_wb_reg(
    input logic clk,
    input logic reset,
    input mem_wb_t mem_wb_next,
    output mem_wb_t mem_wb_cur

);

    mem_wb_t hold;

    always_comb begin
        mem_wb_cur = hold;
    end
    
    always_ff @(posedge clk) begin
        if (reset) begin
            hold <= '0;
        end
        else begin
            hold <= mem_wb_next;
        end

    end

endmodule