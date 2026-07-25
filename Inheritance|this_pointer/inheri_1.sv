module inheri;
    class A;
        int i = 1;
        function int get_a();
            get_a = i;
        endfunction
    endclass
class B extends A;
    int j = 10;
    function int get_b();
        get_b = j;
    endfunction
endclass

class C extends B;
    int z = 100;
    function int get_c();
        get_c = z;
    endfunction
endclass

class D extends C;
        int p= 20;
        function int get_d();
            get_d = p;
        endfunction
endclass
int x,y,z,zz,zzz,w;
B b;
C c;
D d;
initial begin
    b = new;
    c = new;
    d = new;
    x = b.i;
    y = b.j;
    z = b.get_a;
    zz = b.get_b;
    zzz = c.get_c;
    w = d.get_a;
    $display("x : %0d, y = %0d, z = %0d, zz = %0d,zzz = %0d,d = %0d",x, y, z, zz,zzz,d);
end

endmodule