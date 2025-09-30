// This module used for the Step3.png's Sign Extend.

module Sign_Extend (In, ImmExt);
    
    input [31:0] In;
    output [31:0] ImmExt;

    // It means -> In[31] is by default == 1'b1. Then MSB's 31:12 will be either 1 or 0 & LSB's 11:0 will be In's 31:20's value.
    assign ImmExt = {In[31]} ? {{20{1'b1}}, {In[31:20]}} :
                               {{20{1'b0}}, {In[31:20]}};

endmodule