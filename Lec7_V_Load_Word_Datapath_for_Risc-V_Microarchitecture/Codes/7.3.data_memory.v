// Step5

module Data_Memory(A, WD, CLK, WE, rst, RD);

    input [31:0] A, WD;
    input CLK, WE, rst;
    output [31:0] RD;

    reg [31:0] Data_Mem [1023:0];

    // read -> if write enable = 0, it reads address A onto RD.
    assign RD = (~rst) ? 32'h00000000 : Data_Mem[A]; // ?? why ~rst instead of WE == 1'b0 ??

    // write -> if write enable = 1, it writes data WD into address A on the rising edge of the clock.
    always @(posedge CLK)
        begin
            if (WE == 1'b1)
                begin
                    Data_Mem[A] <= WD;
                end
        end

    // Newly added after running gtkwave for waveform. //
    initial begin
        Data_Mem[28] = 32'h00000020;
        Data_Mem[40] = 32'h00000002;
    end
    ////////////////////////////////////////////////////

endmodule