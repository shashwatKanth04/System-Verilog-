module array;
    bit [4:0]a;
    bit b[7:0];
    initial begin
        a=8'b0;
        b[3]=1'b1;
        b[0]=1'b1;
        $display("a=%b | b=%b | b=%b",a,b[3],b[0]);
    end
endmodule
