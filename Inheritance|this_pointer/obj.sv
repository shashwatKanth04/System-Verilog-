module obj;
class transaction;
    bit [1:0]data;
endclass

initial begin
    transaction t1;
    transaction t2;

    t1 = new;
    t1.data = 2'b10;
    t2 = new;
    t2 = t1;
    
    //t2 = new t1;
    $display("Before Change: t1.data = %b, t2.data = %b", t1.data, t2.data);
    t2.data = 2'b11;
    
    $display("After Change: t1.data  %b, t2.data = %b",t1.data,t2.data);
end
endmodule