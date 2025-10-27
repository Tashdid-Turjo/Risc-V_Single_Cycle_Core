// Step6

module PC_Adder (a, b, c);  // Though the input b = 4, but we have to consider this as b and then put the value of 4 in the top module.
    input [31:0] a, b;
    output [31:0] c;

    assign c = a + b;

endmodule