import define::*;

module pc_tb;

    logic clk;
    logic reset;
    logic [15:0] pc, next_pc;

    pc dut(
        .clk(clk),
        .reset(reset),
        .pc(pc),
        .next_pc(next_pc)
    );

    initial begin
        $dumpfile("waves/pc_tb.vcd");
        $dumpvars(0, pc_tb);
    end
    

    //Setting clock
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    //Running tests
    initial begin

        //Test reset
        reset = 1;
        next_pc = 16'h0001;

        @(posedge clk);
        #1;
        assert(pc == 16'h0000)
            else $error("Reset failed");

        //Test next_pc
        reset = 0;
        next_pc = 16'h0002;

        @(posedge clk);
        #1;
        assert(pc == 16'h0002)
            else $error("Next PC assignment failed");
        
        $display("PC testbench finished.");
        $finish;

        
    end

endmodule