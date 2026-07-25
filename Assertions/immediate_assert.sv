module immediate_assertion_lab;
    logic clk;
    logic rd, wr;
    logic [3:0] a, b;
    // Assertion status flags
    logic rd_wr_assert_status;
    logic a_b_assert_status;
    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10 time units period
    end
    // Stimulus
    initial begin
        rd = 0; wr = 0;
        a = 0; b = 0;
        // Case 1: PASS
        #10 rd = 1; wr = 0;
        #10 rd = 0; wr = 1;
        // Case 2: FAIL
        #10 rd = 1; wr = 1;
        // Case 3: PASS
        #10 a = 5; b = 2;
        // Case 4: FAIL
        #10 a = 1; b = 4;
        #20 $finish;
    end
    //---------------------------------------------------------
    // Immediate assertion: rd and wr should not be high together
    //---------------------------------------------------------
    always @(posedge clk) begin
        // Update status flag
        rd_wr_assert_status = !(rd & wr);
        assert (rd_wr_assert_status)
        $display("%m: PASS (rd/wr) at time %0t, rd=%0b wr=%0b",
        $time, rd, wr);
        else
        $error("%m: FAIL (rd/wr) at time %0t, rd=%0b wr=%0b",
        $time, rd, wr);
    end
    //---------------------------------------------------------
    // Immediate assertion: a should be greater than b
    //---------------------------------------------------------
    always @(posedge clk) begin
        // Start checking only after a and b are assigned test values
        if ($time >= 45) begin
            // Update status flag
            a_b_assert_status = (a > b);
            assertion1 : assert (a_b_assert_status)
            $display("%m: PASS (a>b) at time %0t, a=%0d, b=%0d",
            $time, a, b);
            else
            $error("%m: FAIL (a>b) at time %0t, a=%0d, b=%0d",
            $time, a, b);
        end
    end
endmodule
