module tb;
    bit clk;
    bit rst;
    bit [3:0] val;

    initial begin
        clk=0;
        forever # clk=~clk;
    end

    initial begin
        rst=1;
        val=0;
        #12;
        rst=0;

        repeat (20) begin
            @(negedge clk);
            val=$urandom_range(0,15);
            $display("%0t | val=%0d",$time,val);
        end
        #20;
        $finish;
    end

    covergroup cg @(posedge clk);
        option.auto_bin_max=4;

        cp_implicit : coverpoint val;
        cp_scalar : coverpoint val
        {
            bins sca={0,3,4,6,7};
        }
        cp_vector : coverpoint val
        {
            bins vec[]={1,2,5};
        }
        cp_fixed : coverpoint val
        {
            bins fixed[4]={[1:10],1,4,7};
        }
        cp_default : coverpoint val
        {
            bins a[]={0,1,2,3};
            bind d=default;
        }
        cp_guard : coverpoint val iff {!rst};
    endgroup

    cg cov=new();
endmodule