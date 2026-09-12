import define::*;

module if_id_tb;
    logic clk, reset;
    if_id_t if_id_next, if_id_cur;

    if_id_reg dut (
        .clk(clk),
        .reset(reset),
        .if_id_next(if_id_next),
        .if_id_cur(if_id_cur)
    );

    //Setting up wave file
    initial begin
        $dumpfile("waves/if_id_tb.vcd");
        $dumpvars(0, if_id_tb);
    end

    //Setting up clock
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    //Running tests
    initial begin
        if_id_cur = '0;
        if_id_next = '1;
        reset = 0;

        @(posedge clk);
        #1;
        assert (if_id_cur == '1)
            else $error("Transition failed");

        reset = 1;

        @(posedge clk);
        #1;
        assert (if_id_cur == '0)
            else $error("Reset failed");
        
        $display("IF/ID testbench finished.");
        $finish;

    end


endmodule