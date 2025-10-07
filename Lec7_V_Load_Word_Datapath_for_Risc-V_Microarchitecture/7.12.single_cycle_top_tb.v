`include "7.11.single_cycle_top.v"

module Single_Cycle_Top_tb ();
    
    reg clk = 1'b1, rst;

    Single_Cycle_Top S_C_T(
                    .clk(clk),
                    .rst(rst)
    );

    initial begin
        $dumpfile("Single Cycle.vcd");
        $dumpvars(0);
    end

    always begin
        clk = ~clk;
        #50;
    end

    initial begin
        rst = 1'b0;
        #150;

        rst = 1'b1;
        #500;
        $finish;
    end


endmodule