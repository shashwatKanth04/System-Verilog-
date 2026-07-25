module adder2;
    import contst_pkg::WIDTH;
    import contst_pkg::DEPTH;
    logic [WIDTH:0]a;
    logic [DEPTH:0]sum;
    logic [WIDTH:0]b;
    assign sum =a+b;
initial begin
    $monitor("a=%b b=%b sum=%b",a,b,sum);
    a='1;  
    b='0;
    #10ns $finish;
end

endmodule
