module dynarr;
    int dyn_arr[];
    initial begin
        dyn_arr=new[5];
        foreach(dyn_arr[i])begin
        dyn_arr[i]=i;
        
        $display("The values of dyn_arr is: %0d",dyn_arr[i]);
        end
        //dyn_arr=new[10];
        dyn_arr=new[20](dyn_arr);
        foreach(dyn_arr[i])begin
            $display("Array persisitng the old values: %0d",dyn_arr[i]);
        end
    end
endmodule


