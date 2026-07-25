module tb_top;

    import mpb_tb_pkg::*;

    logic clk;
    logic reset;

    always#10 clk = ~clk;

    mpb_intf intf(.clk(clk), .reset(reset));
    mpb_master master_dut (.b_if(intf),.ext_addr(intf.addr),.ext_data(intf.data_in),.ext_rw(intf.rd_wr),.ext_valid(intf.req),.fifo_full());
    mpb_peripheral peripheral_dut (.b_if(intf));
    mpb_environment env;


    initial begin
        clk   = 1'b0;
        reset = 1'b1;
        #40;
        reset = 1'b0;
    end


    initial begin
        $display("[TB_TOP] Starting Simulation...");
        env = new(intf.master, intf.slave);
        env.build();        
        env.gen.loop_count = 1000;       
        env.run();        
        $display("[TB_TOP] Simulation Finished cleanly.");
        $finish;
    end
endmodule