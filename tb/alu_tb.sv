`include "define.svh"

module alu_tb;

    logic [15:0] a, b, result;
    logic zero, overflow;
    alu_op_t alu_op;

    alu dut(
        .a(a),
        .b(b),
        .alu_op(alu_op),
        .result(result),
        .zero(zero),
        .overflow(overflow)
    );

    initial begin

        $dumpfile("waves/alu_tb.vcd");
        $dumpvars(0, alu_tb);

        //Test ADD
        a = 16'd3;
        b = 16'd5;
        alu_op = ALU_ADD;

        #1;

        assert (result == 16'd8)
            else $error("ADD failed");

        //Test SUB
        a = 16'd5;
        b = 16'd3;
        alu_op = ALU_SUB;

        #1;

        assert (result == 16'd2)
            else $error("SUB failed");

        //Test AND
        a = 16'd3;
        b = 16'd5;
        alu_op = ALU_AND;

        #1;

        assert (result == 16'd1)
            else $error("AND failed");

        //Test OR
        a = 16'd3;
        b = 16'd5;
        alu_op = ALU_OR;

        #1;

        assert (result == 16'd7)
            else $error("OR failed");

        //Test XOR
        a = 16'd3;
        b = 16'd5;
        alu_op = ALU_XOR;

        #1;

        assert (result == 16'd6)
            else $error("XOR failed");

        //Test Zero
        a = 16'd3;
        b = 16'd3;
        alu_op = ALU_SUB;

        #1;

        assert (zero == 1'd1)
            else $error("Zero affirmed failed");

        
        a = 16'd3;
        b = 16'd5;
        alu_op = ALU_SUB;

        #1;

        assert (zero == 1'd0)
            else $error("Zero not affirmed failed");

        $display("ALU testbench has finished.");
        $finish;    

    end


endmodule    