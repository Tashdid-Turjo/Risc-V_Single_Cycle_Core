// From "Step-0 I-Type Instruction set pic's": x6 -> rd, -4 -> offset, x9 -> rs1.
// 7.0 to 7.3 is used the same code from Lec6 Folder.
// Step1
module Instr_Mem(A, rst, RD);

input [31:0] A;
input rst;
output [31:0] RD;

// creation of Memory
reg [31:0] Mem [1023:0];  // when multiple  registers are there then -> 'Mem [1023:0]' which means 1024 amounts of registers & each of its size -> 32 bits.

assign RD = (rst == 1'b0) ? 32'h00000000 : Mem[A[31:2]]; // In general concept, rst high -> 32'h00000000, but throughout the video, he used rst low -> 32'h00000000.
                                                         // ?? Here, why 31:2 is used. In the video, he just said to assume it as 8 bytes. ??
// Newly added after running gtkwave for waveform. //
initial begin
    // Only one instruction should be run at a time. Ex- While Load Word, only Load Word's Mem[0], Mem[1] should be run.
    // For Load
    // Mem[0] = 32'WordhFFC4A303; // Got this Address from the instruction under Machine Language's(You'll get it from every Load Word pic's lower part).
    // Mem[1] = 32'h00832383; // Got this from venus.cs61c.org website's online riscv assembly simulator.
    
    // For Store Word
    // Mem[0] = 32'h0064A423; // Got this Address from the instruction under Machine Language's(You'll get it from every Store Word pic's lower part).
    // Mem[1] = 32'h00B62423; // Got this from venus.cs61c.org website's online riscv assembly simulator.

    // For R-Type
    Mem[0] = 32'h0062E233; // Got this Address from the instruction under Machine Language's(You'll get it from  R-Type instruction pic's lower part).

end
////////////////////////////////////////////////////

endmodule