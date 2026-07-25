module queue_lab;

  
  int q[$];

  // Write Task (enqueue)
  task write_task(input int data);
    q.push_back(data);
    $display("[WRITE] Enqueued data: %0d", data);
  endtask

  // Read Task (dequeue)
  task read_task();
    int removed_data;
    if (q.size() > 0) begin
      removed_data = q.pop_front();
      $display("[READ]  Dequeued data: %0d", removed_data);
    end else begin
      $display("[WARN]  Queue is empty, cannot dequeue!");
    end
  endtask

  // Initial Block to run the simulation steps
  initial begin
    
    // 1. Perform 5 writes with random data
  
    repeat(5) begin
      int rand_data = $urandom();
      write_task(rand_data);
    end
    
    // Display Queue state after writes
    
    $display("Queue contents: %p", q);
    $display("Queue size    : %0d", q.size());

    // 2. Perform 5 reads to observe FIFO order
   
    repeat(5) begin
      read_task();
    end

    // Display Queue state after reads
  
    $display("Queue contents: %p", q);
    $display("Queue size    : %0d", q.size());

    // 3. Clear queue
  
    q.delete();
    
    // Final verification
    $display("Final Queue contents: %p", q);
    $display("Final Queue size    : %0d", q.size());
   
  end

endmodule
