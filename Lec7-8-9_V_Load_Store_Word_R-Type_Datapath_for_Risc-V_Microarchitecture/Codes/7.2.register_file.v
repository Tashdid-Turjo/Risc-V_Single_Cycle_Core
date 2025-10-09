// Step2

module register_file(A1, A2, A3, WD3, CLK, WE3, RD1, RD2, rst);

    // suppose 'add x3, x1, x2', here, x1 -> A1, x2 -> A2, x3 -> A3.
    input [4:0] A1, A2, A3;
    input [31:0] WD3;
    input CLK, rst, WE3;

    output [31:0] RD1, RD2;

    // creation of memory
    reg [31:0] Registers [31:0]; // first [31:0] -> size of each Registers, last [31:0] -> amount of Registers.

    // read functionality
    assign RD1 = (!rst) ? 32'h00000000 : Registers[A1];
    assign RD2 = (!rst) ? 32'h00000000 : Registers[A2];

    // write functionality
    always @(posedge CLK)
        begin
            if(WE3)
                begin
                    Registers[A3] <= WD3;
                end
        end

    // Newly added after running gtkwave for waveform. //
    initial begin
        Registers[9] = 32'h00000020; // 9 cz rs1 = 01001 which is 9. ? But why 32'h00000020 ?
        Registers[6] = 32'h00000040; // 6 cz rs2 = 00110 which is 6. ? But why 32'h00000040 ?        
        Registers[11] = 32'h00000028;// See venus.cs61c.org picture's (11-14). ? But why 32'h00000028 ?
        Registers[12] = 32'h00000030;// See venus.cs61c.org picture's (11-14). ? But why 32'h00000030 ?
    end
    ////////////////////////////////////////////////////


/////////////////////////////////////////////////////////////////
/*
Suppose register x5 currently contains 100.
(i) If you set A3 = 5, WD3 = 200, WE3 = 1 → on the next clock edge, x5 becomes 200.
(ii) If you set A3 = 5, WD3 = 200, WE3 = 0 → x5 stays at 100.
Meanwhile, you can still read registers via A1 and A2.
*/
/////////////////////////////////////////////////////////////////

endmodule