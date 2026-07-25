module four_bit_counter (
    input  logic        clk,
    input  logic        rst,          // asynchronous reset
    input  logic        load_en,     // synchronous load enable
    input  logic [3:0]  load_data,   // value to load
    output logic [3:0]  count
);

    // Asynchronous reset (active-high)
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            count <= 4'b0000;
        end else begin
            if (load_en) begin
                count <= load_data;
            end else begin
                count <= count + 4'b0001; // wraps around naturally (mod 16)
            end
        end
    end

endmodule

