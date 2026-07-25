module tb_functions;
  function int add(int a, int b = 10);
    return a + b;
  endfunction

  int result;

  initial begin
    // Case 1: Call with both arguments provided
    result = add(5, 5);
    $display("Case 1 (5+5): %0d", result);

    // Case 2: Call with only a provided (b takes default 10)
    result = add(5);
    $display("Case 2 (5+default): %0d", result);

    // Case 3: Call using named arguments
    result = add(.a(20), .b(5));
    $display("Case 3 (named 20+5): %0d", result);

    // Case 4: Call using named arguments but omit b (b takes default 10)
    result = add(.a(20));
    $display("Case 4 (named 20+default): %0d", result);
  end

endmodule
