module alu_32bit_tb_case;
reg [31:0]a;
reg [31:0]b;
reg [3:0]f;
wire [31:0]y;
alu_32bit_case test2(.y(y),.a(a),.b(b),.f(f));
initial
begin
a=32'h00000000;
b=32'hFFFFFFFF;
for(f=0; f<16; f=f+1)
begin
#20;
end
end
endmodule
