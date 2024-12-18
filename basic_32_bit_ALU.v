module alu_32bit_case(y,a,b,f);
input [31:0]a;
input [31:0]b;
input [3:0]f;
output reg [63:0]y;
always@(*)
begin
case(f)
4'b0000:y=a+b; //Addition
4'b0001:y=a-b; //Subtraction
4'b0010:y=a*b;
4'b0011:y=a%b;
4'b0100:y=a/b;
4'b0101:y=a+1'b1;
4'b0110:y=a-1'b1;
4'b0111:y=a&b; //AND Operation
4'b1000:y=a|b; //OR Operation
4'b1001:y=a^b; // Xor
4'b1010:y=~(a&b); //NAND Operation
4'b1011:y=~(a|b); //NOR Operation
4'b1100:y=~(a^b); //Xnor
4'b1101:y= a>>1; //LRS
4'b1110:y= a<<1; //LLS
4'b1111:y= !(a); //LRS
default:y=32'bx;
endcase
end
endmodule
