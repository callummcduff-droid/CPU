`include "define.svh"

module registers(input logic clk,
                input logic reset,
                input logic [2:0] rs, rt, 
                input logic reg_write, 
                input logic [15:0] write_data,
                input logic [2:0] write_reg,
                output logic [15:0] read_data1,
                output logic [15:0] read_data2
                );

                logic [15:0] regs [7:0];
                

                always_comb begin
                    read_data1 = (rs == 0) ? 0 : regs[rs];
                    read_data2 = (rt == 0) ? 0 : regs[rt];
                    if (reg_write && write_reg == rs) begin
                        read_data1 = write_data;
                    end
                    else if (reg_write && write_reg == rt) begin
                        read_data2 = write_data;
                    end

                end

                always_ff @(posedge clk) begin
                    
                    if (reset == 1) begin
                        regs[0] <= 0;
                        regs[1] <= 0;
                        regs[2] <= 0;
                        regs[3] <= 0;
                        regs[4] <= 0;
                        regs[5] <= 0;
                        regs[6] <= 0;
                        regs[7] <= 0;
                    end

                    else if (reg_write && write_reg != 0) begin
                        regs[write_reg] <= write_data;
                    end
                    
                end

                
endmodule