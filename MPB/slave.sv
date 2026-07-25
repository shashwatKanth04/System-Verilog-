module mpb_peripheral (mpb_intf.slave b_if );

    logic [7:0] DATA_REG;
    logic [7:0] STATUS_REG;
    logic [7:0] CONTROL_REG;

    assign b_if.slave_ready = 1'b1;

    always_ff @(posedge b_if.clk or posedge b_if.reset) begin
        if (b_if.reset) begin
            DATA_REG         <= 8'h00;
            STATUS_REG       <= 8'h00;
            CONTROL_REG      <= 8'h00;
            b_if.grant       <= 1'b0;
            b_if.data_out    <= 8'h00;
            b_if.error       <= 1'b0;
        end else begin
            
            if (b_if.req) begin
                b_if.grant <= 1'b1; 
                
                if (b_if.rd_wr) begin
                    case (b_if.addr)
                        8'h00:   begin DATA_REG    <= b_if.data_in; b_if.error <= 1'b0; end
                        8'h02:   begin CONTROL_REG <= b_if.data_in; b_if.error <= 1'b0; end
                        default: begin b_if.error  <= 1'b1;                             end 
                    endcase
                end else begin

                    case (b_if.addr)
                        8'h00:   begin b_if.data_out <= DATA_REG;    b_if.error <= 1'b0; end
                        8'h01:   begin b_if.data_out <= STATUS_REG;  b_if.error <= 1'b0; end
                        8'h02:   begin b_if.data_out <= CONTROL_REG; b_if.error <= 1'b0; end
                        default: begin b_if.data_out <= 8'h00;       b_if.error <= 1'b1; end 
                    endcase
                end
                
            end else begin
                b_if.grant <= 1'b0;
                b_if.error <= 1'b0; 
            end
        end
    end
endmodule