// Same module that we used in "Lec1&2_V_Alu_Designing" Folder.

module alu(A, B, ALUControl, Result, V, C, N, Z);
    // input declare
    input [31:0] A, B;
    input [2:0] ALUControl;

    // output declare
    output [31:0] Result;
    output V, C, N, Z;

    // wire declare
    wire [31:0] a_and_b;
    wire [31:0] a_or_b;
    wire [31:0] not_b;

    wire [31:0] mux_1;
    wire [31:0] sum;
    wire [31:0] mux_2;

    wire cout; // cout -> 1 bit

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
    assign {cout, sum} = A + mux_1 + ALUControl[0]; // ekhane extra bit ta(carry) cout e add hoye jabe.

    // Designing 4byl Mux
    assign mux_2 = (ALUControl[1:0] == 2'b00) ? sum :
                   (ALUControl[1:0] == 2'b01) ? sum :
                   (ALUControl[1:0] == 2'b10) ? a_and_b : a_or_b;


    ///////////////// Result Assigning ///////////////
    assign Result = mux_2;


    //////////////// Flags Assignment ////////////////
    // Zero flag
    assign Z = &(~Result);

    // Negative flag
    assign N = Result[31];

    // Carry flag
    assign C = cout & (~ALUControl[1]);  

    // Overflow flag
    assign V = (~ALUControl[1]) & 
               (A[31] ^ sum[31]) & 
               (~(A[31] ^ B[31] ^ (ALUControl[0])));

endmodule