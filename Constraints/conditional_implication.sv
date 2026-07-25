class packet;
    rand bit [3:0]addr;
    rand bit [3:0]data;
    constraint c1{(addr==3)->{data==7};}
endclass
module test_conditional;
    packet p=new();
    initial begin
        $display("==implication used");
        repeat(20)begin
            assert(p.randomize());
            $display("addr=%0d | data=%0d",p.addr,p.data);
        end
    end
endmodule
