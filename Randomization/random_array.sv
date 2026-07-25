class point;
    rand int x,y;
    function void display(int idx);
        $display("Object(%0d):x=%0d,y=%0d",idx,x,y)
    endfunction
endclass
module test;
    Point pts[5];
    initial begin
        foreach(pts[i])
        begin
            pts[i] = new();
        end

        foreach(pts[i])begin
            if(pts[i].randomize())
            begin
                pts[i].display(i);
            end
            else begin
                $display("Randomization failed for object [%0d]",i);
            end
endmodule