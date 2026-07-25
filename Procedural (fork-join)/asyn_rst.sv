module dff_async_reset (
    input  logic clk,
    input  logic rst, 
    input  logic d,
    output logic q
);
    always_ff @(posedge clk or posedge rst) begin
        if (rst) 
            q <= 1'b0; 
        else 
            q <= d;
    end

endmodule

module dff_tb;
    reg clk;
    reg rst;
    reg d;
    wire q;
    dff_async_reset dut(clk,rst,d,q);
    initial begin
        clk=0;
        #10 rst=1;
        #10 rst=0;
        #10 d=1;
        #10 d=0;
    end
    always #5 clk=~clk;
endmodule
