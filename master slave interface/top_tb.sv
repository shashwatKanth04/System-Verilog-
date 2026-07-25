module tb_top_complete;
    logic clk, rst;
    logic [7:0] ext_addr, ext_data;
    logic ext_rw, ext_valid;

    // Instantiate Top
    top dut (.*);

    initial clk = 0;
    always #5 clk = ~clk;

    // Monitor: Tracking both External Input (ext_rw) and Interface Output (wr_rd)
    initial begin
        $monitor("Time=%0t | ExtRW=%b | IntRW=%b | Req=%b | Gnt=%b | Addr=%h | State=%s", 
                 $time, ext_rw, dut.sig.wr_rd, dut.sig.req, dut.sig.gnt, dut.sig.addr, dut.m1.current.name());
    end

    initial begin
        rst = 1; ext_valid = 0; #20 rst = 0;
        $display("--- Starting Verification ---");

        // 1. Write Test (ext_rw = 1)
        $display("--- Testing Write ---");
        send_trans(8'hA1, 8'hFF, 1);

        // 2. Read Test (ext_rw = 0)
        $display("--- Testing Read ---");
        send_trans(8'hA1, 8'h00, 0);

        // 3. Back-to-Back Mixed
        $display("--- Testing Mixed Back-to-Back ---");
        send_trans(8'h02, 8'h11, 1);
        send_trans(8'h02, 8'h00, 0);

        $display("--- Verification Complete ---");
        #50 $finish;
    end

    task send_trans(input [7:0] a, input [7:0] d, input rw);
        begin
            @(posedge clk);
            ext_addr  = a;
            ext_data  = d;
            ext_rw    = rw; // This is the input to your Master
            ext_valid = 1;
            @(posedge clk);
            ext_valid = 0;
            // Wait for completion
            wait(dut.m1.current == 2'b00); 
            #10;
        end
    endtask
endmodule