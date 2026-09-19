`include "define.svh"

module inst_mem_tb;

    logic clk;
    logic [15:0] pc;
    logic [15:0] instruction;

    inst_mem dut (
        .clk(clk),
        .pc(pc),
        .instruction(instruction)
    );

    //Setting up wave files
    initial begin
        $dumpfile("waves/inst_mem_tb.vcd");
        $dumpvars(0, inst_mem_tb);
    end

    //Setting up clock
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        pc = 16'h0000;

        @(posedge clk);
        #1;
        assert(instruction == 16'h1041)
            else $error("Line 1 failed to load");

        pc = 16'h0001;

        @(posedge clk);
        #1;
        assert(instruction == 16'h1085)
            else $error("Line 2 failed to load");

        pc = 16'h0002;

        @(posedge clk);
        #1;
        assert(instruction == 16'h3298)
            else $error("Line 3 failed to load");

        pc = 16'h0003;

        @(posedge clk);
        #1;
        assert(instruction == 16'h42e0)
            else $error("Line 4 failed to load");

        pc = 16'h0004;

        @(posedge clk);
        #1;
        assert(instruction == 16'h3728)
            else $error("Line 5 failed to load");

        pc = 16'h0005;

        @(posedge clk);
        #1;
        assert(instruction == 16'he000)
            else $error("Line 6 failed to load");

        $display("Instruction memory testbench has finished.");
        $finish;

    end



endmodule
