module inheri_3;
class A;
    int i =1;
    function int get_a();
        get_a = i;
    endfunction
endclass

class B extends A;
    int j =10;
    function int get_b();
        get_b = j;
    endfunction
endclass

int x,y,z,zz,m,n,o,p;
A a;
B b;
initial begin
    a=new;

    b=new;
    a=b;
    x = b.j;
    y = b.j;
    z = b.get_a;
    zz = b.get_b;

    m = a.i;
    //n = a.j;
    o = a.get_a;
    //p = a.get_b;
    //b=a;
    $display("a = %0d,x = %0d,y = %0d,z = %0d,zz = %0d,m = %0d,n = %0d, o = %0d, p = %0d, b = %0d ",a,x,y,z,zz,m,n,o,p,b);
end
endmodule