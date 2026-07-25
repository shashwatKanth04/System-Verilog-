class packet;
    rand bit [7:0]addr;
    rand bit [7:0]data;
    constraint c1{addr inside{[10:20]};}
endclass 
module test;
    packet p=new();
    initial begin
        repeat(3)begin
            assert(p.randomize());
            $display("normal:addr=%0d,data=%0d",p.addr,p.data);
        end
        p.c1.constraint_mode(0);
        repeat(3)begin
            assert(p.randomize());
            $display("constraint OFF:addr=%0d,data=%0d",p.addr,p.data);
        end
        p.c1.constraint_mode(1);
        p.c1.rand_mode(0);
        repeat(3)begin
            assert(p.randomize());
            $display("Rand OFF for addr:addr=%0d,data=%0d",p.addr,p.data);
        end
        p.c1.rand_mode(1);
        repeat(3)begin
            assert(p.randomize());
            $display("Rand ON again: addr=%0d,data=%0d",p.addr,p.data);
        end
    end
endmodule

