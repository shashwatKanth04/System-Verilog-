module string_p2;
    initial begin
        string s1="systemverilog";
        string s2="verilog";
        string s3="Hello";
        string s4="hello";
        string s5="";
        $display("Comparing two names: %d", s1.compare(s2));
        $display("Comparing two strings using icompare: %d", s3.icompare(s4));
        $display("Observing empty string: %0d",s5.substr(20,25)); 
    end
endmodule

