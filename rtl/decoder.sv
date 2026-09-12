`include "define.svh"

module decoder (
    input logic [15:0] instruction,
    output fields_t fields);
    

    always_comb begin
        fields = '0;
        fields.op = instruction[15:12];
        case (fields.op) 
            OP_ADD, OP_SUB, OP_AND, OP_OR, OP_XOR: begin
                fields.rs = instruction[11:9];
                fields.rt = instruction[8:6];
                fields.rd = instruction[5:3]; 
            end
            OP_LOAD, OP_LOADI, OP_STORE, OP_BEQ, OP_BNE: begin
                fields.rs = instruction[11:9];
                fields.rt = instruction[8:6];
                fields.immediate = instruction[5:0];
            end
            OP_JMP:
                fields.address = instruction[11:0];
            default: begin
            end
                    
        endcase        


    end


endmodule