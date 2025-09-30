`include "7.0.instruction_memory.v"
`include "7.1.program_counter.v"
`include "7.2.register_file.v"
`include "7.3.data_memory.v"
`include "7.4.sign_extend.v"

module Single_Cycle_Top (clk, rst); // clk for synchronize, rst for reset.

    input clk, rst;

    // first P_C -> module name of program_counter file, second P_C -> object name(can be any name).
    P_C P_C(
        .PC_Next(),
        .PC(PC_A),
        .CLK(clk),  // CLK -> P_C module's variables, clk -> Single_Cycle_Top module's variable.
        .rst(rst)
    ); 

    wire [31:0] PC_A; // For connecting path between Program Counter's output & Instruction Memory's input. 32bit cz, Program Counter's input, PC -> 32bit.
                
    Instr_Mem I_M(
                .A(PC_A),
                .rst(rst),
                .RD(RD_A1)
   );

    wire [31:0] RD_A1;  // For connecting path between Instruction Memory's input & Register File's output. 32bit cz, Instruction Memory's input, RD -> 32bit.

    register_file R_F(
                    .A1(RD_A1[19:15]), 
                    .A2(), 
                    .A3(), 
                    .WD3(), 
                    .CLK(clk), 
                    .WE3(), 
                    .RD1(), 
                    .RD2(), 
                    .rst(rst)
    );

    sign_extend S_E(
                    .In(RD_A1),
                    .ImmExt()
    );

    //////////// vdo's step 3 done. ////////////
    
endmodule