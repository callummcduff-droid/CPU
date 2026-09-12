import define::*;

module cpu(input logic clk,
         input logic reset, 
         output logic halted);
    //PC variables
    logic [15:0] pc, next_pc;

    //Structural variables
    fields_t fields;
    control_t control;

    //Instruction
    logic [15:0] instruction;

    //ALU variables
    logic overflow, zero;
    logic [15:0] alu_a, alu_result;

    //Register variables
    logic [15:0] write_data;
    logic [2:0] write_reg;
    logic [15:0] reg_data1, reg_data2;
    
    //Data memory variables
    logic [15:0] address;
    logic [15:0] read_mem_data;

    //Sign extension variables
    logic [15:0] extended_imm, extended_add;

    always_ff @(posedge clk) begin
        if (reset) begin
            halted <= 0;
        end
        else if (control.halt) begin
            halted <= 1;
        end
    end

    //Assign next PC value
    always_comb begin
        next_pc = pc + 1;
        if (control.halt || halted) begin
            next_pc = pc;
        end
        else if (control.jump) begin
            next_pc = extended_add / 2;
        end
        else if (control.branch) begin
            if (fields.op == OP_BEQ && zero) begin
                next_pc = extended_imm / 2;
            end
            else if (fields.op == OP_BNE && ~zero) begin
                next_pc = extended_imm / 2;
            end
        end
    end

    always_comb begin
        //Assign second ALU operand
        alu_a = (control.alu_src) ? extended_imm : reg_data2;
        
        //Assigning the data to write to a register and which register
        write_data = (control.mem_to_reg) ? read_mem_data : alu_result;
        write_reg = (control.reg_dst) ? fields.rd : fields.rt;
    end


    //ALU
    alu u_alu(.a(alu_a), .b(reg_data1), .alu_op(control.alu_op), .result(alu_result), .overflow(overflow), .zero(zero));
    
    //Decoder
    decoder u_decoder(.instruction(instruction), .fields(fields));
    
    //Program Counter
    pc u_pc(.clk(clk), .reset(reset), .next_pc(next_pc), .pc(pc));
    
    //Registers
    registers u_registers(.clk(clk), .reset(reset), .rs(fields.rs), .rt(fields.rt), .reg_write(control.reg_write), 
    .write_data(write_data), .write_reg(write_reg), .read_data1(reg_data1), .read_data2(reg_data2));

    //Data Memory
    data_mem u_data_mem(.clk(clk), .mem_read(control.mem_read), .mem_write(control.mem_write), 
    .address(alu_result), .write(reg_data2), .read(read_mem_data));
    
    //Instruction Memory
    inst_mem u_inst_mem(.clk(clk), .pc(pc), .instruction(instruction));

    //Control Unit
    cu u_cu(.op(fields.op), .control(control));

    //Sign extension
    sign_ext u_sign_ext(.immediate(fields.immediate), .address(fields.address), .extended_imm(extended_imm), 
    .extended_add(extended_add));

endmodule

