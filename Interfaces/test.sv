module test;
    logic clk=0;
    logic rst;

    signals s1(clk,rst);
    mastermod m1(s1);
    slavemod m2(s1);

    initial begin
        rst=1;
        #10 rst=0;
        #200 $display("Sim done");
        $finish;
    end

    always #5 clk=~clk;

endmodule