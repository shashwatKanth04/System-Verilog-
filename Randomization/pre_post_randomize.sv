class XYpair;
    rand int x,y;
endclass
class myXYpair extends XYpair;
    function void pre_randomize();
        super.pre_randomize();
        x=100;
        $display("Pre randomize: forced x=%0d,y=%0d",x,y);
    endfunction
fucntion void post_randomize();
y=y*2;
$display("Post randomize:adjusted x=%0d,y=%0d",x,y);
endfunction
endclass
module test;
    initial begin
        myXYpair obj=new();
        repeat(5)begin
            if(obj.randomize())begin
                $display("final values:x=%0d,y=%0d\n",obj.x,obj.y);
            end
            else begin
                $display("Randomization failed");
            end
        end
    end
endmodule
