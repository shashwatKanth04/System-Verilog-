module inheri;
    class A;
        int i = 1;
        function int get_a();
            get_a = i;
        endfunction
    endclass


class B extends A;
    int j = 10;
    function
        get_b = j;
    endfunction
endclass

int x,y,z,zz;
B b;
initial begin
    b = new;
    x = b.j;
    z = b.get_a;
    zz = b.get_b;
end
endmodule