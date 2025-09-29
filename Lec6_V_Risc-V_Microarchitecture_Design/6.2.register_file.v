module register_file(A1, A2, A3, WD3, CLK, WE3, RD1, RD2, rst);

    // suppose 'add x3, x1, x2', here, x1 -> A1, x2 -> A2, x3 -> A3
    input [4:0] A1, A2, A3;
    input [31:0] WD3;
    input CLK, rst, WE3;

    output [31:0] RD1, RD2;

    // creation of memory
    reg [31:0] Registers [31:0]; // first [31:0] -> size of each Registers, last [31:0] -> amount of Registers.

    // read functionality
    assign RD1 = (!rst) ? 32'h00000000 : Registers[A1];
    assign RD2 = (!rst) ? 32'h00000000 : Registers[A2];

    always @(posedge CLK)
        begin
            if(WE3)
                begin
                    Registers[A3] <= WD3;
                end
        end

endmodule