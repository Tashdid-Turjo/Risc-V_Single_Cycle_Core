module P_C(PC_Next, PC, rst, CLK);
    
    input [31:0] PC_Next;
    input CLK, rst;

    output reg [31:0] PC; // in verilog, by default input output is considered as -> wire. But to drive an output inside an always block, declare it as -> reg type.

    always @(posedge CLK)
        begin
            if(rst == 1'b0)
                begin
                    PC <= 32'h00000000;
                end
            else
                begin
                    PC <= PC_Next;
                end
        end

endmodule