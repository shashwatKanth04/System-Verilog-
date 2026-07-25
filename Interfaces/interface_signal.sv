interface signals(input logic clk, input logic rst);
    logic request;
    logic gnt;
    logic [7:0] data;
    logic ack;
    modport master(input clk,rst,output request,data, input gnt,ack);
    modport slave(input clk,rst,request,data, output gnt,ack);
endinterface :signals
