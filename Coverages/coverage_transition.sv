module coverage_trans;
    bit clk;
    always #5 clk=~clk;
    
    class test;
        rand bit[3:0]addr;
        covergroup cg @(posedge clk);
            cp_addr : coverpoint addr
            {
                bins fixed_trans=(1=>2);
                bins multi_fixed=(1=>2=>3);
                bins range_trans=(1=>[4:6]);
                bins repeat5=(3[*5]);
                bins repeat3to5=(3[*3:5]);
                bins goto5=(7[->5]);
                bins non_consecutive5=(8[=5]);
            }
        endgroup
        function new();
            cg=new();
        endfunction
    endclass

    initial begin
        test t=new();
        clk=0;
        @(negedge clk) t.addr=1;
        @(negedge clk) t.addr=2;

        @(negedge clk) t.addr=1;
        @(negedge clk) t.addr=2;
        @(negedge clk) t.addr=3;

        @(negedge clk) t.addr=1;
        @(negedge clk) t.addr=5;

        repeat(5) begin
            @(negedge clk) t.addr=3;
        end

        repeat(4) begin
            @(negedge clk) t.addr=3;
        end

        @(negedge clk) t.addr=7;
        @(negedge clk) t.addr=1;
        @(negedge clk) t.addr=7;
        @(negedge clk) t.addr=2;
        @(negedge clk) t.addr=7;
        @(negedge clk) t.addr=3;
        @(negedge clk) t.addr=7;
        @(negedge clk) t.addr=4;
        @(negedge clk) t.addr=7;

        @(negedge clk) t.addr=8;
        @(negedge clk) t.addr=1;
        @(negedge clk) t.addr=8;
        @(negedge clk) t.addr=2;
        @(negedge clk) t.addr=8;
        @(negedge clk) t.addr=3;
        @(negedge clk) t.addr=8;
        @(negedge clk) t.addr=4;
        @(negedge clk) t.addr=8;

        #20;
        $finish;
    end
endmodule

