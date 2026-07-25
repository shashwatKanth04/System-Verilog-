interface alu_intf;
    logic [7:0] a;
    logic [7:0] b;
    logic [2:0] op;     
    logic [7:0] result;
    logic carry_out;
    logic zero;
    logic clk;
    logic rst;
    modport alu_mp (input  a, b, op, clk, rst, output result, carry_out, zero);
endinterface
