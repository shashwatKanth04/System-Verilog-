`timescale 1ns/1ps

module up_counter_async_reset_n #(parameter integer WIDTH = 4) (
    input  clk,
    input  reset_n,
    output [WIDTH-1:0] q
);

    reg [WIDTH-1:0] count;

    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            count <= {WIDTH{1'b0}};
        end else begin
            count <= count + {{(WIDTH-1){1'b0}},1'b1};
        end
    end

    assign q = count;

endmodule

