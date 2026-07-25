`timescale 1ns/1ps

module johnson_counter_async_reset_n #(parameter integer WIDTH = 4) (
    input  clk,
    input  reset_n,
    output [WIDTH-1:0] q
);

    reg [WIDTH-1:0] state;

    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            state <= {WIDTH{1'b0}};
        end else begin
            state <= {~state[WIDTH-1], state[WIDTH-1:1]};
        end
    end

    assign q = state;

endmodule

