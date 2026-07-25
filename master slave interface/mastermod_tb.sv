module tb_master;
    logic clk;
    logic rst;
    logic [7:0] ext_addr;
    logic [7:0] ext_data;
    logic ext_rw;
    logic ext_valid;

    signals sig(clk, rst);

    mastermod dut (
        .a(sig.master),
        .clk(clk),
        .rst(rst),
        .ext_addr(ext_addr),
        .ext_data(ext_data),
        .ext_rw(ext_rw),
        .ext_valid(ext_valid)
    );


    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
    $monitor("Time=%0t | REQ=%b | ADDR=%h | DIN=%h | WR_RD=%b | GNT=%b | DOUT=%h", $time, sig.req, sig.addr, sig.din,sig.wr_rd, sig.gnt, sig.dout);
        rst = 1;
        ext_valid = 0;
        #20 rst = 0;
        
        @(posedge clk);
        ext_addr  = 8'hA1;
        ext_data  = 8'h55;
        ext_rw    = 1;
        ext_valid = 1;
        @(posedge clk);
        ext_valid = 0;
        wait(dut.current == 2'b00); 

        @(posedge clk);
        ext_addr  = 8'hB2;
        ext_rw    = 0;
        ext_valid = 1;
        @(posedge clk);
        ext_valid = 0;
        wait(dut.current == 2'b00);

        #50 $finish;
    end
    
    always @(posedge clk) begin
        sig.gnt <= sig.req; 
    end
endmodule