interface bus;
    logic [3:0] a;
    logic [3:0] b;
    logic cin;
    logic [3:0] sum;
    logic carry;
endinterface

module fa_tb;
    bus x();
    

    FA4 dut(.a(x.a), .b(x.b), .cin(x.cin), .sum(x.sum), .carry(x.carry));
    
    initial begin
        $display("Starting adder testbench...");
        run_test();
        $display("All test completed");
        $finish;
    end

    // Generator: Ensure outputs are logic types
    task generate_inputs(output logic [3:0] a_out, output logic [3:0] b_out, output logic cin_out);
        begin
            a_out = $random % 16;
            b_out = $random % 16;
            cin_out = $random % 2;
        end
    endtask

    // Driver: Access signals via the interface instance 'x'
    task drive_dut(input [3:0] a_in, input [3:0] b_in, input cin_in);
        begin
            x.a = a_in;
            x.b = b_in;
            x.cin = cin_in;
            #5;
        end
    endtask


     task scoreboard(input [3:0]a,b,input cin,input [3:0]sum, input carry);
        logic[4:0]expected;
        expected =a+b+cin;
        if(expected == {carry,sum})
        $display("pass");
        else
        $display("fail");
    endtask



    task run_test;
        integer i;
        logic [3:0] a_gen, b_gen;
        logic c_gen;
        begin
            for(i = 0; i < 10; i = i + 1) begin
                generate_inputs(a_gen, b_gen, c_gen);
                drive_dut(a_gen, b_gen, c_gen);
                // Accessing signals through 'x'
                $display("Time=%0t, A=%0b, B=%0b, Cin=%0b, Sum=%0b, Carry=%0b", 
                          $time, x.a, x.b, x.cin, x.sum, x.carry);
                 scoreboard( x.a, x.b, x.cin, x.sum, x.carry);
                 $monitor("Time=%0t, A=%0b, B=%0b, Cin=%0b, Sum=%0b, Carry=%0b", 
                          $time, x.a, x.b, x.cin, x.sum, x.carry);
                         #100 $finish;
            end
        end
    endtask
endmodule
    

    
    

   

