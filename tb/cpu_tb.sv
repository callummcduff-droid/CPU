`include "define.svh"

module test_cpu;

    logic clk, reset, halted;

    cpu dut(
        .clk(clk),
        .reset(reset),
        .halted(halted)
    );

    //Setting up wave file
    initial begin
        $dumpfile("waves/cpu_tb.vcd");
        $dumpvars(0, cpu_tb);
    end

    //Setting up clock
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        //Testing reset
        reset = 1;

        @(posedge clk);
        #1;

        reset = 0;
        wait(dut.halted);
        #1;

        assert (dut.u_registers.regs[0] == 16'h0000)
            else $error("R0 incorrect");
        assert (dut.u_registers.regs[1] == 16'h0005)
            else $error("R1 incorrect");
        assert (dut.u_registers.regs[2] == 16'h000A)
            else $error("R2 incorrect");
        assert (dut.u_registers.regs[3] == 16'h0000)
            else $error("R3 incorrect");
        assert (dut.u_registers.regs[4] == 16'h0000)
            else $error("R4 incorrect");
        assert (dut.u_registers.regs[5] == 16'h0000)
            else $error("R5 incorrect");
        assert (dut.u_registers.regs[6] == 16'h0000)
            else $error("R6 incorrect");
        assert (dut.u_registers.regs[7] == 16'h0000)
            else $error("R7 incorrect");

        $display("CPU testbench has finished.");
        $finish;
    end


endmodule    