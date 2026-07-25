class alu_driver_bfm;
    virtual alu_if vif;
    alu_transtrans;
    mailbox #(alu_trans)gen2drv;
    function new(virtual alu_if vif,mailbox #(alu_trans)gen2drv);
        this.vif=vif;
        this.gen2drv=gen2drv;
    endfunction

virtual task driver();
    @(posedge vif.clk);
    vif.a<=trans a;
    vif.b<=trans b;
    vif.op<=trans.op;
    vif.valid<=1'b1;
    $display("[%0t] driver:applied ID=%0d a=%0d b=%0d op=%0d",$time,trans.trans_id,trans.a,trans.b,trans.op);
    @(posedge vif.clk);
    vif.valid<=1'b0;
endtask
virtual task run();
    fork
        forvever begin 
            gen2drv.get(trans);
            drive();
        end
    join_none
endtask
endclass
