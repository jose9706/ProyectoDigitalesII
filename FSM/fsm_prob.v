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
        {main_fifo_low, main_fifo_high} <=0;
        {Vco_low, Vco_high} <= 0;
        {Vc1_low, Vc1_high} <=0;
        {Do_low, Do_high} <= 1;
        {D1_low, D1_high} <=2;
        empties <= 0;
        errors<=0;
        reset <= 0; 
        init <= 0;
        @(posedge clk); 
        reset <= 1;
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        empties <= 1;
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        $finish;
    end



    initial clk <=0;
    always #2 clk <= ~clk;


endmodule