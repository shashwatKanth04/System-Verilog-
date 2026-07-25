`timescale 1ns/1ps

module tb_dff_register_dup;

    reg clk;
    reg [3:0] d;
    wire [3:0] q;
    wire mismatch;

    // DUT
    dff_register_dup #(.WIDTH(4)) dut (
        .clk(clk),
        .d(d),
        .q(q),
        .mismatch(mismatch)
    );

    // Clock generation
    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    // Stimulus
    integer i;
    initial begin
        d = 4'h0;

        // Run a few cycles
        for (i = 0; i < 16; i = i + 1) begin
            @(negedge clk);
            d = i[3:0];
        end

        // Check mismatch stayed low (it should, since both regs get d)
        // Note: mismatch may be X initially because q1/q2 start as X.
        // After first clock edge, they will match.
        repeat (2) @(posedge clk);
        if (mismatch === 1'b1) begin
            $display("TEST FAILED: mismatch asserted: q1/q2 diverged.");
            $stop;
        end else begin
            $display("TEST PASSED: mismatch is not asserted after updates.");
        end

        $finish;
    end

endmodule

