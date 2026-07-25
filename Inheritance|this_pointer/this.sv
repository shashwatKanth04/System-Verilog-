module test;
    class account;
        int amount;
        int balance;
        int pp;
        function new(int amount=0,int balance=100); //default values
            this.amount=amount;
            this.balance=balance;
        endfunction

        function void display(int val = 55);
            this.pp = val;

        endfunction
    endclass
    initial begin
        account account_h=new(5); 
         //class and object name assign new value
        $display("initial amount=%0d and balance=%0d",account_h.amount,account_h.balance);
        account_h.amount=6;
        account_h.balance=0; 
        account_h.display(45);

        $display("updated amount=%0d and balance=%0d",account_h.amount,account_h.balance);
        $display("Function Display Value of pp : %0d",account_h.pp);
    end
endmodule
