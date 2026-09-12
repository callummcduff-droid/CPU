`include "define.svh"

module cu (input logic [3:0] op,
        output control_t control
        );

        always_comb begin
            control = '0;
            control.alu_op = ALU_ADD;
            case(op)
                OP_ADD, OP_SUB, OP_AND, OP_OR, OP_XOR: begin
                    control.reg_write = 1;
                    control.mem_read = 0;
                    control.mem_write = 0;
                    control.reg_dst = 1;
                    control.alu_src = 0;
                    control.mem_to_reg = 0;
                    control.branch = 0;
                    control.jump = 0;
                    control.halt = 0;
                end
                OP_LOAD: begin
                    control.reg_write = 1;
                    control.mem_read = 1;
                    control.mem_write = 0;
                    control.reg_dst = 0;
                    control.alu_src = 1;
                    control.mem_to_reg = 1;
                    control.branch = 0;
                    control.jump = 0;
                    control.halt = 0;
                end
                OP_LOADI: begin
                    control.reg_write = 1;
                    control.mem_read = 0;
                    control.mem_write = 0;
                    control.reg_dst = 0;
                    control.alu_src = 1;
                    control.mem_to_reg = 0;
                    control.branch = 0;
                    control.jump = 0;
                    control.halt = 0;
                end
                OP_STORE: begin
                    control.reg_write = 0;
                    control.mem_read = 0;
                    control.mem_write = 1;
                    control.reg_dst = 0;
                    control.alu_src = 1;
                    control.mem_to_reg = 0;
                    control.branch = 0;
                    control.jump = 0;
                    control.halt = 0;
                end
                OP_BEQ, OP_BNE: begin
                    control.reg_write = 0;
                    control.mem_read = 0;
                    control.mem_write = 0;
                    control.reg_dst = 0;
                    control.alu_src = 0;
                    control.mem_to_reg = 0;
                    control.branch = 1;
                    control.jump = 0;
                    control.halt = 0;
                end
                OP_NOP: begin
                    control.reg_write = 0;
                    control.mem_read = 0;
                    control.mem_write = 0;
                    control.reg_dst = 0;
                    control.alu_src = 0;
                    control.mem_to_reg = 0;
                    control.branch = 0;
                    control.jump = 0;
                    control.halt = 0;
                end
                OP_JMP: begin
                    control.reg_write = 0;
                    control.mem_read = 0;
                    control.mem_write = 0;
                    control.reg_dst = 0;
                    control.alu_src = 0;
                    control.mem_to_reg = 0;
                    control.branch = 0;
                    control.jump = 1;
                    control.halt = 0;
                end
                OP_HALT: begin
                    control.reg_write = 0;
                    control.mem_read = 0;
                    control.mem_write = 0;
                    control.reg_dst = 0;
                    control.alu_src = 0;
                    control.mem_to_reg = 0;
                    control.branch = 0;
                    control.jump = 0;
                    control.halt = 1;
                end
                default: begin
                end
                    
            endcase
            case(op)
                OP_ADD, OP_LOAD, OP_STORE: control.alu_op = ALU_ADD;
                OP_SUB: control.alu_op = ALU_SUB;
                OP_AND: control.alu_op = ALU_AND;
                OP_OR: control.alu_op = ALU_OR;
                OP_XOR: control.alu_op = ALU_XOR;
                OP_BEQ: control.alu_op = ALU_SUB;
                OP_BNE: control.alu_op = ALU_SUB;
                default: begin
                end
                
                
            endcase
        end


endmodule
