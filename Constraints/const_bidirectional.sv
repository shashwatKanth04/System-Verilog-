class packet;
rand bit[3:0]addr;
rand bit [3:0] data;
cosntraint equal{addr==data;}
constraint sum{addr+data==10;}
endclass

module test;
    packet p=new();
    initial begin 
        $display("==bidirectional contraints demo==");
        repeat(16)begin
            assert(p.randomize());
            $display("addr=%0d,data=%0d",p.addr,p.data);
        end
    end
endmodule
