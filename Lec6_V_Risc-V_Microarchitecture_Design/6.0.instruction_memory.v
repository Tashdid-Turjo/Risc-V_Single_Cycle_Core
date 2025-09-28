module Instr_Mem(A, rst, RD);

input [31:0] A,
input rst,
output [31:0] RD,

// creation of memory
reg [31:0] Mem [1023:0];  // when multiple  registers are there then -> 'Mem [1023:0]' which means 1024 amounts of registers & each of its size -> 32 bits.

assign RD = (rst == 1'b0) ? 32'h00000000 : Mem[A[31:2]];



endmodule