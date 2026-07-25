interface signals(input clk, input rst);
    logic req;
    logic [7:0]addr;
    logic [7:0]din;
    logic wr_rd;
    logic gnt;
    logic [7:0]dout;
    logic slave_ready;
    modport master(output req,addr,din,wr_rd, input gnt,dout,slave_ready);
    modport slave(input req,addr,din,wr_rd, output gnt,dout,slave_ready);
endinterface