// Top-level control unit for connecting main_decoder and alu_decoder.
`include "5.0.main_decoder.sv"
`include "5.1.alu_decoder.sv"

module control_unit(
    input  logic zero,
    input  logic [6:0] op,      // opcode from instruction
    input  logic [7:0] op5,     // 5th opcode bit for ALU decoding
    input  logic [2:0] funct3,  // funct3 from instruction
    input  logic funct7,        // funct7[5] from instruction
    output logic PCSrc,
    output logic RegWrite,
    output logic ALUSrc,
    output logic MemWrite,
    output logic ResultSrc,
    output logic [1:0] ImmSrc,
    output logic [2:0] ALUControl
);

    // intermediate wire for ALUOp from main_decoder
    logic [1:0] ALUOp;

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
