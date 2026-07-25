module enum_p1;
    typedef enum {SMALL,MEDIUM,LARGE} coffee_size;
    initial begin
     
        coffee_size order;
        order=MEDIUM;
        $display("My order is: %0d",order);
        $display("The first member is: %0d",order.first());
        $display("The last member is: %0d",order.last());
        $display("The next member is: %0d",order.next());
        $display("The previous member is: %0d",order.prev());
        $display("The number of member is: %0d",order.num());
        $display("The string name is: %s",order.name());
    end
endmodule        