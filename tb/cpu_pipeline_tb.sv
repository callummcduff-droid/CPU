`include "define.svh"

module test_cpu #(
    parameter int TEST_ID = 0
);

    logic clk, reset, halted;

    cpu dut(
        .clk(clk),
        .reset(reset),
        .halted(halted)
    );

    //Setting up wave file
    initial begin
        $dumpfile("waves/cpu_pipeline_tb.vcd");
        $dumpvars(0, cpu_pipeline_tb);
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
        wait (dut.halted) begin
            @(posedge clk);

            /*$display(
                "time=%0t PC=%h ID/EX reg_write=%b EX/MEM reg_write=%b MEM/WB reg_write=%b",
                $time,
                dut.pc,
                dut.id_ex_cur.control.reg_write,
                dut.ex_mem_cur.control.reg_write,
                dut.mem_wb_cur.control.reg_write
            );*/
        end

        #1;

        assert (dut.u_registers.regs[0] == 16'h0000)
            else $error("R0 incorrect");
        
        case(TEST_ID)
            0: begin //test_alu
                assert (dut.u_registers.regs[1] == 16'h0005)
                    else $fatal(1, "test_alu: R1 incorrect.");
                assert (dut.u_registers.regs[2] == 16'h0003)
                    else $fatal(1, "test_alu: R2 incorrect.");
                assert (dut.u_registers.regs[3] == 16'h0008)
                    else $fatal(1, "test_alu: R3 incorrect.");
                assert (dut.u_registers.regs[4] == 16'h0005)
                    else $fatal(1, "test_alu: R4 incorrect.");
            end
            1: begin //test_memory
                assert (dut.u_registers.regs[1] == 16'h0005)
                    else $fatal(1, "test_memory: R1 incorrect.");
                assert (dut.u_registers.regs[2] == 16'h0005)
                    else $fatal(1, "test_memory: R2 incorrect.");
            end
            2: begin //test_forwarding
                assert (dut.u_registers.regs[1] == 16'h0005)
                    else $fatal(1, "test_forwarding: R1 incorrect.");
                assert (dut.u_registers.regs[2] == 16'h000A)
                    else $fatal(1, "test_forwarding: R2 incorrect.");
                assert (dut.u_registers.regs[3] == 16'h000F)
                    else $fatal(1, "test_forwarding: R3 incorrect.");
                assert (dut.u_registers.regs[4] == 16'h0005)
                    else $fatal(1, "test_forwarding: R4 incorrect.");
            end
            3: begin //test_load_use
                assert (dut.u_registers.regs[1] == 16'h0005)
                    else $fatal(1, "test_load_use: R1 incorrect.");
                assert (dut.u_registers.regs[2] == 16'h0005)
                    else $fatal(1, "test_load_use: R2 incorrect.");
                assert (dut.u_registers.regs[3] == 16'h000A)
                    else $fatal(1, "test_load_use: R3 incorrect.");
            end
            4: begin //test_store_forwarding
                assert (dut.u_registers.regs[1] == 16'h0005)
                    else $fatal(1, "test_store_forwarding: R1 incorrect.");
                assert (dut.u_registers.regs[2] == 16'h0003)
                    else $fatal(1, "test_store_forwarding: R2 incorrect.");
                assert (dut.u_registers.regs[3] == 16'h0008)
                    else $fatal(1, "test_store_forwarding: R3 incorrect.");
                assert (dut.u_registers.regs[4] == 16'h0008)
                    else $fatal(1, "test_store_forwarding: R4 incorrect.");
            end
            5: begin //test_beq_taken
                assert (dut.u_registers.regs[1] == 16'h0005)
                    else $fatal(1, "test_beq_taken: R1 incorrect.");
                assert (dut.u_registers.regs[2] == 16'h0005)
                    else $fatal(1, "test_beq_taken: R2 incorrect.");
                assert (dut.u_registers.regs[3] == 16'h000A)
                    else $fatal(1, "test_beq_taken: R3 incorrect.");
            end
            6: begin //test_beq_not_taken
                assert (dut.u_registers.regs[1] == 16'h0005)
                    else $fatal(1, "test_beq_not_taken: R1 incorrect.");
                assert (dut.u_registers.regs[2] == 16'h0006)
                    else $fatal(1, "test_beq_not_taken: R2 incorrect.");
                assert (dut.u_registers.regs[3] == 16'h000A)
                    else $fatal(1, "test_beq_not_taken: R3 incorrect.");
            end
            7: begin //test_bne_taken
                assert (dut.u_registers.regs[1] == 16'h0005)
                    else $fatal(1, "test_bne_taken: R1 incorrect.");
                assert (dut.u_registers.regs[2] == 16'h0006)
                    else $fatal(1, "test_bne_taken: R2 incorrect.");
                assert (dut.u_registers.regs[3] == 16'h000A)
                    else $fatal(1, "test_bne_taken: R3 incorrect.");
            end
            8: begin //test_bne_not_taken
                assert (dut.u_registers.regs[1] == 16'h0005)
                    else $fatal(1, "test_bne_not_taken: R1 incorrect.");
                assert (dut.u_registers.regs[2] == 16'h0005)
                    else $fatal(1, "test_bne_not_taken: R2 incorrect.");
                assert (dut.u_registers.regs[3] == 16'h000A)
                    else $fatal(1, "test_bne_not_taken: R3 incorrect.");
            end
            9: begin //test_jump
                assert (dut.u_registers.regs[1] == 16'h0005)
                    else $fatal(1, "test_jump: R1 incorrect.");
                assert (dut.u_registers.regs[2] == 16'h000A)
                    else $fatal(1, "test_jump: R2 incorrect.");
                
            end
            10: begin //test_halt
                assert (dut.u_registers.regs[1] == 16'h0005)
                    else $fatal(1, "test_halt: R1 incorrect.");
                assert (dut.u_registers.regs[2] == 16'h0000)
                    else $fatal(1, "test_halt: R2 incorrect.");
                assert (dut.u_registers.regs[3] == 16'h0000)
                    else $fatal(1, "test_halt: R3 incorrect.");
            end
        endcase

        $display("PASS: TEST_ID: %d", TEST_ID);
        $finish;
    end


endmodule    