import define::*;

module registers_tb;

    logic clk, reset;
    logic [2:0] rs, rt, write_reg;
    logic reg_write;
    logic [15:0] write_data, read_data1, read_data2;

    registers dut (
        .clk(clk),
        .reset(reset),
        .rs(rs),
        .rt(rt),
        .write_reg(write_reg),
        .reg_write(reg_write),
        .write_data(write_data),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );

    //Setting up wave file
    initial begin
        $dumpfile("waves/registers_tb.vcd");
        $dumpvars(0, registers_tb);
    end

    //Setting up clock
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    //Running tests
    initial begin
        reg_write = 1;
        write_reg = 3'b001;
        write_data = 16'h0001;
        rs = 3'b001;
        rt = 3'b010;

        @(posedge clk);
        #1;
        assert(read_data1 == 16'h0001)
            else $error("Write data failed");
        assert(read_data2 == 16'h0000)
            else $error("Read data 2 failed");

        reg_write = 1;
        write_reg = 3'b010;
        write_data = 16'h0004;

        @(posedge clk);
        #1;
        assert(read_data1 == 16'h0001)
            else $error("Read data 1 failed");
        assert(read_data2 == 16'h0004)
            else $error("Write data 2 failed");

        $display("Register testbench has finished.");
        $finish;

    end


endmodule