module P_C(
    input logic [31:0] PC_Next;
    input logic CLK, rst;
    output logic [31:0] PC; // when use always_ff block, use logic instead of wire.
);

always_ff @(posedge CLK)
        begin
            if(!rst)
                begin
                    PC <= 32'h00000000;
                end
            else
                begin
                    PC <= PC_Next; // otherwise, load next pc
                end
        end

endmodule