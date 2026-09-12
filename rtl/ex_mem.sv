`include "define.svh"

module ex_mem_reg(
    input logic clk,
    input logic reset,
    input ex_mem_t ex_mem_next,
    output ex_mem_t ex_mem_cur
);

    ex_mem_t hold;

    always_comb begin
        ex_mem_cur = hold;
    end
    
    always_ff @(posedge clk) begin
        if (reset) begin
            hold <= '0;
        end
        else begin
            hold <= ex_mem_next;
        end
        
    end

endmodule