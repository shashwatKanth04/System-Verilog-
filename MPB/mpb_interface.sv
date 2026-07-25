interface mpb_intf(input clk, input reset);
    logic req;
    logic [7:0]addr;
    logic [7:0]data_in;   
    logic rd_wr;     
    logic grant;
    logic [7:0]data_out;  
    logic error;
    logic slave_ready;

    modport master(input clk, reset,output req, addr, data_in, rd_wr,input grant, data_out, error, slave_ready);
    modport slave(input clk, reset,input req, addr, data_in, rd_wr,output grant, data_out, error, slave_ready);
endinterface