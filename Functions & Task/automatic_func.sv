module counter(
    input  logic clk,       // FIX 1: Rename input to 'clk' to avoid conflict
    output logic [31:0] out // FIX 2: Rename output to 'out'
);

    logic [31:0] internal_count;

    function automatic int counter1();
        int count = 0;
        count++;
        return count; 
    endfunction

    // FIX 4: Call the function in an always block to update the output
    always_ff @(posedge clk) begin
        internal_count <= counter1();
    end

    assign out = internal_count;
endmodule

module counter_tb;
    // Signals
    logic clk;
    logic [31:0] out;

    // Instantiate the DUT (Device Under Test)
    counter dut (
        .clk(clk),
        .out(out)
    );

    // Generate a clock: period of 10 time units (5 units high, 5 units low)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Test sequence
    initial begin
        $monitor("time=%0t | clk=%b | out=%0d", $time, clk, out);
        
        // Wait for 5 clock cycles
        repeat(5) @(posedge clk);
        
        $display("Notice: Because the function is 'automatic', it resets 'count' to 0 every time.");
        $stop;
    end
endmodule