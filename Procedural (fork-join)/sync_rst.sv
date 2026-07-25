module dff_sync_reset (
    input  logic clk,
    input  logic rst,  
    input  logic d,
    output logic q);
    always_ff @(posedge clk) begin
        if (rst) 
            q <= 1'b0; 
        else 
            q <= d;
    end

endmodule

module syncdff_tb;
    reg clk;
    reg rst;
    reg d;
    wire q;
    dff_sync_reset dut(clk,rst,d,q);
    initial begin
        clk=0;
        #10 rst=1;
        #10 rst=0;
        #10 d=1;
        #10 d=0;
    end
    always #5 clk=~clk;
endmodule
