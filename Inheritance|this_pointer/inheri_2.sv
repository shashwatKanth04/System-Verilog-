module inheri_2;
    class A;
        int i = 1;
        function int get();
            get = i;
        endfunction
    endclass


class B extends A;
    int i = 10;
    function int get();
        get = i;
    endfunction
endclass

int x,y;
B b;
initial begin
    b = new;
    x = b.i;
    y = b.get();
    $display("x : %0d , y = %0d ", x, y);
end
endmodule