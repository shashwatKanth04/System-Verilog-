class packet;
    rand bit [3:0]addr;
    integer i;
    constraint c1{addr inside{3,7,[11:15]};}
endclass
module test_inside;
    packet p=new();
    initial begin
        for(i=0;i<16;i++) begin
            assert(p.randomize());
            $display("iteration %0d:addr=%0d",i,p.addr);
        end
    end
endmodule
