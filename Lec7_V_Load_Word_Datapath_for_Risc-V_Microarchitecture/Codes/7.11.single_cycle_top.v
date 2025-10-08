`include "7.0.instruction_memory.v"
`include "7.1.program_counter.v"
`include "7.2.register_file.v"
`include "7.3.data_memory.v"
`include "7.4.sign_extend.v"
`include "7.5.alu.v"
// `include "7.6.0.main_decoder.v" // no need to include it here as declared in control_unit_top. //
// `include "7.6.1.alu_decoder.v"  // no need to include it here as declared in control_unit_top. //
`include "7.6.2.control_unit_top.v"
`include "7.7.PC_Adder.v"

module Single_Cycle_Top (clk, rst); // clk for synchronize, rst for reset.

    input clk, rst;

    // first P_C -> module name of "7.1.program_counter" file, second P_C -> object name(can be any name).
    P_C P_C(
        .PC_Next(PCPlus4),
        .PC(PC_A),
        .CLK(clk),  // CLK -> P_C module's variables, clk -> Single_Cycle_Top module's variable.
        .rst(rst)
    ); 

    // Step 1 //
    wire [31:0] PC_A; // For connecting path between Program Counter's output & Instruction Memory's input. 32bit cz, Program Counter's input, PC -> 32bit.
                
    Instr_Mem I_M(
                .A(PC_A),
                .rst(rst),
                .RD(RD_A1)
   );


    // Step 2 //
    wire [31:0] RD_A1;  // For connecting path between Instruction Memory's input & Register File's output. 32bit cz, Instruction Memory's input, RD -> 32bit.

    register_file R_F(
                    .A1(RD_A1[19:15]), 
                    .A2(), 
                    .A3(RD_A1[11:7]), // From Step5. 
                    .WD3(ReadData),
                    .CLK(clk), 
                    .WE3(RegWrite),  // From Step5.
                    .RD1(RD1_A), 
                    .RD2(), 
                    .rst(rst)
    );


    // Step 3 //
    Sign_Extend S_E(
                    .In(RD_A1),
                    .ImmExt(ImmExt_B)
    );


    // Step 4 //
    wire [31:0] RD1_A, ImmExt_B; 
    wire [2:0] ALUControl_Top;

    alu ALU(
            .A(RD1_A),
            .B(ImmExt_B),
            .ALUControl(ALUControl_Top),
            .Result(ALUResult),
            .V(),
            .C(),
            .N(),
            .Z()
    );

    control_unit C_U(
                    .zero(),
                    .op(RD_A1[6:0]),  // ?? confuse why RD_A1 ?? But, [6:0] is for I-Type Instruction Set's op's [6:0].
                    .op5(),
                    .funct3(RD_A1[14:12]), // ?? confuse why RD_A1 ?? But, [14:12] is for I-Type Instruction Set's funct3's [14:12].
                    .funct7(),
                    .PCSrc(),
                    .RegWrite(RegWrite),
                    .ALUSrc(),
                    .MemWrite(),
                    .ResultSrc(),
                    .ImmSrc(),
                    .ALUControl(ALUControl_Top)
    );


    // Step 5 // N.B: In Step4 picture, there was no RegWrite port in Register File, but it's in Step5's picture. Also, A3 inside Register File should also be connected.
    wire [31:0] ALUResult;
    wire RegWrite;
    wire [31:0] ReadData;

    Data_Memory D_M(
                    .A(ALUResult),
                    .WD(),
                    .CLK(clk),
                    .WE(),
                    .rst(rst),
                    .RD(ReadData)
    );


    // Step 6
    wire [31:0] PCPlus4;

    PC_Adder PC_Adder(
                    .a(PC_A),
                    .b(32'd4),
                    .c(PCPlus4)
    );

endmodule