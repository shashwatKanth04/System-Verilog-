module top(input logic clk, input logic rst,
           input logic [7:0] ext_addr, input logic [7:0] ext_data,
           input logic ext_rw, input logic ext_valid);

    // Interface instantiation
    signals sig(clk, rst);

    // Master instantiation
    mastermod m1 (
        .a(sig.master),
        .clk(clk),
        .rst(rst),
        .ext_addr(ext_addr),
        .ext_data(ext_data),
        .ext_rw(ext_rw),
        .ext_valid(ext_valid)
    );

    // Slave instantiation
    slavemod s1 (
        .a(sig.slave),
        .clk(clk),
        .rst(rst)
    );
endmodule