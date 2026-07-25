module four_bit_counter_reset_synchronizer (
    input  logic       clk,
    input  logic       rst,
    output logic [3:0] count
);

    logic rst_sync1;
    logic rst_sync2;

    always_ff @(posedge clk) begin
        rst_sync1 <= rst;
        rst_sync2 <= rst_sync1;
    end

    always_ff @(posedge clk) begin
        if (rst_sync2) begin
            count <= 4'b0000;
        end else begin
            count <= count + 4'b0001;
        end
    end

endmodule

