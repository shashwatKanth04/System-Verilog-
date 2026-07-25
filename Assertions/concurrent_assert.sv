module sva_simple_lab;
    logic clk, req, ack;
    logic [3:0] a, b;
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    initial begin
        req = 0; ack = 0;
        a = 0; b = 0;
        // PASS
        #12 req = 1;
        #10 ack = 1;
        #10 req = 0; ack = 0;
        // FAIL
        #20 req = 1;
        #30 ack = 1;
        // a,b checks
        #10 a = 5; b = 2;   // PASS
        #10 a = 1; b = 4;   // FAIL
        #50 $finish;
    end

    property a_gt_b;
        @(posedge clk)
        disable iff ($time < 85)
        (a > b);
    endproperty
    assert property (a_gt_b)
        else  $error("%m: a <= b at %0t a=%0d b=%0d",$time, a, b);
    sequence req_to_ack_seq;
        $rose(req) ##[1:2] $rose(ack);
    endsequence
    property req_ack_property;
        @(posedge clk) req_to_ack_seq;
    endproperty
    assert property (req_ack_property)
        else    $error("%m: ack missing within 2 cycles at %0t",$time);
    property combined_property;
        @(posedge clk)
        disable iff ($time < 85)
        (a > b) and (req |-> ack);
    endproperty
    assert property (combined_property)
        else   $error("%m: combined property failed at %0t",$time);
endmodule
