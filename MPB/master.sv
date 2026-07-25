module mpb_master (
    mpb_intf.master b_if, 
    input  logic [7:0]  ext_addr,
    input  logic [7:0]  ext_data,
    input  logic        ext_rw,
    input  logic        ext_valid,
    output logic        fifo_full
);

    typedef struct packed {
        logic [7:0] addr;
        logic [7:0] data;
        logic       rw;
    } txn_t;

    txn_t [3:0] fifo;
    int fifo_count;

    logic [2:0] timeout_counter;
    logic [1:0] retry_counter;

    assign fifo_full = (fifo_count == 4);

    always_ff @(posedge b_if.clk or posedge b_if.reset) begin
        if (b_if.reset) begin
            fifo_count      <= 0;
            b_if.req        <= 1'b0;
            b_if.addr       <= 8'h00;
            b_if.data_in    <= 8'h00;
            b_if.rd_wr      <= 1'b0;
            timeout_counter <= 3'b000;
            retry_counter   <= 2'b00;
            fifo            <= '0;
        end else begin
            if (ext_valid && (fifo_count < 4)) begin
                fifo[fifo_count].addr <= ext_addr;
                fifo[fifo_count].data <= ext_data;
                fifo[fifo_count].rw   <= ext_rw;
                fifo_count            <= fifo_count + 1;
            end

            if (fifo_count > 0) begin
                b_if.req     <= 1'b1;
                b_if.addr    <= fifo[0].addr;
                b_if.data_in <= fifo[0].data;
                b_if.rd_wr   <= fifo[0].rw;

                if (b_if.grant && b_if.slave_ready) begin
                    b_if.req        <= 1'b0;
                    timeout_counter <= 0;
                    retry_counter   <= 0;
                    fifo[0]    <= fifo[1];
                    fifo[1]    <= fifo[2];
                    fifo[2]    <= fifo[3];
                    fifo[3]    <= '0;
                    fifo_count <= fifo_count - 1;
                end
                else if (!b_if.grant) begin
                    timeout_counter <= timeout_counter + 1;
                    
                    if (timeout_counter > 5) begin
                        b_if.req        <= 1'b0; 
                        timeout_counter <= 0;
                        retry_counter   <= retry_counter + 1;
                    end
                end
            end else begin
                b_if.req <= 1'b0; 
            end

            if (retry_counter > 3) begin
                timeout_counter <= 0;
                retry_counter   <= 0;
                fifo[0]    <= fifo[1];
                fifo[1]    <= fifo[2];
                fifo[2]    <= fifo[3];
                fifo[3]    <= '0;
                fifo_count <= fifo_count - 1;
            end
        end
    end
endmodule