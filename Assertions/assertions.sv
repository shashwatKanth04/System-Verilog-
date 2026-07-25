module sva_sysfunc_demo;
    logic clk, A, B;
    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    // Stimulus
    initial begin
        A = 0; B = 1;
        #12 A = 1;          // rise A
        #10 B = 0;          // fall B
        #10;                // keep A stable
        #20 $finish;
    end
    // $sampled
    property p_sampled;
        @(posedge clk) $sampled(A);
    endproperty
    cover property (p_sampled);

    
    //------------------------------------------------
    // $rose
    property p_rose;
        @(posedge clk) $rose(A);
    endproperty
    cover property (p_rose);
    // $fell
    property p_fell;
        @(posedge clk) $fell(B);
    endproperty
    cover property (p_fell);
    // $stable
    property p_stable;
        @(posedge clk) $stable(A);
    endproperty
    cover property (p_stable);
    // ---------$past -------
    property p_past;
        @(posedge clk)
        ($past(A) == 0 && A == 1);
    endproperty
    cover property (p_past);
endmodule
