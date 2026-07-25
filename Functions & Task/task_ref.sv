module tb_fun;

task automatic swap(int a, int b);
    int temp=a;
    a=b;
    b=temp;
endtask

initial begin
int a=5,b=10;
swap(a,b);


$display("the value of a is: %0d",a);
$display("the value of b is: %0d",b);
end
endmodule




  

