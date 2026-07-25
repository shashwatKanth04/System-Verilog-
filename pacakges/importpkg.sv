import contst_pkg::*;
module adder_1;
    logic [WIDTH:0]a;
    logic [WIDTH:0]b;
    logic [DEPTH:0]sum;
    assign sum=a+b;
    initial begin
        $monitor("a=%b, b=%b, sum=%b",a,b,sum);
        a='1;
        b='0;
        #10ns $finish;
    end
endmodule