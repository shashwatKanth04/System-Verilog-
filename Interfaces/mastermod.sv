module mastermod(signals.master a);
    always @(posedge a.clk or posedge a.rst) begin
        if(a.rst) begin
            a.request<=0;
            a.data<=0;
        end
        else begin
            a.request<=1;
            if(a.gnt)
               a.data<=a.data+1;
        end
    end
endmodule