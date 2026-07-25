class packet;rand bit [3:0]addr;
endclass
module test;
    packet p=new();
    initial begin
        repeat(5)begin
            assert(p.randomize());
            $display("addr=%0d",p.addr);
        end
        repeat(5)begin
            assert(p.randomize() with{addr inside{[10:12]};});
            $display("addr inline constraint=%0d",p.addr);
        end
    end
endmodule
