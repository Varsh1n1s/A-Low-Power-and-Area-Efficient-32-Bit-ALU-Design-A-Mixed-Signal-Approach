module ALU_32bit_optimized (
    input clk,                // Clock signal
    input [31:0] A, B,        // Operands
    input [3:0] opcode,       // Operation selector
    input enable,             // Enable signal for clock gating
    output reg [31:0] result, // Result
    output reg carry_out,     // Carry flag
    output reg zero_flag      // Zero flag
);
    // Clock gating signal
    wire gated_clk;
    assign gated_clk = clk & enable; // Basic clock gating

    // Registers for operands and operation result
    reg [31:0] A_reg, B_reg;

    // Low-power arithmetic components (e.g., carry-lookahead adder for addition)
    wire [31:0] sum;
    wire carry;

    // Carry-Lookahead Adder for addition
    CLA_32bit cla (
        .A(A_reg),
        .B(B_reg),
        .cin(1'b0),
        .sum(sum),
        .carry(carry)
    );

    // Always block triggered by gated clock
    always @(posedge gated_clk) begin
        // Latch inputs to reduce switching activity
        A_reg <= A;
        B_reg <= B;

        case (opcode)
            4'b0000: begin // Addition
                result <= sum;
                carry_out <= carry;
            end
            4'b0001: result <= A_reg - B_reg;       // Subtraction
            4'b0010: result <= A_reg * B_reg;       // Multiplication
            4'b0011: result <= A_reg % B_reg;       // Modulus
            4'b0100: result <= A_reg / B_reg;       // Division
            4'b0101: result <= A_reg + 1;           // Increment
            4'b0110: result <= A_reg - 1;           // Decrement
            4'b0111: result <= A_reg & B_reg;       // AND
            4'b1000: result <= A_reg | B_reg;       // OR
            4'b1001: result <= ~(A_reg | B_reg);    // NOR
            4'b1010: result <= A_reg ^ B_reg;       // XOR
            4'b1011: result <= ~(A_reg & B_reg);    // NAND
            4'b1100: result <= ~A_reg;              // NOT
            4'b1101: result <= A_reg >> 1;          // Logical Right Shift (LRS)
            4'b1110: result <= A_reg << 1;          // Logical Left Shift (LLS)
            4'b1111: result <= ~(A_reg ^ B_reg);    // XNOR
            default: result <= 32'b0;               // Default case
        endcase

        // Update flags
        zero_flag <= (result == 32'b0);
    end
endmodule

// 32-bit Carry-Lookahead Adder Module (Low-Power Arithmetic)
module CLA_32bit (
    input [31:0] A,
    input [31:0] B,
    input cin,
    output [31:0] sum,
    output carry
);
    wire [31:0] G, P, C; // Generate, Propagate, and Carry signals

    assign G = A & B; // Generate
    assign P = A ^ B; // Propagate

    assign C[0] = cin;
    genvar i;
    generate
        for (i = 1; i < 32; i = i + 1) begin
            assign C[i] = G[i-1] | (P[i-1] & C[i-1]);
        end
    endgenerate

    assign sum = P ^ C;
    assign carry = G[31] | (P[31] & C[31]);
endmodule
