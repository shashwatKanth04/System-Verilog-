module slavemod(
    signals.slave a,
    input logic clk,
    input logic rst
);
    logic [7:0] memory [0:255]; 

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            a.gnt <= 0;
            a.dout <= 8'b0;
        end else begin
            if (a.req) begin
                a.gnt <= 1;
                if (a.wr_rd) begin
                    memory[a.addr] <= a.din;
                end 
                else if (!a.wr_rd) begin
                    a.dout <= memory[a.addr];
                end
            end 
            else begin
                a.gnt <= 0;
            end
        end
    end
endmodule