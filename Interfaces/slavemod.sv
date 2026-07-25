module slavemod(signals.slave b);
    always @(posedge b.clk or posedge b.rst) begin
        if(b.rst) begin
            b.gnt<=0;
            b.ack<=0;
        end
        else begin
            if(b.request) begin
                b.gnt<=1;
                b.ack<=1;
            end
            else begin
                b.gnt<=0;
                b.ack<=0;
            end
        end
    end
endmodule