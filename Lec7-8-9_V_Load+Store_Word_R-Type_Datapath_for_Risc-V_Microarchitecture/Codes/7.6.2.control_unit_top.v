// Top-level control unit for connecting main_decoder and alu_decoder.
// Here, in Step 4, this module is used bcz, ALUControl was the final output in Lec5. Thus, this ALUControl means that full module will be used here.
// Step4

`include "7.6.0.main_decoder.v"
`include "7.6.1.alu_decoder.v"

module control_unit(zero, op, op5, funct3, funct7, PCSrc, RegWrite, ALUSrc, MemWrite, ResultSrc, ImmSrc, ALUControl);
    input   zero;
    input   [6:0] op;      // opcode from instruction
    input   [7:0] op5;     // 5th opcode bit for ALU decoding
    input   [2:0] funct3;  // funct3 from instruction
    input   funct7;        // funct7[5] from instruction
    output  PCSrc;
    output  RegWrite;
    output  ALUSrc;
    output  MemWrite;
    output  ResultSrc;
    output  [1:0] ImmSrc;
    output  [2:0] ALUControl;

    // intermediate wire for ALUOp from main_decoder
    wire [1:0] ALUOp;

    // instantiate main_decoder
    main_decoder u_main_decoder (
        .zero(zero),
        .op(op),
        .PCSrc(PCSrc),
        .RegWrite(RegWrite),
        .ALUSrc(ALUSrc),
        .MemWrite(MemWrite),
        .ResultSrc(ResultSrc),
        .ImmSrc(ImmSrc),
        .ALUOp(ALUOp)
    );

    // instantiate alu_decoder
    alu_decoder u_alu_decoder (
        .ALUOp(ALUOp),
        .op5(op5),
        .funct3(funct3),
        .funct7(funct7),
        .ALUControl(ALUControl)
    );

endmodule
