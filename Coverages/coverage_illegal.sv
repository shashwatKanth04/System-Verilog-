module illegal_cov;
    // Covergroup
    covergroup cg @(posedge clk);

        cp_addr: coverpoint addr {

        // Normal bins
        bins low_range = {[0:3]};
        bins high_range = {[4:7]};

        // Values 8 and 9 are ignored
        ignore_bins ign_vals = {8, 9};

        // Values 10 and 11 are illegal
        illegal_bins bad_vals = {10, 11};
        }

    endgroup

    initial begin
        cg c1=new();
        clk = 0;
        // Apply test values
        repeat (12) begin
        @(negedge clk);
        case ($time)
        // Normal bins
        10 : addr = 1;
        20 : addr = 2;
        30 : addr = 5;
        40 : addr = 6;
        // Ignore bins
        50 : addr = 8;
        60 : addr = 9;
        // Illegal bins
        70 : addr = 10;
        80 : addr = 11;
        // More legal values
        90 : addr = 3;
        100 : addr = 7;
        default : addr = 0;
        endcase
        $display("Time=%0t addr=%0d", $time, addr);
        end
        #20;
        $display("\nSimulation completed.");
        $finish;
    end
endmodule