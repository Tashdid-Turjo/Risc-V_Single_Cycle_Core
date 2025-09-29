// In this lecture, we will study different different components of Processor.

module Instr_Mem(
    input logic [31:0] A,
    input logic rst,
    output logic [31:0] RD,
);

    // creation of memory
    reg logic [31:0] Mem [1023:0];  // when multiple registers are there then -> 'Mem [1023:0]' which means 1024 amounts of registers & each of its size -> 32 bits.

    assign RD = (rst == 1'b0) ? 32'h00000000 : Mem[A[31:2]];

endmodule