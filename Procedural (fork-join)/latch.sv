module latch(input logic latc, input logic enable, output logic latch_out);
    always_latch
    begin
        if(enable)begin
        latch_out=latc;
        end
    end
endmodule

module latch_tb;
    reg latch_in;
    reg enable;
    wire latch_out;
    latch dut(latch_in,enable,latch_out);
    initial begin
        enable=1;
        latch_in=1'b0;
        #5 enable=0;
        #5 enable=1;
        #10 latch_in=1'b1;
        #10;
    end
endmodule
