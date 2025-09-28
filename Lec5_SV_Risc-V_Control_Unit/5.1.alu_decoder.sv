// this module connected with '5.0.main_decoder' file //

module alu_decoder(
    input logic [1:0] ALUOp,
    input logic [7:0] op5,
    input logic [2:0] funct3,
    input logic funct7,
    output logic ALUControl
);

    // interim wire
    wire [1:0] concatenation;

    assign concatenation  = {op5, funct7};

    assign ALUControl = (ALUOp == 2'b00) ? 3'b000 :
                        (ALUOp == 2'b01) ? 3'b001 :
                        (ALUOp == 2'b10) & (funct3 == 3'b010) ? 3'b101 :
                        (ALUOp == 2'b10) & (funct3 == 3'b110) ? 3'b011 :
                        (ALUOp == 2'b10) & (funct3 == 3'b111) ? 3'b010 :
                        ((ALUOp == 2'b10) & (funct3 == 3'b000) & (concatenation == 2'b11)) ? 3'b001 :
                        ((ALUOp == 2'b10) & (funct3 == 3'b000) & (concatenation != 2'b11)) ? 3'b000 : 3'b000;

endmodule