interface simple_if(input logic clk);
    logic req,grant;
endinterface
class simple_driver;
    virtual simple_if vif;
    function new(virtual simple_if vif);
        this.vif=vif;
    endfunction
task drive();
    @(posedge vif.clk);
    vif.req<=1'b1;
    $display("[%0t]driver: request asserted",$time);
    @(posedge vif.clk);
    vif.req<=1'b0;
    $display("[%0t]driver:request deasserted",$time);
endtask
endclass

