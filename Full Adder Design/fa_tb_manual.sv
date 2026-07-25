module fa_tb;
    reg [3:0]a,b;
    reg cin;
    wire [3:0]sum;
    wire carry;
    FA4 dut(a,b,cin,sum,carry);

    initial begin
          $monitor("time=%0t,A=%d,B=%d,cin=%d,sum=%d,carry=%d",$time,a,b,cin,sum,carry);
    a=0; b=0; cin=0;
   #5 a=0; b=0; cin=1;
   #5 a=0; b=1; cin=0;
   #5 a=0; b=1; cin=1;
   #5 a=1; b=0; cin=0;
   #5 a=1; b=0; cin=1;
   #5 a=1; b=1; cin=0;
   #5 a=1; b=1; cin=1;
       $finish;
    end
endmodule


     
     