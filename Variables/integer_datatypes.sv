module integer_datatype;
    byte a;
    shortint b;
    int c;
    longint d;
    initial begin
        $monitor("a=%b, b=%b, c=%b d=%b",a,b,c,d);
        a='1;                                                   
        b='0;
        c='x;
        d='1;
        #10ns $finish;
    end
endmodule