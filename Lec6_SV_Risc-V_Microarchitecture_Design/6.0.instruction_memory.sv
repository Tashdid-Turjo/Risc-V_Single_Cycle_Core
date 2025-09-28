module Instr_Mem(
    input [31:0] A,
    input rst,

    output [31:0] RD,

    reg [31:0] Mem;  // when multiple registers are there then -> 'Mem [1023:0]' which means 1024 amounts of registers & each of its size -> 32 bits.



);

endmodule