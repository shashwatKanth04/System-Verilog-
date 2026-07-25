`timescale 1ns/1ps

module tb_johnson_counter_async_reset_n;

    parameter integer WIDTH = 4;

    reg clk;
    reg reset_n;
    wire [WIDTH-1:0] q;

    johnson_counter_async_reset_n #(.WIDTH(WIDTH)) dut (
        .clk(clk),
        .reset_n(reset_n),
        .q(q)
    );

    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    function [WIDTH-1:0] next_johnson;
        input [WIDTH-1:0] s;
        begin
            next_johnson = {~s[WIDTH-1], s[WIDTH-1:1]};
        end
    endfunction

    reg [WIDTH-1:0] expected;

    initial begin
        reset_n = 1'b0;
        repeat (2) @(posedge clk);
        if (q !== {WIDTH{1'b0}}) begin
            $display("FAIL reset expected 0 got %h", q);
            $stop;
        end

        reset_n = 1'b1;
        repeat (16) @(posedge clk);

        expected = {WIDTH{1'b0}};

        reset_n = 1'b0;
        @(negedge clk);
        #1;
        if (q !== {WIDTH{1'b0}}) begin
            $display("FAIL async reset during cycle expected 0 got %h", q);
            $stop;
        end
        reset_n = 1'b1;

        repeat (2) @(posedge clk);

        expected = next_johnson({WIDTH{1'b0}});
        if (q !== expected) begin
            $display("FAIL first step expected %h got %h", expected, q);
            $stop;
        end

        repeat (WIDTH*2-1) begin
            @(posedge clk);
            expected = next_johnson(expected);
            if (q !== expected) begin
                $display("FAIL expected %h got %h", expected, q);
                $stop;
            end
        end

        $display("PASS johnson counter");
        $finish;
    end

endmodule

