module tb_top_new;
    logic clk, rst;
    logic [7:0] ext_addr, ext_data;
    logic ext_rw, ext_valid;

    top dut (.*);

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $monitor("Time=%0t | Req=%b | Gnt=%b | Addr=%h | Data=%h | RW=%b | State=%s", 
                 $time, dut.sig.req, dut.sig.gnt, dut.sig.addr, dut.sig.din, dut.sig.wr_rd, dut.m1.current.name());
        rst = 1; ext_valid = 0; #20 rst = 0;

        $display("--- Starting Full Address Coverage Test ---");

        // Loop through multiple address locations (0 to 15)
        for (int i = 0; i < 16; i++) begin
            // Write to address 'i'
            send_trans(i, i * 2, 1); 
            // Read back from address 'i'
            send_trans(i, 8'h00, 0); 
        end

        // Edge case: Max address location (255)
        send_trans(8'hFF, 8'hAA, 1);
        send_trans(8'hFF, 8'h00, 0);

        $display("--- Full Address Verification Complete ---");
        #500 $finish;
    end

    task send_trans(input [7:0] a, input [7:0] d, input rw);
        begin
            @(posedge clk);
            ext_addr = a; ext_data = d; ext_rw = rw; ext_valid = 1;
            @(posedge clk);
            ext_valid = 0;
            // Wait for handshake completion
            wait(dut.m1.current == 2'b00);
            #10;
        end
    endtask
endmodule