`include "define.svh"

module fpga_top(
    input logic clk_25mhz,
    input logic reset_btn,
    output logic [7:0] led

);
    logic halted;

    cpu cpu_inst (
        .clk(clk_25mhz),
        .reset(~reset_btn),
        .halted(halted)
    );

    always_comb begin
        led = 8'h00;
        led[0] = halted;
    end


endmodule