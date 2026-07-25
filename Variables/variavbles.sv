
module bit_logic;
    bit [3:0]a;
    logic [3:0]b;
    initial begin
        $monitor("bit a=%b, logic b=%b",a,b);
        a='x;
        b='x;
        #5ns;
        a='z;b='z;
        #5ns $finish;
    end

endmodule