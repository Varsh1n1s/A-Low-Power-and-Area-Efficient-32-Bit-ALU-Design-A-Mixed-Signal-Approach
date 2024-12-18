//TEST BENCH

module tb_ALU_32bit_optimized;
    reg clk, enable;
    reg [31:0] A, B;
    reg [3:0] opcode;
    wire [31:0] result;
    wire carry_out, zero_flag;

    ALU_32bit_optimized uut (
        .clk(clk),
        .A(A),
        .B(B),
        .opcode(opcode),
        .enable(enable),
        .result(result),
        .carry_out(carry_out),
        .zero_flag(zero_flag)
    );

    // Clock generation
    initial clk = 0;
    always #5 clk = ~clk; // 10ns clock period

    initial begin
        // Initialize signals
        enable = 1; A = 32'h10; B = 32'h5;

        // Test Addition
        opcode = 4'b0000; #10;
        $display("Addition Result: %h", result);

        // Test Subtraction
        opcode = 4'b0001; #10;
        $display("Subtraction Result: %h", result);

        // Test Multiplication
        opcode = 4'b0010; #10;
        $display("Multiplication Result: %h", result);

        // Test Logical AND
        opcode = 4'b0111; #10;
        $display("AND Result: %h", result);

        // Finish simulation
        $finish;
    end
endmodule
