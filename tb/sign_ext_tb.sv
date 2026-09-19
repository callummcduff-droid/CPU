`include "define.svh"

module sign_ext_tb;

    logic [5:0] immediate;
    logic [11:0] address;
    logic [15:0] extended_imm, extended_add;

    sign_ext dut (
        .immediate(immediate),
        .address(address),
        .extended_imm(extended_imm),
        .extended_add(extended_add)
    );

    initial begin
        $dumpfile("waves/sign_ext_tb.vcd");
        $dumpvars(0, sign_ext_tb);
    end

    initial begin
        immediate = 6'd1;
        address = 12'd2;

        #1;

        assert(extended_imm == 16'd1)
            else $error("Immediate extension failed.");
        assert(extended_add == 16'd2)
            else $error("Address extension failed.");

        $display("Sign extension testbench finished.");
        $finish;    
    end

endmodule