`include "define.svh"

module sign_ext (
    input logic [5:0] immediate,
    input logic [11:0] address,
    output logic [15:0] extended_imm,
    output logic [15:0] extended_add
);

    always_comb begin
        extended_imm = {10'd0, immediate[5:0]};
        extended_add = {4'd0, address[11:0]};
    end

endmodule