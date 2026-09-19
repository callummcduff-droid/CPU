`include "define.svh"

module decoder_tb;
    logic [15:0] instruction;
    fields_t fields;

    decoder dut(
        .instruction(instruction),
        .fields(fields)
    );

    initial begin

        $dumpfile("waves/decoder_tb.vcd");
        $dumpvars(0, decoder_tb);

        //Check R-type instructions
        //Check ADD
        instruction = 16'b0011001010011000;

        #1

        assert (fields.op == OP_ADD)
            else $error("Opcode assignment failed");
        assert (fields.rs == 3'b001);
            else $error("Source register assignment failed");
        assert (fields.rt == 3'b010)
            else $error("Target register assignment failed");
        assert (fields.rd == 3'b011)
            else $error("Destination register assignment failed");

        //Check Imm-type instructions
        //Check LOADI
        instruction = 16'b0001100101000001;

        #1

        assert (fields.op == OP_LOADI)
            else $error("Opcode assignment failed");
        assert (fields.rs == 3'b100);
            else $error("Source register assignment failed");
        assert (fields.rt == 3'b101)
            else $error("Target register assignment failed");
        assert (fields.immediate == 6'b000001)
            else $error("Immediate assignment failed");

        //Check Jump-type instructions
        //Check JMP
        instruction = 16'b1011000000000001;

        #1

        assert (fields.op == OP_JMP)
            else $error("Opcode assignment failed");
        assert (fields.address == 12'b000000000001)
            else $error("Address assignment failed");

        $display("Decoder testbench finished");
        $finish;

        
    end

endmodule