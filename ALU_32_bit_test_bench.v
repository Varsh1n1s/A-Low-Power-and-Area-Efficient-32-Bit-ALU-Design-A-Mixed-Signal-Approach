`timescale 1ns / 1ps

module ALU_32_bit_test_bench;

	// Inputs
	reg [31:0] Operand1;
	reg [31:0] Operand2;
	reg [3:0] Opcode;

	// Outputs
	wire [63:0] Result;
	wire flagC;
	wire flagZ;
	reg [3:0]count = 4'b0000;

	// Instantiate the Unit Under Test (UUT)
	ALU_32_bit uut (
		.Operand1(Operand1), 
		.Operand2(Operand2), 
		.Opcode(Opcode), 
		.Result(Result), 
		.flagC(flagC), 
		.flagZ(flagZ)
	);

	initial begin
		Operand1 = 32'hABCDABCD;
		Operand2 = 32'h83635273;
		for(count=0;count<16;count=count+1'b1)
		begin
		Opcode=count;
		#20;
		end
	end
      
endmodule
