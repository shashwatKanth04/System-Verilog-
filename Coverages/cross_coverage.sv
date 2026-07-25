module cross_cov;
    bit clk;
    always #5 clk=~clk;

    class test;
        rand bit [1:0]a;
        rand bit [3:0]b;
        rand bit c;

        covergroup cg_grp @(posedge clk);
            B : coverpoint b
            {
                bins b1={[9:12]};
                bins b2={[13:15]};
                bins restofb[]=default;
            }
            C : coverpoint c;
            aXBXC : cross a,B,C;
        endgroup

        function new();
            cg_grp cg=new();
        endfunction

    endclass

    initial begin
        test t=new();
        clk=0;
        repeat(50) begin
            void`(t.randomize());
            @(posedge clk);
            $display("a=%0d b=%0d c=%0d",t.a,t.b,t.c);
        end

        $display("Simulation completed");
        $finish;
    end
endmodule