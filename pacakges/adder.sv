module adder;
    logic [contst_pkg::WIDTH:0]a;
    logic [contst_pkg::WIDTH:0]b;
    logic [contst_pkg::DEPTH:0]sum;
    assign sum=a+b;
    initial begin
        $monitor("a=%b, b=%b, sum=%b",a,b,sum);
        a='1;
        b='1;
        #10ns $finish;
    end
endmodule

