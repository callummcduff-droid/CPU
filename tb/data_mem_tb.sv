import define::*;

module data_mem_tb;

    logic clk;
    logic mem_read, mem_write;
    logic [15:0] address;
    logic [15:0] read, write;
    

    data_mem dut (
        .clk(clk),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .address(address),
        .read(read),
        .write(write)
    );

    //Setting up wave file
    initial begin
        $dumpfile("waves/data_mem_tb.vcd");
        $dumpvars(0, data_mem_tb);
    end

    //Setting up clock
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    //Running tests
    initial begin

        //Testing write
        mem_read = 0;
        mem_write = 1;
        address = 16'h0000;
        write = 16'h0001;

        @(posedge clk);
        #1;
        
        //Testing read
        mem_read = 1;
        mem_write = 0;

        @(posedge clk);
        #1;
        assert(read == write)
            else $error("Reading from memory failed");

        $display("Data memory testbench has finished.");
        $finish;


    end

endmodule