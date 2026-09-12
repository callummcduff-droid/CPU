`include "define.svh"

module alu(
    input logic [15:0] a,
    input logic [15:0] b,
    input alu_op_t alu_op,
    output logic [15:0] result,
    output logic zero
    );

    always_comb begin
        result = '0;
        case(alu_op)
            ALU_ADD: result = a + b;
            ALU_SUB: result = a - b;
            ALU_AND: result = a & b;
            ALU_OR: result = a | b;
            ALU_XOR: result = a ^ b;
            ALU_SLT: begin
                if (($signed(a) - $signed(b)) < 0) begin
                    result = 1;
                end
                else begin
                    result = 0;
                end
            end
            default: begin
            end
        endcase     

        if (result == 16'h0000) begin
            zero = 1;
        end
        else begin
            zero = 0;
        end  
    end        

endmodule