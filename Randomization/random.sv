class randomvar;
    rand bit [3:0] a;
    randc bit [3:0]b;
    function void display(int iter);
        $display("Iteration %0d:rand a =%0d randc b=%0d",iter,a,b);
    endfunction
endclass
module test;
    initial begin
        randomvar obj =new();
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