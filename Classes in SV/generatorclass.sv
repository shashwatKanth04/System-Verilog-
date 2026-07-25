class alu_gen;
  // Handle to transaction
  alu_trans gen_trans;
  // Mailbox to send transactions to Driver
  mailbox #(alu_trans) gen2drv;
  // Constructor: connect generator to mailbox
  function new(mailbox #(alu_trans) gen2drv);
    this.gen2drv = gen2drv;
  endfunction
  // Start method: generate and send transactions
  virtual task run(int num_of_trans);
    fork
      for (int i = 0; i < num_of_trans; i++) begin
        gen_trans = new();                // create transaction
        assert(gen_trans.randomize());    // randomize inputs and op
gen2drv.put(gen_trans);           // send transaction to driver
        $display("[%0t] Generator: Sent ID=%0d a=%0d b=%0d op=%0d",
                 $time, gen_trans.trans_id, gen_trans.a, gen_trans.b,
                 gen_trans.op);
      end
    join_none
  endtask
endclass