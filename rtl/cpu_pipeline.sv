`include "define.svh"

module cpu (
        input logic clk,
        input logic reset, 
        output logic halted);
    //PC variables
    logic [15:0] pc, next_pc; //Keep

    //Structural variables
    if_id_t if_id_cur, if_id_next;
    id_ex_t id_ex_cur, id_ex_next;
    ex_mem_t ex_mem_cur, ex_mem_next;
    mem_wb_t mem_wb_cur, mem_wb_next;
    fields_t decoded;

    //ALU variables
    logic [15:0] alu_a; //Keep alu_a

    //Register variables
    logic [15:0] write_data; //Keep write_data

    //Forwarding variables
    logic [1:0] fwd_a, fwd_b, fwd_store_data;
    logic [15:0] forwarded_a, forwarded_b, forwarded_store_data;

    //Hazard variables
    logic stall;
    logic flush;

    
    always_ff @(posedge clk) begin
        if (reset) begin
            halted <= 0;
        end
        else if (ex_mem_cur.control.halt) begin
            halted <= 1;
        end
    end

    //Assign next PC value
    always_comb begin
        next_pc = pc + 1;
        if (id_ex_cur.control.halt || halted) begin
            next_pc = pc;
        end
        else if (id_ex_cur.control.jump) begin
            next_pc = id_ex_cur.extended_add / 2;
        end
        else if (id_ex_cur.control.branch) begin
            if ((id_ex_cur.fields.op == OP_BEQ && ex_mem_next.zero) ||
            (id_ex_cur.fields.op == OP_BNE && ~ex_mem_next.zero)) begin
                next_pc = id_ex_cur.extended_imm / 2;
            end
        end
    end

    //Assigns intermediate values
    always_comb begin
        //Assign second ALU operand
        alu_a = (id_ex_cur.control.alu_src) ? id_ex_cur.extended_imm : id_ex_cur.reg_data2;
        
        //Assigning the data to write to a register and which register
        write_data = (mem_wb_cur.control.mem_to_reg) ? mem_wb_cur.read_mem_data : mem_wb_cur.alu_result;
        ex_mem_next.write_reg = (id_ex_cur.control.reg_dst) ? id_ex_cur.fields.rd : id_ex_cur.fields.rt;

        id_ex_next.fields = decoded;

        ex_mem_next.store_data = forwarded_store_data; //id_ex_cur.reg_data2
        ex_mem_next.extended_add = id_ex_cur.extended_add;
        ex_mem_next.control = id_ex_cur.control;

        mem_wb_next.write_reg = ex_mem_cur.write_reg;
        mem_wb_next.alu_result = ex_mem_cur.alu_result;
        mem_wb_next.control = ex_mem_cur.control;
    end

    //Forwarding multiplexers
    always_comb begin
        case(fwd_a)
            2'b10: forwarded_a = ex_mem_cur.alu_result;
            2'b01: forwarded_a = write_data;
            2'b00: forwarded_a = alu_a;
            default: begin
                forwarded_a = alu_a;
            end
        endcase
        case(fwd_b)
            2'b10: forwarded_b = ex_mem_cur.alu_result;
            2'b01: forwarded_b = write_data;
            2'b00: forwarded_b = id_ex_cur.reg_data1;
            default: begin
                forwarded_b = id_ex_cur.reg_data1;
            end
        endcase
        case(fwd_store_data)
            2'b10: forwarded_store_data = ex_mem_cur.alu_result;
            2'b01: forwarded_store_data = write_data;
            2'b00: forwarded_store_data = id_ex_cur.reg_data2;
            default: begin
                forwarded_store_data = id_ex_cur.reg_data2;
            end
        endcase

    end


    //ALU
    alu u_alu(.a(forwarded_a), .b(forwarded_b), .alu_op(id_ex_cur.control.alu_op), .result(ex_mem_next.alu_result),
     .zero(ex_mem_next.zero));
    
    //Decoder
    decoder u_decoder(.instruction(if_id_cur.instruction), .fields(decoded));
    
    //Program Counter
    pc u_pc(.clk(clk), .stall(stall), .reset(reset), .next_pc(next_pc), .pc(pc));
    
    //Registers
    registers u_registers(.clk(clk), .reset(reset), .rs(decoded.rs),
     .rt(decoded.rt), .reg_write(mem_wb_cur.control.reg_write), 
    .write_data(write_data), .write_reg(mem_wb_cur.write_reg), .read_data1(id_ex_next.reg_data1),
    .read_data2(id_ex_next.reg_data2));

    //Data Memory
    data_mem u_data_mem(.clk(clk), .mem_read(ex_mem_cur.control.mem_read), .mem_write(ex_mem_cur.control.mem_write), 
    .address(ex_mem_cur.alu_result), .write(ex_mem_cur.store_data), .read(mem_wb_next.read_mem_data));
    
    //Instruction Memory
    inst_mem u_inst_mem 
    (.clk(clk), .pc_in(pc), .instruction(if_id_next.instruction), .pc_out(if_id_next.pc));

    //Control Unit
    cu u_cu(.op(decoded.op), .control(id_ex_next.control));

    //Sign extension
    sign_ext u_sign_ext(.immediate(decoded.immediate), .address(decoded.address), 
    .extended_imm(id_ex_next.extended_imm), 
    .extended_add(id_ex_next.extended_add));

    //Pipeline registers
    if_id_reg u_if_id_reg(.clk(clk), .reset(reset), .stall(stall), .flush(flush),
    .if_id_next(if_id_next), .if_id_cur(if_id_cur));
    
    id_ex_reg u_id_ex_reg(.clk(clk), .reset(reset), .stall(stall), .flush(flush),
    .id_ex_next(id_ex_next), .id_ex_cur(id_ex_cur));

    ex_mem_reg u_ex_mem_reg(.clk(clk), .reset(reset), .ex_mem_next(ex_mem_next), .ex_mem_cur(ex_mem_cur));

    mem_wb_reg u_mem_wb_reg(.clk(clk), .reset(reset), .mem_wb_next(mem_wb_next), .mem_wb_cur(mem_wb_cur));

    fwd_unit u_fwd_unit(.id_ex_rs(id_ex_cur.fields.rs), .id_ex_rt(id_ex_cur.fields.rt),
    .id_ex_alu_src(id_ex_cur.control.alu_src), .id_ex_is(id_ex_cur.fields.op),
    .ex_mem_rd(ex_mem_cur.write_reg), .mem_wb_rd(mem_wb_cur.write_reg),
    .ex_mem_write(ex_mem_cur.control.reg_write), 
    .mem_wb_write(mem_wb_cur.control.reg_write), .ex_mem_is(ex_mem_cur.fields.op),
    .fwd_a(fwd_a), .fwd_b(fwd_b), .fwd_store_data(fwd_store_data));

    hazard_unit u_hazard_unit(.clk(clk), .id_ex_mem_read(id_ex_cur.control.mem_read),
    .id_ex_branch(id_ex_cur.control.branch), .halt(id_ex_cur.control.halt),
    .id_ex_is(id_ex_cur.fields.op), .id_ex_target(id_ex_cur.fields.rt), 
    .if_id_rs(decoded.rs), .if_id_rt(decoded.rt), 
    .zero(ex_mem_next.zero), .stall(stall), .flush(flush));

endmodule

