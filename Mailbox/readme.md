# SystemVerilog Mailbox Demonstration Lab

This repository contains a SystemVerilog example demonstrating inter-process communication (IPC) using a bounded `mailbox` with concurrent `fork-join` producer and consumer tasks.

---

## 📂 File Structure

| File Name | File Type | Description |
| :--- | :--- | :--- |
| **`mailbox_demo.sv`** | SystemVerilog Source | Implements a bounded mailbox (`mbx=new(2)`), a producer task generating randomized data, and a consumer task retrieving data concurrently. |

---

## 💻 Code Overview (`mailbox_demo` Example)

The code utilizes a bounded mailbox of size 2 to synchronize data flow between concurrent threads:

```systemverilog
module mailbox_demo;
    mailbox mbx;
    
task automatic producer();
    int data;
    for(int i=0;i<5;i++)begin
        #10;
        data=$urandom_range(0,100);
        $display("[\%0t]producer: generated data=\%0d",$time,data);
        $display("[\%0t]attempting mailbox.put()",$time);
        mbx.put(data);
        $display("[\%0t]generator:mailbox contains \%0d items(s)\n",$time,mbx.num());
    end
endtask

task automatic consumer();
    int rcv_data;
    repeat(5)begin
        mbx.get(rcv_data);
        $display("[\%0t]consumer:rcvd data=\%0d",$time,rcv_data);
        $display("[\%0t]consumer:mailbox contains \%0d items\n",$time,mbx.num());
        #15;
    end
endtask
initial begin
    mbx=new(2);
    fork
        producer();
        consumer();
    join
    $finish
end
endmodule
