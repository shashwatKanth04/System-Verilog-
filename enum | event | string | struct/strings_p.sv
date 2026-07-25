module strings_p;
    initial begin
        string s = "CDAC";
        string s1 = "";
        string s3,s4;
        int i;
        int j = s.len();
        $display("length of string is %0d", j);
        for(i = 0; i < j; i = i + 1)
            $display("%c", s.getc(i));           
        $display("First char: %c", s.getc(0));
        $display("Last char: %c", s.getc(j-1));
        $display("Empty string char: %0d", s1.getc(0)); 
        s.putc(0, "Y"); 
        $display("Modified string: %s", s); 
        s3 = s.toupper();
        s4 = s.tolower();
        $display("Uppercase: %s", s3);
        $display("Lowercase: %s", s4);
    end
endmodule