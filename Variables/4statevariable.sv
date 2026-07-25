module four_state;
    logic a;
    integer b;
    reg [7:0]sum;
    initial begin
        $display("4 state variavble");
        $write("logic a=%b ,reg sum=%b, integer b=%b",a,sum,b);
        a='1;
        b='0;
        sum='1;
        #5ns $monitor(" logic a=%b ,reg sum=%b, integer b=%b",a,sum,b);
        #5ns $finish;
    end
endmodule