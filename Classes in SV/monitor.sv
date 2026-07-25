class alu_read_bfm;
    virtual alu_if vif;
    alu_trns trans;
    mailbox #(alu_trans)mon2sb;
    function nwe(virtual alu_if vif, mailbox #(alu_trans)mon2sb);
        this.vif=vif;
        this.mon2sb=mon2sb;
    endfunction
    virtual task run();
        forever begin
            @(posedge vif.clk);
            if(vif.valid)begin
                trans=new();
                trans.result=vif.result;
                trans.trans_id=alu_tran::id++;
                mon2sb.put(trans);
                $display("[%0t] read bfm:captured ID=%0d result=%0d",$time,transactions_id,trans.result);
            end
        end 
    endtask
endclass