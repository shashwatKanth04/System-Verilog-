class packet;
    rand bit [3:0]addr;
    rand bit [3:0]data;
    constraint c2{if(addr==4) data==9;
else data==5;}
endclass
module test_conditional;
    packet p=new();
    initial begin
        $display("if else condition used");
        repeat(20)begin
            assert(p.randomize());
            $display("addr=%0d | data=%0d",p.addr,p.data);
        end
    end
endmodule
