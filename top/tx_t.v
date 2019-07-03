
module tx_t(
    input MAIN_PAUSE,
    output reg clk,
    output reg RESET_L,
    output reg PUSH_MAIN,
    output reg init,
    output reg POP_D0,
    output reg POP_D1,
    output reg [5:0] DATA_IN_TX,
    output reg [4:0] main_fifo_low,
    output reg [4:0] main_fifo_high,
    output reg [4:0] Vco_low,
    output reg [4:0] Vco_high,
    output reg [4:0] Vc1_low, 
    output reg [4:0] Vc1_high,
    output reg [4:0] Do_low,
    output reg [4:0] Do_high,
    output reg [4:0] D1_low,
    output reg [4:0] D1_high
);
    
    initial begin
        $dumpfile("result_tx.vcd");
        $dumpvars;
        {clk,RESET_L,PUSH_MAIN,init,POP_D0,POP_D1} <= 0;
        {DATA_IN_TX} <= 0;
        {main_fifo_high,main_fifo_low,Vco_high,Vco_low,Vc1_high,Vc1_low} <=0;
        {D1_high,D1_low,Do_low,Do_high} <= 0;
        @(posedge clk);
        RESET_L <= 1;
        @(posedge clk);
        main_fifo_low<='h1;
        main_fifo_high<='h3;
        
        Vco_low<='h3;
        Vco_high<='hC;

        Vc1_low<='h3;
        Vc1_high<='hC;

        Do_low<='h1;
        Do_high<='h3;

        D1_low<='h1;
        D1_high<='h3;
        @(posedge clk);
        DATA_IN_TX <= 'b001010;
        PUSH_MAIN <= 1;
        @(posedge clk);
        PUSH_MAIN <= 0;
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        DATA_IN_TX <= 'b111110;
        PUSH_MAIN <= 1;
        @(posedge clk);
        PUSH_MAIN <= 0;
        @(posedge clk);
        POP_D0<= 1;
        @(posedge clk);
        POP_D0 <= 0;
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        POP_D1<= 1;
        @(posedge clk);
        POP_D1 <= 0;
        @(posedge clk);
        @(posedge clk);
        @(posedge clk); //
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        DATA_IN_TX <= 'b001111;
        PUSH_MAIN <= 1;
        @(posedge clk);
        PUSH_MAIN <= 0;
        @(posedge clk);

        POP_D0<= 1;
        @(posedge clk);
        POP_D0 <= 0;
        @(posedge clk);
        DATA_IN_TX <= 'b011110;
        PUSH_MAIN <= 1;
        @(posedge clk);
        PUSH_MAIN <= 0;
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        PUSH_MAIN <= 0;
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        POP_D1<= 1;
        @(posedge clk);
        POP_D1 <= 0;
        @(posedge clk); ///
        @(posedge clk);
        @(posedge clk);
        DATA_IN_TX <= 'b011000;
        @(posedge clk);
        PUSH_MAIN <= 1;
        @(posedge clk);
        PUSH_MAIN <= 0;
        @(posedge clk);
        DATA_IN_TX <= 'b011000;
        @(posedge clk);
        PUSH_MAIN <= 1;
        @(posedge clk);
        PUSH_MAIN <= 0;
        @(posedge clk);
        POP_D0<= 1;
        @(posedge clk);
        POP_D0 <= 0;
        @(posedge clk);
        @(posedge clk);
        DATA_IN_TX <= 'b011111;
        PUSH_MAIN <= 1;
        @(posedge clk);
        PUSH_MAIN <= 0;
        @(posedge clk);
        @(posedge clk);
        DATA_IN_TX <= 'b010111;
        PUSH_MAIN <= 1;
        @(posedge clk);
    /*    PUSH_MAIN <= 0; //PRIMER TEST
        //PUSH_MAIN <= 0; //SUAVE PARA VER
        @(posedge clk);
        @(posedge clk);
        DATA_IN_TX <= 'b010001;
        PUSH_MAIN <= 0;
        @(posedge clk);
        DATA_IN_TX <= 'b010110;
        @(posedge clk);
        DATA_IN_TX <= 'b110111;
        @(posedge clk);
        @(posedge clk);
        PUSH_MAIN <= 1;
        @(posedge clk);
        PUSH_MAIN <= 0;
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);*/ //AQUI TERMINA EL OTRO TEST
        @(posedge clk);
        //EMPIEZA SEGUNDO TEST RARO 
        @(posedge clk);
        @(posedge clk);
        DATA_IN_TX <= 'b010001;
        @(posedge clk);
        DATA_IN_TX <= 'b010110;
        @(posedge clk);
        DATA_IN_TX <= 'b110111;
        @(posedge clk);
        POP_D1<= 1;
        @(posedge clk);
        POP_D1 <= 0;
        @(posedge clk);
        PUSH_MAIN <= 1;
        @(posedge clk);
        //PUSH_MAIN <= 0;  //es con este mae el detalle 
        @(posedge clk);
        @(posedge clk);
        @(posedge clk); //TERMINA SEGUNDO TEST 
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        POP_D0<= 1;
        @(posedge clk);
        POP_D0 <= 0;
        @(posedge clk);
        @(posedge clk);
        POP_D1<= 1;
        @(posedge clk);
        POP_D1 <= 0;
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        DATA_IN_TX <= 'b000011;
        PUSH_MAIN <= 1;
        @(posedge clk);
        PUSH_MAIN <= 0;
        @(posedge clk);
        @(posedge clk);
        POP_D0<= 1;
        @(posedge clk);
        POP_D0 <= 0;
        @(posedge clk);
        @(posedge clk); //otra pruebilla
        DATA_IN_TX <= 'b010111; //17
        PUSH_MAIN <= 1;
        @(posedge clk);
        PUSH_MAIN <= 0;
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        DATA_IN_TX <= 'b101111; //2F
        PUSH_MAIN <= 1;
        @(posedge clk);
        PUSH_MAIN <= 0;
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        POP_D1<= 1;
        @(posedge clk);
        POP_D1 <= 0;
        @(posedge clk);
        @(posedge clk);
        /*POP_D0<= 1;
        @(posedge clk);
        POP_D0 <= 0;*/
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        POP_D0<= 1;
        @(posedge clk);
        POP_D0 <= 0;
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);

        $finish;
    end


    initial clk   <= 0;
    always #2 clk <= ~clk;

endmodule // tx_t