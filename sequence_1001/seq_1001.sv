module seq_1001 ( output logic detect,
               	input rst, data,clk);
		parameter s0=3'b000, s1=3'b001, s2=3'b010, s3=3'b011, s4=3'b100;
		reg [2:0] state,next_state;
		always_ff @(posedge clk or posedge rst) begin
			if(rst) detect<=0;
			else begin
				state<=next_state;
			end

			case(state)
				s0:next_state=data?s1:s0;
				s1:next_state=data?s0:s2;
            	s2:next_state=data?s0:s3;
				s3:next_state=data?s4:s0;
				s4:next_state=data?s0:s1;
				default:next_state=s0;
			endcase
		end
		final begin
			if(state==s4) detect=1'b1;
			else detect=1'b0;
		end

endmodule




			
