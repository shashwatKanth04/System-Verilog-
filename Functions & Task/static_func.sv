module counter(
    input  logic clk,
    output logic [31:0] out
);

    logic [31:0] internal_count;

    // REMOVED 'automatic' keyword.
    // This makes the function static by default.
    function int counter1();
        // This line runs only ONCE at the start of the simulation
        static int count = 0; 
        count++;
        return count; 
    endfunction

    always_ff @(posedge clk) begin
        internal_count <= counter1();
    end

    assign out = internal_count;
endmodule


module counter_tb;
    logic clk;
    logic [31:0] out;

    // Instantiate the DUT
    counter dut (
        .clk(clk),
        .out(out)
    );

    // Clock generation: 10ns period
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Test sequence
    initial begin
        // Using $time and %0d to observe the incremental behavior
        $monitor("time=%0t | clk=%b | out=%0d", $time, clk, out);
        
        // Wait for 10 clock cycles to watch it count up
        repeat(10) @(posedge clk);
        
        $display("--- Finished counting ---");
        $stop;
    end
endmodule