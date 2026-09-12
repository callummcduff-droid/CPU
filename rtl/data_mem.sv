`include "define.svh"

module data_mem(input logic clk,
                input logic mem_read,
                input logic mem_write,
                input logic [15:0] address,
                input logic [15:0] write,
                output logic [15:0] read);
                 
                logic [15:0] data_memory [4095:0];

                always_comb begin
                    read = '0;
                    if (mem_read) begin
                        read = data_memory[address[11:0]];
                    end
                end

                always_ff @(posedge clk) begin
                    if(mem_write) begin
                        data_memory[address[11:0]] <= write;
                    end
                end 
endmodule