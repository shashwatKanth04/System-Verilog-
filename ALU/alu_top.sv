module top;
    import alu_tb_pkg::*;
    
    // Declare clock and reset signals
    logic clk;
    logic rst;
    
    // Instantiate interface & DUT
    alu_intf intf();
    alu dut (.io(intf.alu_mp), .clk(clk), .rst(rst)); 
    
    // Clock generation logic (Period = 10ns)
    initial clk = 0;
    always #5 clk = ~clk;
    
    // Initialize the DUT using an asynchronous-style active-high reset
    initial begin
        rst = 1; // Assert reset
        #20;     // Hold reset for 20ns
        rst = 0; // Deassert reset 
    end
    
    // Scoreboard Checker Task 
    task automatic check_output(alu_trans t);
        reg [7:0] expected_res;
        reg expected_carry; 
        reg expected_zero; 
        reg [8:0] tmp; 
    
        case (t.op)
            ADD: begin 
                tmp            = t.a + t.b; 
                expected_res   = tmp[7:0];
                expected_carry = tmp[8];
            end
            SUB: begin 
                tmp            = t.a - t.b;
                expected_res   = tmp[7:0];
                expected_carry = tmp[8];
            end
            AND:  expected_res = t.a & t.b;   
            OR:   expected_res = t.a | t.b;   
            XOR:  expected_res = t.a ^ t.b;   
            NAND: expected_res = ~(t.a & t.b); 
            LSL:  expected_res = t.a << 1;       
            LSR:  expected_res = t.a >> 1;       
            default: expected_res = 8'b0;
        endcase 
        
        // Logical operations clear the carry flag
        if (t.op > SUB) begin
            expected_carry = 1'b0;
        end
        expected_zero = (expected_res == 8'b0);

        // Check outputs against the physical interface
        if (intf.result !== expected_res || intf.carry_out !== expected_carry || intf.zero !== expected_zero) begin
            $display("ERROR: opcode=%s a=%0d b=%0d | DUT_res=%0d Exp_res=%0d | DUT_cy=%0b Exp_cy=%0b", 
                     t.op.name(), t.a, t.b, intf.result, expected_res, intf.carry_out, expected_carry); 
        end else begin
            $display("PASS: opcode=%s a=%0d b=%0d result=%0d carry=%0b zero=%0b", 
                     t.op.name(), t.a, t.b, intf.result, intf.carry_out, intf.zero);
        end
    endtask

    // Driver: Drives transactions relative to the clk edge
    task automatic run_test(string name, alu_trans t);
        $display("=== Running test: %s ===", name);
        repeat (10) begin
            @(posedge clk); // Synchronize to edge before injecting stimulus
            assert(t.randomize()); 
            
            intf.a  <= t.a; 
            intf.b  <= t.b;
            intf.op <= t.op.first();
            
            @(posedge clk); // Wait exactly 1 clock cycle for the sequential ALU to process inputs 
            #1;             // Minor step offset to avoid sampling race bugs
            check_output(t); // Call scoreboard
        end
    endtask

    // Basic Random Test Entry Point
    task automatic basic_random();
        alu_trans t = new();
        run_test("basic_random", t); 
    endtask

    initial begin
        @(negedge rst);  // Wait until active-high reset drops 
        @(posedge clk);  // Align safely with active clock edge 
        basic_random();  // Execute test sequence 
        $finish;         // Terminate simulation safely
    end

endmodule
