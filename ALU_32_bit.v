`timescale 1ns / 1ps
module ALU_32_bit(Operand1,Operand2,Opcode,Result,flagC,flagZ);
input [31:0] Operand1, Operand2;
input [3:0] Opcode;
output reg [63:0] Result=64'b0;
output reg flagC = 1'b0,flagZ=1'b0;

//Defining the Opcodes
parameter [3:0] ADD=4'b0000,
SUB=4'b0001,
MUL=4'b0010,
MOD=4'b0011,
DIV=4'b0100,
INC=4'b0101,
DEC=4'b0110,
AND=4'b0111,
OR=4'b1000,
XOR=4'b1001,
NAND=4'b1010,
NOR=4'b1011,
XNOR=4'b1100,
LRS=4'b1101,
LLS=4'b1110,
NOT=4'b1111;

always@(Opcode or Operand1 or Operand2)
begin

case(Opcode)

//Addition
ADD: begin
Result = Operand1 + Operand2;
flagC = Result[32];
flagZ = (Result==64'b0);
end

//Subtraction
SUB: begin
Result = Operand1 - Operand2;
flagC = Result[32];
flagZ = (Result==64'b0);
end

//Multiplication
MUL: begin
Result = Operand1 * Operand2;
flagZ = (Result==64'b0);
end

//Modulus
MOD: begin
Result = Operand1 % Operand2;
flagZ = (Result==64'b0);
end

//Division
DIV: begin
Result = Operand1 / Operand2;
flagZ = (Result==64'b0);
end

//Increment 
INC: begin
Result = Operand1 + 1'b1;
flagZ = (Result==64'b0);
end
  
//Decrement
DEC: begin
Result = Operand1 - 1'b1;
flagZ = (Result==64'b0);
end
  
//Logical AND
AND: begin
Result = Operand1 & Operand2;
flagZ = (Result==64'b0);
end
  
//Logical OR
OR:  begin
Result = Operand1 | Operand2;
flagZ = (Result==64'b0);
end
  
//Logical XOR
XOR: begin
Result = Operand1 ^ Operand2;
flagZ = (Result==64'b0);
end
  
//Logical NAND
NAND: begin
Result = ~(Operand1 & Operand2);
flagZ = (Result==64'b0);
end
  
//Logical NOR
NOR: begin
Result = ~(Operand1 | Operand2);
flagZ = (Result==64'b0);
end

//Logical XNOR
XNOR: begin
Result = ~(Operand1 ^ Operand2);
flagZ = (Result==64'b0);
end

//Logical Right Shift
LRS: begin
Result = Operand1 >> 1;
flagZ = (Result==64'b0);
end

//Logical Left Shift
LLS: begin
Result = Operand1 << 1;
flagZ = (Result==64'b0);
end
  
//Logical Negation
NOT: begin
Result = !(Operand1);
flagZ = (Result==64'b0);
end

default: begin
Result = 64'b0;
flagC = 32'b0;
flagZ = 32'b0;
end

endcase

end

endmodule
