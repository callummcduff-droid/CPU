`include "define.svh"

module inst_mem (
                input logic clk, 
                input logic [15:0] pc_in,
                output logic [15:0] instruction,
                output logic [15:0] pc_out);


                logic [15:0] instruction_memory [4095:0];
                

                initial begin
                    $readmemh("programs/current.hex", instruction_memory);
                end

                always_comb begin
                    instruction = instruction_memory[pc_in[11:0]];
                    pc_out = pc_in;
                end

                

                
endmodule