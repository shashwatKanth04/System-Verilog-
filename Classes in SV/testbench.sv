module tb;
    logic clk;
    simple_if sif(clk);
    simple_driver drv;
    initial begin
        clk=0;
        forever #5 clk=~clk;
    end
    initial begin
        drv=new(sif);
        sif.grant=0;
        drv.drive();
        #20 sif.grant=1;
        $display("[%0t]testbench:grant asserted",$time);
        #50 $finish;
    end
endmodule
