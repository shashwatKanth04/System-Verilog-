module alu (alu_intf.alu_mp io);
    logic [8:0] tmp_result;

    always @(posedge io.clk or negedge io.rst) begin
    if(!io.rst) begin
        tmp_result <= 9'b0;
        io.result  <= 8'b0;
        io.carry_out <= 1'b0;
	io.zero      <= 1'b0;
    end
    else
    begin
        case (io.op)
            3'b000: begin // ADD
                tmp_result   <= io.a + io.b;
                io.result    <= tmp_result[7:0];
                io.carry_out <= tmp_result[8];
	
            end
            3'b001: begin // SUB
                tmp_result   = io.a - io.b;
                io.result    = tmp_result[7:0];
                io.carry_out = tmp_result[8]; 
            end
           
            3'b010: io.result = io.a & io.b;  // AND
            3'b011: io.result = io.a | io.b;  // OR
            3'b100: io.result = io.a ^ io.b;  // XOR
            3'b101: io.result = ~(io.a & io.b); // NAND      
            3'b110: io.result = io.a << 1;    // Logical Shift Left
            3'b111: io.result = io.a >> 1;    // Logical Shift Right

            default: io.result = 4'b0000;
        endcase
     
        io.zero <= (io.result==4'b0000);
		
    end
end
endmodule
