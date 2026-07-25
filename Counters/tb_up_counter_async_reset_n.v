`timescale 1ns/1ps

module tb_up_counter_async_reset_n;

    parameter integer WIDTH = 4;

    reg clk;
    reg reset_n;
    wire [WIDTH-1:0] q;

    up_counter_async_reset_n #(.WIDTH(WIDTH)) dut (
        .clk(clk),
        .reset_n(reset_n),
        .q(q)
    );

    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    integer i;
    reg [WIDTH-1:0] expected;

    initial begin
        reset_n = 1'b0;
        repeat (2) @(posedge clk);
        if (q !== {WIDTH{1'b0}}) begin
            $display("FAIL reset expected 0 got %h", q);
            $stop;
        end

        reset_n = 1'b1;

        expected = {WIDTH{1'b0}};

        for (i = 0; i < 16; i = i + 1) begin
            @(posedge clk);
            expected = expected + {{(WIDTH-1){1'b0}},1'b1};
            if (q !== expected) begin
                $display("FAIL step %0d expected %h got %h", i, expected, q);
                $stop;
            end
        end

        @(negedge clk);
        reset_n = 1'b0;
        #1;
        if (q !== {WIDTH{1'b0}}) begin
            $display("FAIL async reset during cycle expected 0 got %h", q);
            $stop;
        end

        reset_n = 1'b1;
        expected = {WIDTH{1'b0}};
        @(posedge clk);
        expected = expected + {{(WIDTH-1){1'b0}},1'b1};
        if (q !== expected) begin
            $display("FAIL after release expected %h got %h", expected, q);
            $stop;
        end

        $display("PASS up counter");
        $finish;
    end

endmodule

