module Data_Memory(A, WD, CLK, WE, RD);

    input [31:0] A, WD;
    input CLK, WE;
    output [31:0] RD;

    reg [31:0] Data_Mem [1023:0];

    // read -> if write enable = 0, it reads address A onto RD.
    assign RD = (WE == 1'b0) ? Data_Mem[A] : 32'h00000000;

    // write -> if write enable = 1, it writes data WD into address A on the rising edge of the clock.
    always @(posedge CLK)
        begin
            if (WE == 1'b1)
                begin
                    Data_Mem[A] <= WD;
                end
        end

endmodule