package mpb_tb_pkg;

class mpb_transaction;
    rand bit [7:0] addr;
    rand bit [7:0] data_in;
    rand bit       rd_wr;   
    bit [7:0]      data_out;
    bit            error;
    bit            timeout; 

    constraint c_addr_distribution {
        addr dist {8'h00 := 40, 8'h01 := 20, 8'h02 := 40, [8'h03:8'hFF] := 10};
    }

    constraint c_read_only_status {
        if (addr == 8'h01) { rd_wr == 0; }
    }

    function new();
        this.data_out = 8'h00;
        this.error    = 1'b0;
        this.timeout  = 1'b0;
    endfunction

    virtual function string convert2string();
        return $sformatf("Type: %s | Addr: 8'h%0h | Data_In: 8'h%0h | Data_Out: 8'h%0h | Error: %0b | Timeout: %0b",
                         (rd_wr ? "WRITE" : "READ "), addr, data_in, data_out, error, timeout);
    endfunction

    virtual function void copy(mpb_transaction rhs);
        if (rhs == null) return;
        this.addr     = rhs.addr;
        this.data_in  = rhs.data_in;
        this.rd_wr    = rhs.rd_wr;
        this.data_out = rhs.data_out;
        this.error    = rhs.error;
        this.timeout  = rhs.timeout;
    endfunction
endclass

class mpb_generator;
    mailbox #(mpb_transaction) gen2drv_mbx;
    int loop_count;

    function new(mailbox #(mpb_transaction) mbx);
        this.gen2drv_mbx = mbx;
    endfunction

    task run();
        $display("[GENERATOR] Started at time %0t", $time);
        for (int i = 0; i < loop_count; i++) begin
            mpb_transaction tx = new();
            if (!tx.randomize()) begin
                $fatal("[GENERATOR_ERR] Randomization failed on loop index: %0d", i);
            end
            $display("[GENERATOR] Generating transaction %0d/%0d: %s", i+1, loop_count, tx.convert2string());
            gen2drv_mbx.put(tx);
        end
        $display("[GENERATOR] Completed sending all %0d transactions.", loop_count);
    endtask
endclass

class mpb_driver;
    virtual mpb_intf.master vif;
    mailbox #(mpb_transaction) gen2drv_mbx;

    function new(virtual mpb_intf.master vif, mailbox #(mpb_transaction) mbx);
        this.vif         = vif;
        this.gen2drv_mbx = mbx;
    endfunction

    task reset_signals();
        vif.addr    <= 8'h00;
        vif.data_in <= 8'h00;
        vif.rd_wr   <= 1'b0;
        vif.req     <= 1'b0;
    endtask

    task run();
        $display("[DRIVER] Started at time %0t", $time);
        reset_signals();
        wait(!vif.reset);
        @(posedge vif.clk);
        
        forever begin
            mpb_transaction tx;
            gen2drv_mbx.get(tx);
            
            vif.addr  <= tx.addr;
            vif.rd_wr <= tx.rd_wr;
            vif.data_in <= (tx.rd_wr) ? tx.data_in : 8'h00;
            vif.req   <= 1'b1; 
            
            @(posedge vif.clk);
            vif.req   <= 1'b0;

            fork 
                begin : wait_bus_done
                    fork
                        wait(vif.grant && vif.slave_ready);
                        begin
                            // Ensure we don't sample stale req == 0 immediately
                            @(posedge vif.clk);
                            wait(vif.grant == 0);
                        end
                    join_any
                    disable fork;
                end
            join
            @(posedge vif.clk);
        end
    endtask
endclass

class mpb_monitor;
    virtual mpb_intf.slave vif; 
    mpb_transaction tx;         
    mailbox #(mpb_transaction) mon2scb_mbx;

    covergroup mpb_bus_cg;
        RW_CP: coverpoint tx.rd_wr {
            bins READ  = {0};
            bins WRITE = {1};
        }
        addr_implicit : coverpoint tx.addr;
        data_in_implicit : coverpoint tx.data_in;
        RD_WR_TRANS_CP: coverpoint tx.rd_wr {
        bins read_to_write = (0 => 1); 
        bins write_to_read = (1 => 0); 
        bins consecutive_reads = (0 [* 2]); 
        bins consecutive_writes = (1 [* 2]); 
    }

    din_trans: coverpoint tx.data_in {
        bins zero_to_max   = (8'h00 => 8'hFF); 
        bins max_to_zero   = (8'hFF => 8'h00); 
        bins steps  = (8'h01 => 8'h02 => 8'h04 => 8'h08 => 8'h10 => 8'h20 => 8'h40 => 8'h80);
    }

    endgroup

    function new(virtual mpb_intf.slave vif, mailbox #(mpb_transaction) mbx);
        this.vif         = vif;
        this.mon2scb_mbx = mbx;
        this.mpb_bus_cg  = new();
    endfunction

    task run();
        $display("[MONITOR] Started at time %0t", $time);
        wait(!vif.reset);
        
        forever begin
            wait(vif.req === 1'b1);
            tx = new(); // Allocates to the class-level variable safely
            tx.addr  = vif.addr;
            tx.rd_wr = vif.rd_wr;
            if (tx.rd_wr) tx.data_in = vif.data_in; 
        
            fork
                begin : capture_bus_result
                    fork
                        begin
                            wait(vif.grant === 1'b1 && vif.slave_ready === 1'b1);
                            @(posedge vif.clk);
                            tx.data_out = vif.data_out;
                            tx.error    = vif.error;
                            tx.timeout  = 1'b0;
                        end
                        begin
                            wait(vif.req === 1'b0 && vif.grant === 1'b0);
                            tx.error    = 1'b0;
                            tx.timeout  = 1'b1;
                        end
                    join_any
                    disable fork; 
                end
            join
            
            mpb_bus_cg.sample(); // Manually sample valid transaction data
            $display("[MONITOR] Captured Transaction: %s", tx.convert2string());
            mon2scb_mbx.put(tx);
            @(posedge vif.clk);
        end
    endtask
endclass

class mpb_scoreboard;
    mailbox #(mpb_transaction) mon2scb_mbx;
    local bit [7:0] ref_DATA_REG;
    local bit [7:0] ref_STATUS_REG;
    local bit [7:0] ref_CONTROL_REG;
    int match_count, mismatch_count, timeout_count;

    function new(mailbox #(mpb_transaction) mbx);
        this.mon2scb_mbx    = mbx;
        this.ref_DATA_REG   = 8'h00;
        this.ref_STATUS_REG = 8'h00; 
        this.ref_CONTROL_REG= 8'h00;
    endfunction

    task run();
        forever begin
            mpb_transaction act_tx;
            bit [7:0] exp_data_out = 8'h00;
            bit       exp_error    = 1'b0;
            bit       mismatch     = 1'b0;
            
            mon2scb_mbx.get(act_tx);

            if (act_tx.timeout) begin
                timeout_count++;
                continue; 
            end
            
            if (act_tx.rd_wr) begin
                case (act_tx.addr)
                    8'h00: ref_DATA_REG    = act_tx.data_in;
                    8'h02: ref_CONTROL_REG = act_tx.data_in;
                    default: exp_error       = 1'b1; 
                endcase
            end else begin
                case (act_tx.addr)
                    8'h00: exp_data_out = ref_DATA_REG;
                    8'h01: exp_data_out = ref_STATUS_REG;
                    8'h02: exp_data_out = ref_CONTROL_REG;
                    default: exp_error    = 1'b1; 
                endcase
            end

            if (act_tx.error !== exp_error) mismatch = 1'b1;
            if (!act_tx.rd_wr && !exp_error && (act_tx.data_out !== exp_data_out)) mismatch = 1'b1;

            if (mismatch) mismatch_count++;
            else           match_count++;
        end
    endtask

    function void report_summary();
        $display("\n======================================================");
        $display("                 VERIFICATION REPORT                  ");
        $display("======================================================");
        $display(" Total Matches:      %0d", match_count);
        $display(" Total Mismatches:   %0d", mismatch_count);
        $display(" Total Timeouts:     %0d", timeout_count);
        $display(" STATUS:             %s", (mismatch_count == 0) ? "PASSED" : "FAILED");
        $display("======================================================\n");
    endfunction
endclass

class mpb_environment;
    mpb_generator  gen;
    mpb_driver     drv;
    mpb_monitor    mon;
    mpb_scoreboard scb;

    mailbox #(mpb_transaction) gen2drv_mbx;
    mailbox #(mpb_transaction) mon2scb_mbx;

    virtual mpb_intf.master mst_vif;
    virtual mpb_intf.slave  slv_vif;

    function new(virtual mpb_intf.master mst_vif, virtual mpb_intf.slave slv_vif);
        this.mst_vif = mst_vif;
        this.slv_vif = slv_vif;
    endfunction

    function void build();
        gen2drv_mbx = new(1);
        mon2scb_mbx = new();         
        gen = new(gen2drv_mbx);
        drv = new(mst_vif, gen2drv_mbx);
        mon = new(slv_vif, mon2scb_mbx);
        scb = new(mon2scb_mbx);
    endfunction

    task run();
        $display("[ENVIRONMENT] Run phase started.");
        fork
            gen.run();
            drv.run();
            mon.run();
            scb.run();
        join_any
        #100ns; 
        disable fork; // Clean termination of parallel threads
        $display("[ENVIRONMENT] Run phase finished.");
        scb.report_summary();
    endtask
endclass

endpackage : mpb_tb_pkg