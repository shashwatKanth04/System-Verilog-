typedef enum bit [2:0] {ADD,SUB,AND,OR,XOR,NAND,LSL,LSR} op_code_e;

class alu_trans;
	rand bit [7:0]a;
	rand bit [7:0]b;
	rand op_code_e op;
	virtual function void display();
		$display("Base Transaction: a=%0d b=%0d opcode=%s",a,b,op.name());
	endfunction
endclass
