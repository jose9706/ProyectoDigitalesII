module fifo_t(
                output reg clk,
                output reg RESET_L,
                output reg [5:0] data_in,
                output reg fifo_rd,
                output reg fifo_wr,
                input fifo_empty,
                input fifo_full,
                input [5:0] data_out,
                input err_full);

    initial begin
        $dumpfile("fifo.vcd");
        $dumpvars;

        {RESET_L, data_in, fifo_rd, fifo_wr}<=0;

        @(posedge clk);
        RESET_L<=1;
        @(posedge clk);
        fifo_wr<=1;
        data_in<=6'b010010;
        @(posedge clk);
        fifo_wr<=0;
        fifo_rd<=1;
        @(posedge clk);
        fifo_wr<=1;
        fifo_rd<=0;
        data_in<=6'b100100;
        @(posedge clk);
        data_in<=6'b110110;
        @(posedge clk);
        data_in<=6'b010100;
        @(posedge clk);
        data_in<=6'b110000;
        @(posedge clk);
        fifo_wr<=0;
        fifo_rd<=1;
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
        fifo_wr<=0;
        @(posedge clk);
        fifo_rd<=1;
        repeat (9) begin
        @(posedge clk);
        end


        $finish;
    end

    initial clk <=0;
    always #2 clk <= ~clk;

endmodule 
