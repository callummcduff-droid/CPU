`include "define.svh"

module cu_tb;

    logic [3:0] op;
    control_t control;

    cu dut(
        .op(op),
        .control(control)
    );

    initial begin

        $dumpfile("waves/cu_tb.vcd");
        $dumpvars(0, cu_tb);

        //Tests ADD
        op = 4'h3;

        #1;

        $display("ADD");
        assert(control.alu_op == ALU_ADD)
            else $error("Incorrect ALU operation");
        assert(control.reg_write == 1)
            else $error("Incorrect reg_write assignment");
        assert(control.mem_read == 0)
            else $error("Incorrect mem_read assignment");
        assert(control.mem_write == 0)
            else $error("Incorrect mem_write assignment");
        assert(control.reg_dst == 1)
            else $error("Incorrect reg_dst assignment");
        assert(control.alu_src == 0)
            else $error("Incorrect alu_src assignment");
        assert(control.mem_to_reg == 0)
            else $error("Incorrect mem_to_reg assignment");
        assert(control.branch == 0)
            else $error("Incorrect branch assignment");
        assert(control.jump == 0)
            else $error("Incorrect jump assignment");
        assert(control.halt == 0)
            else $error("Incorrect halt assignment");

        //Tests SUB
        op = 4'h4;

        #1;

        $display("SUB");
        assert(control.alu_op == ALU_SUB)
            else $error("Incorrect ALU operation");
        assert(control.reg_write == 1)
            else $error("Incorrect reg_write assignment");
        assert(control.mem_read == 0)
            else $error("Incorrect mem_read assignment");
        assert(control.mem_write == 0)
            else $error("Incorrect mem_write assignment");
        assert(control.reg_dst == 1)
            else $error("Incorrect reg_dst assignment");
        assert(control.alu_src == 0)
            else $error("Incorrect alu_src assignment");
        assert(control.mem_to_reg == 0)
            else $error("Incorrect mem_to_reg assignment");
        assert(control.branch == 0)
            else $error("Incorrect branch assignment");
        assert(control.jump == 0)
            else $error("Incorrect jump assignment");
        assert(control.halt == 0)
            else $error("Incorrect halt assignment");

        //Tests AND
        op = 4'h5;

        #1;

        $display("AND");
        assert(control.alu_op == ALU_AND)
            else $error("Incorrect ALU operation");
        assert(control.reg_write == 1)
            else $error("Incorrect reg_write assignment");
        assert(control.mem_read == 0)
            else $error("Incorrect mem_read assignment");
        assert(control.mem_write == 0)
            else $error("Incorrect mem_write assignment");
        assert(control.reg_dst == 1)
            else $error("Incorrect reg_dst assignment");
        assert(control.alu_src == 0)
            else $error("Incorrect alu_src assignment");
        assert(control.mem_to_reg == 0)
            else $error("Incorrect mem_to_reg assignment");
        assert(control.branch == 0)
            else $error("Incorrect branch assignment");
        assert(control.jump == 0)
            else $error("Incorrect jump assignment");
        assert(control.halt == 0)
            else $error("Incorrect halt assignment");

        //Tests OR
        op = 4'h6;

        #1;

        $display("OR");
        assert(control.alu_op == ALU_OR)
            else $error("Incorrect ALU operation");
        assert(control.reg_write == 1)
            else $error("Incorrect reg_write assignment");
        assert(control.mem_read == 0)
            else $error("Incorrect mem_read assignment");
        assert(control.mem_write == 0)
            else $error("Incorrect mem_write assignment");
        assert(control.reg_dst == 1)
            else $error("Incorrect reg_dst assignment");
        assert(control.alu_src == 0)
            else $error("Incorrect alu_src assignment");
        assert(control.mem_to_reg == 0)
            else $error("Incorrect mem_to_reg assignment");
        assert(control.branch == 0)
            else $error("Incorrect branch assignment");
        assert(control.jump == 0)
            else $error("Incorrect jump assignment");
        assert(control.halt == 0)
            else $error("Incorrect halt assignment");

        //Tests XOR
        op = 4'h7;

        #1;

        $display("XOR");
        assert(control.alu_op == ALU_XOR)
            else $error("Incorrect ALU operation");
        assert(control.reg_write == 1)
            else $error("Incorrect reg_write assignment");
        assert(control.mem_read == 0)
            else $error("Incorrect mem_read assignment");
        assert(control.mem_write == 0)
            else $error("Incorrect mem_write assignment");
        assert(control.reg_dst == 1)
            else $error("Incorrect reg_dst assignment");
        assert(control.alu_src == 0)
            else $error("Incorrect alu_src assignment");
        assert(control.mem_to_reg == 0)
            else $error("Incorrect mem_to_reg assignment");
        assert(control.branch == 0)
            else $error("Incorrect branch assignment");
        assert(control.jump == 0)
            else $error("Incorrect jump assignment");
        assert(control.halt == 0)
            else $error("Incorrect halt assignment");

        //Tests LOAD
        op = 4'h9;

        #1;

        $display("LOAD");
        assert(control.reg_write == 1)
            else $error("Incorrect reg_write assignment");
        assert(control.mem_read == 1)
            else $error("Incorrect mem_read assignment");
        assert(control.mem_write == 0)
            else $error("Incorrect mem_write assignment");
        assert(control.reg_dst == 0)
            else $error("Incorrect reg_dst assignment");
        assert(control.alu_src == 1)
            else $error("Incorrect alu_src assignment");
        assert(control.mem_to_reg == 1)
            else $error("Incorrect mem_to_reg assignment");
        assert(control.branch == 0)
            else $error("Incorrect branch assignment");
        assert(control.jump == 0)
            else $error("Incorrect jump assignment");
        assert(control.halt == 0)
            else $error("Incorrect halt assignment");

        //Tests LOADI
        op = 4'h1;

        #1;

        $display("LOADI");
        assert(control.reg_write == 1)
            else $error("Incorrect reg_write assignment");
        assert(control.mem_read == 0)
            else $error("Incorrect mem_read assignment");
        assert(control.mem_write == 0)
            else $error("Incorrect mem_write assignment");
        assert(control.reg_dst == 0)
            else $error("Incorrect reg_dst assignment");
        assert(control.alu_src == 1)
            else $error("Incorrect alu_src assignment");
        assert(control.mem_to_reg == 0)
            else $error("Incorrect mem_to_reg assignment");
        assert(control.branch == 0)
            else $error("Incorrect branch assignment");
        assert(control.jump == 0)
            else $error("Incorrect jump assignment");
        assert(control.halt == 0)
            else $error("Incorrect halt assignment");

        //Tests STORE
        op = 4'hA;

        #1;

        $display("STORE");
        assert(control.reg_write == 0)
            else $error("Incorrect reg_write assignment");
        assert(control.mem_read == 0)
            else $error("Incorrect mem_read assignment");
        assert(control.mem_write == 1)
            else $error("Incorrect mem_write assignment");
        assert(control.reg_dst == 0)
            else $error("Incorrect reg_dst assignment");
        assert(control.alu_src == 1)
            else $error("Incorrect alu_src assignment");
        assert(control.mem_to_reg == 0)
            else $error("Incorrect mem_to_reg assignment");
        assert(control.branch == 0)
            else $error("Incorrect branch assignment");
        assert(control.jump == 0)
            else $error("Incorrect jump assignment");
        assert(control.halt == 0)
            else $error("Incorrect halt assignment");

        //Tests BEQ (branching in general)
        op = 4'hC;

        #1;

        $display("BEQ");
        assert(control.reg_write == 0)
            else $error("Incorrect reg_write assignment");
        assert(control.mem_read == 0)
            else $error("Incorrect mem_read assignment");
        assert(control.mem_write == 0)
            else $error("Incorrect mem_write assignment");
        assert(control.reg_dst == 0)
            else $error("Incorrect reg_dst assignment");
        assert(control.alu_src == 0)
            else $error("Incorrect alu_src assignment");
        assert(control.mem_to_reg == 0)
            else $error("Incorrect mem_to_reg assignment");
        assert(control.branch == 1)
            else $error("Incorrect branch assignment");
        assert(control.jump == 0)
            else $error("Incorrect jump assignment");
        assert(control.halt == 0)
            else $error("Incorrect halt assignment");

        //Tests NOP
        op = 4'h0;

        #1;

        $display("NOP");
        assert(control.reg_write == 0)
            else $error("Incorrect reg_write assignment");
        assert(control.mem_read == 0)
            else $error("Incorrect mem_read assignment");
        assert(control.mem_write == 0)
            else $error("Incorrect mem_write assignment");
        assert(control.reg_dst == 0)
            else $error("Incorrect reg_dst assignment");
        assert(control.alu_src == 0)
            else $error("Incorrect alu_src assignment");
        assert(control.mem_to_reg == 0)
            else $error("Incorrect mem_to_reg assignment");
        assert(control.branch == 0)
            else $error("Incorrect branch assignment");
        assert(control.jump == 0)
            else $error("Incorrect jump assignment");
        assert(control.halt == 0)
            else $error("Incorrect halt assignment");

        //Tests JMP
        op = 4'hB;

        #1;

        $display("JMP");
        assert(control.reg_write == 0)
            else $error("Incorrect reg_write assignment");
        assert(control.mem_read == 0)
            else $error("Incorrect mem_read assignment");
        assert(control.mem_write == 0)
            else $error("Incorrect mem_write assignment");
        assert(control.reg_dst == 0)
            else $error("Incorrect reg_dst assignment");
        assert(control.alu_src == 0)
            else $error("Incorrect alu_src assignment");
        assert(control.mem_to_reg == 0)
            else $error("Incorrect mem_to_reg assignment");
        assert(control.branch == 0)
            else $error("Incorrect branch assignment");
        assert(control.jump == 1)
            else $error("Incorrect jump assignment");
        assert(control.halt == 0)
            else $error("Incorrect halt assignment");

        //Tests HALT
        op = 4'hE;

        #1;

        $display("HALT");
        assert(control.reg_write == 0)
            else $error("Incorrect reg_write assignment");
        assert(control.mem_read == 0)
            else $error("Incorrect mem_read assignment");
        assert(control.mem_write == 0)
            else $error("Incorrect mem_write assignment");
        assert(control.reg_dst == 0)
            else $error("Incorrect reg_dst assignment");
        assert(control.alu_src == 0)
            else $error("Incorrect alu_src assignment");
        assert(control.mem_to_reg == 0)
            else $error("Incorrect mem_to_reg assignment");
        assert(control.branch == 0)
            else $error("Incorrect branch assignment");
        assert(control.jump == 0)
            else $error("Incorrect jump assignment");
        assert(control.halt == 1)
            else $error("Incorrect halt assignment");

        $display("CU testbench has finished.");
        $finish;

    end

endmodule