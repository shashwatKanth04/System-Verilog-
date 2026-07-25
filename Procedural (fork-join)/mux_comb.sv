module mux41(input logic [3:0]i,input logic [1:0]sel, output logic out);
    always_comb
    begin
        case(sel)
        2'b00: out=i[0];
        2'b01: out=i[1];
        2'b10: out=i[2];
        2'b11: out=i[3];
        default: out=1'b0;
        endcase
    end
endmodule

module mux41_tb;
   reg [3:0]i;
    reg [1:0]sel;
    wire out;

    mux41 dut(i,sel,out);
    initial begin
        $monitor("time=%0d | sel=%0d | i=%0d | out=%0d",$time,sel,i,out);
        i=4'b1010;
        sel=2'b00;
       #10 sel=2'b01;
       #10 sel=2'b10;
       #10 sel=2'b11;
       #10 $finish;
    end
endmodule

