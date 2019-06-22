module fsm_prob(output reg clk,
                output reg reset,
                output reg init,
                output reg [4:0] main_fifo_low,
                output reg [4:0] main_fifo_high,
                output reg [4:0] Vco_low,
                output reg [4:0] Vco_high,
                output reg [4:0] Vc1_low, 
                output reg [4:0] Vc1_high,
                output reg [4:0] Do_low,
                output reg [4:0] Do_high,
                output reg [4:0] D1_low,
                output reg [4:0] D1_high, 
                output reg [4:0]empties,
                output reg [4:0]errors 
                );

    initial begin
        $dumpfile("fsm.vcd");
        $dumpvars;
        {empties, reset, errors, init, main_fifo_low, main_fifo_high, Vco_low, Vco_high, Vc1_low, Vc1_high, Do_low, Do_high, D1_low, D1_high} <=0;
        @(posedge clk); 
        reset <= 1;
        @(posedge clk);
        main_fifo_low<='h3;
        Vc1_low<='hA;
        Vco_low<='hB;
        Do_low<='hC;
        D1_low<='hD;
<<<<<<< HEAD
        @(posedge clk);
        init<=0;
=======
>>>>>>> 6cbb4b1fdcb36a91af406c8b163a3f1cc1c8d046
        main_fifo_high<='h6;
        Vc1_high<='h7;
        Vco_high<='h8;
        Do_high<='h9;
        D1_high<='hA;
        @(posedge clk);

        @(posedge clk);
        @(posedge clk);
        empties <= 1;
        @(posedge clk);
        {main_fifo_low, main_fifo_high, Vco_low, Vco_high, Vc1_low, Vc1_high, Do_low, Do_high, D1_low, D1_high} <=0;
        @(posedge clk);
        errors <=1;
        @(posedge clk);
        @(posedge clk);
        reset<=0;
        @(posedge clk);
        reset<=1;
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        $finish;
    end



    initial clk <=0;
    always #2 clk <= ~clk;


endmodule