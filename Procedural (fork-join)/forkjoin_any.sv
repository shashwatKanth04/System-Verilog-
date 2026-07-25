module test();
    initial begin
         $display("@%t: PT start",$time);
        #10 $display("@%t : PT with delay #10",$time);
        fork:thread
            #50 $display("@%t: CT1 with delay #50",$time);
            #10 $display("@%t : CT2 with delay #10",$time);
            begin
                #20 $display("@%t : CT3 with delay #20",$time);
                #20 $display("@%t : CT4 with delay #20",$time);
            end
        join_any
        $display("@%t: PT resumes",$time);
        #80 $display("@%t : PT with delay #80",$time);
    end
endmodule
