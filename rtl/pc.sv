`include "define.svh"

module pc(input logic clk, 
        input logic reset,
        input logic stall, 
        input logic [15:0] next_pc, 
        output logic [15:0] pc);
        
    always_ff @(posedge clk) begin
        if (reset) begin
            pc <= 0;
        end
        else if (!stall) begin
            pc <= next_pc;
        end

        
    end

endmodule