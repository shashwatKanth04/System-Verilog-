module struct_p1;
    typedef struct {
        int roll_no;
        string name; bit [7:0]marks;
    } student;
    
    student student1;
    initial begin
        student1.roll_no =101;
        student1.name ="megha";
        student1.marks=8'hA5;
        $display("student roll no is: %0d",student1.roll_no);
        $display("student name: %s",student1.name);
        $display("student marks:%h",student1.marks);
    end
endmodule

    