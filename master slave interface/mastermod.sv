module mastermod(
    signals.master a, 
    input logic clk, 
    input logic rst,
    input logic [7:0] ext_addr,
    input logic [7:0] ext_data,
    input logic ext_rw,    
    input logic ext_valid,
    output logic fifo_of ///Fifo Overflow Flag

);

    typedef enum logic [2:0] {IDLE, REQUEST, WAITGRANT, WRITE, READ, BACKOFF} state_t;
    state_t current, next;

    logic [7:0] pending_addr, pending_data;
    logic pending_rw;
    logic has_pending;

    // FIFO definition
    typedef struct packed {
        logic [7:0] addr;
        logic [7:0] data;
        logic rw;
    } trans_t;

    //FIFO Parts. 

    state fifo [3:0];
    state current_state;
    logic [1:0] head, tail;
    logic [2:0] cnt;


    assign fifo_full = (count == 4);

    logic [2:0] wait_cnt;   
    logic [1:0] backoff_cnt; 
    logic [1:0] retry_cnt; 

    // FIFO Pointers and Count Logic
    always_ff @(posedge clk) begin
        if(rst) begin
            head <= 0; tail <= 0; count <= 0;
        end else begin
            // Write to FIFO
            if(ext_valid && !fifo_full) begin
                fifo[tail] <= '{ext_addr, ext_data, ext_rw};
                tail <= tail + 1;
                count <= count + 1;
            end
            // Pop from FIFO when transaction completes
            if(current != IDLE && next == IDLE) begin
                head <= head + 1;
                count <= count - 1;
            end
        end
    end

    always_ff @(posedge clk) begin
        if(rst) begin
            current <= IDLE;
            wait_cnt <= 0;
            backoff_cnt <= 0;
            retry_cnt <= 0;
        end 
        else begin
            current <= next;
            if (current == WAITGRANT && !a.gnt) 
                wait_cnt <= wait_cnt + 1;
            else 
                wait_cnt <= 0;

            if (current == BACKOFF) 
                backoff_cnt <= backoff_cnt + 1;
            else 
                backoff_cnt <= 0;

            if (current == IDLE) 
                retry_cnt <= 0; 

            else if (current == WAITGRANT && wait_cnt == 3'd5 && !a.gnt) 
                retry_cnt <= retry_cnt + 1;
        end
    end

    always_ff @(posedge clk) begin
        if(rst)
           has_pending <= 0;
        else if(ext_valid && !has_pending) begin
            pending_addr <= ext_addr;
            pending_data <= ext_data;
            pending_rw   <= ext_rw;
            has_pending  <= 1;
        end 
        else if(current != IDLE && next == IDLE) begin
            has_pending <= 0;
        end
    end

    always_comb begin
        next = current;
        a.req = 0; a.addr = 0; a.din = 0; a.wr_rd = 1;

        case(current)
            IDLE: begin
                if(has_pending) next = REQUEST;
            end

            REQUEST: begin
                a.req = 1;
                next = WAITGRANT;
            end

            WAITGRANT: begin
                a.req = 1;               
                if(a.gnt) begin
                    next = (pending_rw) ? WRITE : READ;
                end 
                else if (wait_cnt == 3'd5) begin
                    if (retry_cnt == 2'd2) begin
                        next = IDLE;    
                    end 
                    else begin
                        next = BACKOFF; 
                    end
                end 
                else begin
                    next = WAITGRANT;
                end
            end

            BACKOFF: begin
                a.req = 0; 
                if (backoff_cnt == 2'd1) begin 
                    next = REQUEST;
                end else begin
                    next = BACKOFF;
                end
            end

            WRITE: begin
                a.req = 1;
                a.addr = pending_addr; 
                a.wr_rd = 1;              
                if(a.slave_ready) begin
                    a.din = pending_data; 
                    next = IDLE;
                end 
                else begin
                    next = WRITE; 
                end
            end

            READ: begin
                a.req = 1;
                a.addr = pending_addr; 
                a.wr_rd = 0;            
                next = IDLE; 
            end
            
            default: next = IDLE;
        endcase
    end
endmodule
