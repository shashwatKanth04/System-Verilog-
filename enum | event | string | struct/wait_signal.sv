module event_demo;
    event trigger;
    initial begin
        $display("Process A: waiting fdor event at time %0t",$time);
        @(trigger)
        $display("Process A: Event received at %0t",$time);
    end

    initial begin
        #10ns;
        $display("Process B:Triggering event at %0t",$time);
        ->trigger;
    end
endmodule