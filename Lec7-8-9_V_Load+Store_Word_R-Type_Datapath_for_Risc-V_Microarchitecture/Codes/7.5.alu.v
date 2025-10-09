// Same module that we used in "Lec1&2_V_Alu_Designing" Folder.
// Step4

module alu(SrcA, SrcB, ALUControl, ALUResult, V, C, N, Z);
    // input declare
    input [31:0] SrcA, SrcB;
    input [2:0] ALUControl;

    // output declare
    output [31:0] ALUResult;
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
    assign a_and_b = SrcA & SrcB;
    
    // OR Operation
    assign a_or_b = SrcA | SrcB;

    // NOT Operation
    assign not_b = ~SrcB;

    // Ternary Operator
    assign mux_1 = (ALUControl[0] == 1'b0) ? SrcB : not_b;

    // Addition / Subtraction Operation
    assign {cout, sum} = SrcA + mux_1 + ALUControl[0]; // ekhane extra bit ta(carry) cout e add hoye jabe.

    // Designing 4byl Mux
    assign mux_2 = (ALUControl[1:0] == 2'b00) ? sum :
                   (ALUControl[1:0] == 2'b01) ? sum :
                   (ALUControl[1:0] == 2'b10) ? a_and_b : a_or_b;


    ///////////////// ALUResult Assigning ///////////////
    assign ALUResult = mux_2;


    //////////////// Flags Assignment ////////////////
    // Zero flag
    assign Z = &(~ALUResult);

    // Negative flag
    assign N = ALUResult[31];

    // Carry flag
    assign C = cout & (~ALUControl[1]);  

    // Overflow flag
    assign V = (~ALUControl[1]) & 
               (SrcA[31] ^ sum[31]) & 
               (~(SrcA[31] ^ SrcB[31] ^ (ALUControl[0])));

endmodule