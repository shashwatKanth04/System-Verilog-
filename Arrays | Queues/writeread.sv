bit [31:0] mem_array[bit [31:0]];
bit [31:0] addr_array[bit [31:0]];
task write(bit[31:0]addr,bit [31:0]data);
    begin
        mem_array[addr]= data;
        addr_array[addr_count]=addr;
        addr_count++;
        $display("write address is: %0h | data : %0h",addr,data);
    end
endtask
task read(bit [31:0]addr);
    begin
        if(mem_array.exists(addr))
        begin
            $display("read address is: %0h | data: %0h",addr,mem_array[addr]);
        end
        else begin
            $display("read address %0h | data: %0h", addr);
        end
    end
endtask
 