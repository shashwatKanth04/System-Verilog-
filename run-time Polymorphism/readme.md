# SystemVerilog Runtime Polymorphism Lab

This repository contains a SystemVerilog example demonstrating **runtime polymorphism** through virtual methods, class inheritance, and handle assignments.

---

## 📂 File Structure

| File Name | File Type | Description |
| :--- | :--- | :--- |
| **`runtime_poly.sv`** | SystemVerilog Source | Demonstrates polymorphism using virtual functions, base class handles pointing to subclass objects, and method overriding. |

---

## 💻 Code Overview (`runtime_poly` Example)

The script defines a base class `transaction` with a virtual method `display()` and an extended class `bad` that overrides this method:

```systemverilog
module runtime_poly;
    class transaction;
    int i;
    virtual function void display();  //virtual method
        $display("i=%0d",i);
    endfunction
endclass
class bad extends transaction;
    int j;
    function void display();  //override function
        $display("j=%0d",j);
    endfunction
endclass
initial begin
    transaction t1; //superclass handle
    bad t2;    //subclass handle


    t2=new; //subclass object 
    t2.i=10;
    t2.j=20; //prints 20

    t2.display();  //subclass handle

    t1=t2;  
    t1.display();  //superclass handle
    t1=new();
    t1.i=99;
    t1.display();  
end
endmodule
