// Step3&7
module Sign_Extend (In, ImmExt, ImmSrc); // ImmSrc -> For Step7's S-Type Instruction's imm.
    
    input [31:0] In; // There's nothing written in the pic, so gave a name In.
    input ImmSrc;
    output [31:0] ImmExt;

    assign ImmExt = (ImmSrc == 1'b1) ? { {20{In[31]}}, In[31:25], In[11:7] } : // For S-Type(Store Word).
                                       { {20{In[31]}}, In[31:20] };            // For I-Type(Load Word).

endmodule


// // Step3 Only
// module Sign_Extend (In, ImmExt);
    
//     input [31:0] In; // There's nothing written in the pic, so gave a name In.
//     output [31:0] ImmExt;

//     // It means -> In[31] is by default == 1'b1. Then MSB's 31:12 bits will be either 1 or 0 & LSB's 11:0 will be In's 31:20's value.
//     assign ImmExt = {In[31]} ? {{20{1'b1}}, {In[31:20]}} :
//                                {{20{1'b0}}, {In[31:20]}};

// endmodule