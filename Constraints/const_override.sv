class transaction;
rand bit [15:0]a;
constraint ab1{a>=16'd64;}
function void display(int iter);
        $display("Iteration %0d:rand a =%0d",iter,a);
endfunction
endclass

class new_trans extends transaction;
constraint ab1{a==16'd85;}
function void display(int iter);
        $display("Iteration %0d:rand a =%0d",iter,a);
endfunction
endclass

module test;
    initial begin
        new_trans obj =new();
        for(int i=0;i<20;i++)
        begin
            if(obj.randomize())
            begin
                obj.display(i);
            end
            else begin
                $display("Randomize failed at iteration %0d",i);
            end
        end
    end
endmodule