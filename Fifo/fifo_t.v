module fifo_t(
                output reg clk,
                output reg RESET_L,
                output reg [5:0] data_in,
                output reg fifo_rd,
                output reg fifo_wr,
                output reg [4:0] al_empty_in,
                output reg [4:0] al_full_in, 
                input fifo_empty,
                input fifo_full,
                input [5:0] data_out,
            //    input al_empty, 
            //    input al_full,
                input pause, 
                input valid_out);

    initial begin
        $dumpfile("fifo.vcd");
        $dumpvars;

        {RESET_L, data_in, fifo_rd, fifo_wr}<=0;

        al_empty_in<=2;
        al_full_in<=6; 


        @(posedge clk);
        RESET_L<=1;
        @(posedge clk);
        fifo_wr<=1;
        data_in<=6'b010010;
        @(posedge clk);
        fifo_wr<=0;
        fifo_rd<=1;
        @(posedge clk);
        fifo_rd <= 0;
        @(posedge clk);
        @(posedge clk);
        fifo_wr<=1;
        fifo_rd<=1;
        data_in<=6'b100100;
        @(posedge clk);
        data_in<=6'b110110;
        fifo_rd <= 1;
        @(posedge clk);
        data_in<=6'b010100;
        @(posedge clk);
        data_in<=6'b110000;
        @(posedge clk);
        fifo_wr<=0;
        fifo_rd<=1;
        data_in<='b0;
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        fifo_rd<=0;
        fifo_wr<=1;
        data_in<=6'b110010;
        @(posedge clk);
        data_in<=6'b010100;
        @(posedge clk);
        data_in<=6'b110101;
        @(posedge clk);
        data_in<=6'b010101;
        @(posedge clk);
        data_in<=6'b010110;
        @(posedge clk);
        data_in<=6'b100111;
        @(posedge clk);
        data_in<=6'b111111;
        @(posedge clk);
        data_in<=6'b000010;
        @(posedge clk);
        data_in<=6'b110000;
        @(posedge clk);
        fifo_wr<=0;
        @(posedge clk);
        fifo_rd<=1;
        data_in<='b0; 
        //Aqui iba el repeat antes
        /*repeat (9) begin
        @(posedge clk);
        end*/
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        fifo_rd<=1;
        fifo_wr<=1;
        data_in<='b1001011;
        @(posedge clk);
        data_in<='b1001111;
        @(posedge clk);
        data_in<='b1101111;
        @(posedge clk);
        data_in<='b1001100;
        @(posedge clk);
        data_in<='b1001110; //hasta aqui
        @(posedge clk); //probando error
        fifo_wr<=1;
        fifo_rd<=0;
        data_in<=6'b000000;
        @(posedge clk);
        data_in<=6'b000001;
        @(posedge clk);
        data_in<=6'b000010;
        @(posedge clk);
        data_in<=6'b000011;
        @(posedge clk);
        data_in<=6'b000100;
        @(posedge clk);
        data_in<=6'b000101;
        @(posedge clk);
        data_in<=6'b000110;
        @(posedge clk);
        data_in<=6'b000111;
        @(posedge clk);
        data_in<=6'b001000;
        @(posedge clk);
        data_in<=6'b001001;
        @(posedge clk);
        data_in<=6'b001010;

        //Probar si se pasa de los write
        @(posedge clk);
        fifo_wr<=1;
        fifo_rd<=0;
        data_in<=6'b001010;
        @(posedge clk);
        data_in<=6'b000010;
        @(posedge clk);
        data_in<=6'b000011;
        @(posedge clk);
        data_in<=6'b000100;
        @(posedge clk);
        data_in<=6'b000101;
        @(posedge clk);
        data_in<=6'b000110;
        @(posedge clk);
        data_in<=6'b000111;
        @(posedge clk);
        fifo_wr<=0;
        fifo_rd<=1;
        data_in<=6'b001000;
        @(posedge clk);
        data_in<=6'b001001;
        @(posedge clk);
        data_in<=6'b000100;
        @(posedge clk);
        data_in<=6'b000101;
        @(posedge clk);
        data_in<=6'b000110;
        //voy a vaciarlo tdo estando lleno a ver kerns
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

    initial clk <=0;
    always #2 clk <= ~clk;

endmodule 
