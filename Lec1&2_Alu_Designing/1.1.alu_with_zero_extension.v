// not connected with the other module in '1.0.alu.v' file //

module alu(A, B, ALUControl, Result);
    // input declare
    input [31:0] A, B;
    input [2:0] ALUControl;

    // output declare
    output [31:0] Result;

    // wire declare
    wire [31:0] a_and_b;
    wire [31:0] a_or_b;
    wire [31:0] not_b;

    wire [31:0] mux_1;
    wire [31:0] sum;
    wire [31:0] mux_2;

    wire [31:0] slt; // for zero extension -> set less than

    //////////////// Logic Design /////////////////
    // AND Operation
    assign a_and_b = A & B;
    
    // OR Operation
    assign a_or_b = A | B;

    // NOT Operation
    assign not_b = ~B;

    // Ternary Operator
    assign mux_1 = (ALUControl[0] == 1'b0) ? B : not_b;

    // Addition / Subtraction Operation
    assign sum = A + mux_1 + ALUControl[0];

    // Zero Extension
    assign slt = {31'b0000000000000000000000000000000, sum[31]}; // first 31bits in MSB, then 1 bit in LSB

    // Designing 4byl Mux
    assign mux_2 = (ALUControl[2:0] == 2'b000) ? sum :
                   (ALUControl[2:0] == 2'b001) ? sum :
                   (ALUControl[2:0] == 2'b010) ? a_and_b : 
                   (ALUControl[2:0] == 2'b011) ? a_or_b :
                   (ALUControl[2:0] == 2'b101) ? slt : 32'h00000000; // baki 3ta(100, 110, 111) er jnne 32'h00000000; also binary's 4 bits = hexa's 1 bit so here, 8 bit hexa = 32 bit binary.

    // Main Result Assigning
    assign Result = mux_2;

endmodule