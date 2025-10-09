//Step8
module Mux(a, b, s, c);     // For 2x1 MUX.

    input [31:0] a, b;
    input s;                // s -> select line.
    output [31:0] c;

    assign c = (~s) ? a : b; // If s=1 -> a=0,b=1; else a=1,b=0. ?? Not sure this ??

endmodule