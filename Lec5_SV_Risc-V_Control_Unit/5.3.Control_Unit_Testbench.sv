`timescale 1ns/1ps

module tb_control_unit;

    // Inputs
    logic zero;
    logic [6:0] op;
    logic [7:0] op5;
    logic [2:0] funct3;
    logic funct7;

    // Outputs
    logic PCSrc;
    logic RegWrite;
    logic ALUSrc;
    logic MemWrite;
    logic ResultSrc;
    logic [1:0] ImmSrc;
    logic [2:0] ALUControl;

    // Instantiate the control_unit
    control_unit uut (
        .zero(zero),
        .op(op),
        .op5(op5),
        .funct3(funct3),
        .funct7(funct7),
        .PCSrc(PCSrc),
        .RegWrite(RegWrite),
        .ALUSrc(ALUSrc),
        .MemWrite(MemWrite),
        .ResultSrc(ResultSrc),
        .ImmSrc(ImmSrc),
        .ALUControl(ALUControl)
    );

    // Test procedure
    initial begin
        $display("Time\tOP\tfunct3\tfunct7\tzero\tPCSrc\tRegWrite\tALUSrc\tMemWrite\tResultSrc\tImmSrc\tALUControl");
        
        // Test 1: Load instruction (opcode 0000011)
        op = 7'b0000011; op5 = 8'b00000000; funct3 = 3'b010; funct7 = 1'b0; zero = 0;
        #10;
        $display("%0t\t%b\t%b\t%b\t%b\t%b\t%b\t%b\t%b\t%b\t%b\t%b", $time, op, funct3, funct7, zero, PCSrc, RegWrite, ALUSrc, MemWrite, ResultSrc, ImmSrc, ALUControl);

        // Test 2: Store instruction (opcode 0100011)
        op = 7'b0100011; op5 = 8'b00000000; funct3 = 3'b010; funct7 = 1'b0; zero = 0;
        #10;
        $display("%0t\t%b\t%b\t%b\t%b\t%b\t%b\t%b\t%b\t%b\t%b\t%b", $time, op, funct3, funct7, zero, PCSrc, RegWrite, ALUSrc, MemWrite, ResultSrc, ImmSrc, ALUControl);

        // Test 3: R-type instruction (opcode 0110011), ADD funct3=000, funct7=0
        op = 7'b0110011; op5 = 8'b00; funct3 = 3'b000; funct7 = 1'b0; zero = 0;
        #10;
        $display("%0t\t%b\t%b\t%b\t%b\t%b\t%b\t%b\t%b\t%b\t%b\t%b", $time, op, funct3, funct7, zero, PCSrc, RegWrite, ALUSrc, MemWrite, ResultSrc, ImmSrc, ALUControl);

        // Test 4: R-type instruction (SUB funct3=000, funct7=1)
        op = 7'b0110011; op5 = 8'b00; funct3 = 3'b000; funct7 = 1'b1; zero = 0;
        #10;
        $display("%0t\t%b\t%b\t%b\t%b\t%b\t%b\t%b\t%b\t%b\t%b\t%b", $time, op, funct3, funct7, zero, PCSrc, RegWrite, ALUSrc, MemWrite, ResultSrc, ImmSrc, ALUControl);

        // Test 5: Branch instruction (opcode 1100011), zero=1 (branch taken)
        op = 7'b1100011; op5 = 8'b00; funct3 = 3'b000; funct7 = 1'b0; zero = 1;
        #10;
        $display("%0t\t%b\t%b\t%b\t%b\t%b\t%b\t%b\t%b\t%b\t%b\t%b", $time, op, funct3, funct7, zero, PCSrc, RegWrite, ALUSrc, MemWrite, ResultSrc, ImmSrc, ALUControl);

        // Test 6: Branch instruction (zero=0, branch not taken)
        zero = 0;
        #10;
        $display("%0t\t%b\t%b\t%b\t%b\t%b\t%b\t%b\t%b\t%b\t%b\t%b", $time, op, funct3, funct7, zero, PCSrc, RegWrite, ALUSrc, MemWrite, ResultSrc, ImmSrc, ALUControl);

        $finish;
    end

endmodule
