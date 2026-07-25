module top;
    import alu_tb_pkg::*;
    alu_intf alu_if_inst();
    alu dut (.io(alu_if_inst));

    always #5 alu_if_inst.clk = ~alu_if_inst.clk;

    initial begin
        alu_if_inst.clk   = 1'b0;
        alu_if_inst.rst = 1'b0;
        #20; 
        alu_if_inst.rst = 1'b1;
    end
 
    //BASIC_RANDOM

    task automatic run_test(string name, alu_trans tr);
        $display("=== Running test: %s ===", name);
        repeat (10) begin
            assert(tr.randomize());
            alu_if_inst.a      = tr.a;
            alu_if_inst.b      = tr.b;
            alu_if_inst.op = tr.op;
            @(posedge alu_if_inst.clk); 
            check_output(tr); 
        end
    endtask


    task automatic basic_random();
        alu_trans tr = new();
        run_test("basic_random", tr);
    endtask

    //ADD_TEST

    task automatic run_test_add(string name, alu_trans tr);
        alu_trans t;
        $display("=== Running test: %s ===", name);
        repeat (10) begin
            assert(tr.randomize() with { op == ADD; });
            alu_if_inst.a      = tr.a;
            alu_if_inst.b      = tr.b;
            alu_if_inst.op = tr.op;
	    
            @(posedge alu_if_inst.clk);
	     
            check_output(tr); 
        end
    endtask


    task automatic add_test();
        alu_trans tr = new();
        run_test_add("add_test", tr);
    endtask

    //SUB_TEST
    task automatic run_test_sub(string name, alu_trans tr);
        $display("=== Running test: %s ===", name);
        repeat (10) begin
            assert(tr.randomize() with { op == SUB; });
            alu_if_inst.a      = tr.a;
            alu_if_inst.b      = tr.b;
            alu_if_inst.op = tr.op;
            @(posedge alu_if_inst.clk); 
            check_output(tr); 
        end
    endtask


    task automatic sub_test();
        alu_trans tr = new();
        run_test_sub("sub_test", tr);
    endtask

    //AND_TEST

    task automatic run_test_and(string name, alu_trans tr);
        $display("=== Running test: %s ===", name);
        repeat (10) begin
            assert(tr.randomize() with { op == AND; });
            alu_if_inst.a      = tr.a;
            alu_if_inst.b      = tr.b;
            alu_if_inst.op = tr.op;
            @(posedge alu_if_inst.clk); 
            check_output(tr);
        end
    endtask

 
    task automatic and_test();
        alu_trans tr = new();
        run_test_and("and_test", tr);
    endtask

    
    //OR_TEST

    task automatic run_test_or(string name, alu_trans tr);
        $display("=== Running test: %s ===", name);
        repeat (10) begin
            assert(tr.randomize() with { op == OR; });
            alu_if_inst.a      = tr.a;
            alu_if_inst.b      = tr.b;
            alu_if_inst.op = tr.op;
            @(posedge alu_if_inst.clk); 
            check_output(tr);
        end
    endtask


    task automatic or_test();
        alu_trans tr = new();
        run_test_or("or_test", tr);
    endtask

   
    //XOR_TEST
     task automatic run_test_xor(string name, alu_trans tr);
        $display("=== Running test: %s ===", name);
        repeat (10) begin
            assert(tr.randomize() with { op == XOR; });
            alu_if_inst.a      = tr.a;
            alu_if_inst.b      = tr.b;
            alu_if_inst.op = tr.op;
            @(posedge alu_if_inst.clk); 
            check_output(tr);
        end
    endtask


    task automatic xor_test();
        alu_trans tr = new();
        run_test_xor("xor_test", tr);
    endtask


    //NAND_TEST
   
    task automatic run_test_nand(string name, alu_trans tr);
        $display("=== Running test: %s ===", name);
        repeat (10) begin
            assert(tr.randomize() with { op == NAND; });
            alu_if_inst.a      = tr.a;
            alu_if_inst.b      = tr.b;
            alu_if_inst.op = tr.op;
            @(posedge alu_if_inst.clk); 
            check_output(tr);
        end
    endtask


    task automatic nand_test();
        alu_trans tr = new();
        run_test_nand("nand_test", tr);
    endtask

 
    //LSL_TEST

    task automatic run_test_lsl(string name, alu_trans tr);
        $display("=== Running test: %s ===", name);
        repeat (10) begin
            assert(tr.randomize() with { op == LSL; });
            alu_if_inst.a      = tr.a;
            alu_if_inst.b      = tr.b;
            alu_if_inst.op = tr.op;
            @(posedge alu_if_inst.clk); 
            check_output(tr);
        end
    endtask


    task automatic lsl_test();
        alu_trans tr = new();
        run_test_lsl("lsl_test", tr);
    endtask

 
    //LSR_TEST

    task automatic run_test_lsr(string name, alu_trans tr);
        $display("=== Running test: %s ===", name);
        repeat (10) begin
            assert(tr.randomize() with { op == LSR; });
            alu_if_inst.a      = tr.a;
            alu_if_inst.b      = tr.b;
            alu_if_inst.op = tr.op;
            @(posedge alu_if_inst.clk); 
            check_output(tr);
        end
    endtask

    // Basic random test entry point
    task automatic lsr_test();
        alu_trans tr = new();
        run_test_lsr("lsr_test", tr);
    endtask

 
    // Scoreboard: checker task
    task automatic check_output(alu_trans tr);
        bit [7:0] expected;
        bit       expected_carry;
        bit       expected_zero;
        
        case(tr.op)
            ADD : {expected_carry, expected} = tr.a + tr.b;
            SUB : {expected_carry, expected} = tr.a - tr.b;
	    AND : expected = tr.a & tr.b;
	    OR  : expected = tr.a | tr.b;
            XOR : expected = tr.a^tr.b;
            NAND : expected = ~(tr.a&tr.b);
	    LSL : expected = {tr.a, 1'b0};
	    LSR : expected = {1'b0, tr.a[7:1]};
	
            default: expected = 0;
        endcase
        
        if ((alu_if_inst.result != expected) && (alu_if_inst.carry_out == expected_carry) && (alu_if_inst.zero == expected_zero))
            $display("ERROR: opcode = %s a = %0d b = %0d DUT = %0d DUT_carry = %0b DUT_zero = %0b Expected = %0d",
                  tr.op.name(), tr.a, tr.b, alu_if_inst.result, alu_if_inst.carry_out, alu_if_inst.zero, expected);
        else
            $display("PASS: opcode = %s a = %0d b = %0d result = %0d carry = %0b zero = %0b",
                  tr.op.name(), tr.a, tr.b, alu_if_inst.result, alu_if_inst.carry_out, alu_if_inst.zero);
    endtask

    initial begin
        @(posedge alu_if_inst.rst); // wait until reset deasserted
        @(posedge alu_if_inst.clk);
        basic_random();
        add_test();
        sub_test();
        and_test();
        or_test();
        xor_test();
        nand_test();
        lsl_test();
        lsr_test();
        $finish;
    end

endmodule