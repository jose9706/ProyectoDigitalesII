module probador(
		output reg  clk,
		output reg  reset_L,
		output reg  init,
		output reg [4:0] in_almost_full,
        output reg [4:0] in_almost_empty,
        output reg [4:0] FIFO_empty,
        output reg [4:0] FIFO_error,
		input [4:0] out_almost_full,
        input [4:0] out_almost_empty,
        input error_out,
        input active_out,
        input idle_out);
      
	

   initial begin
      $dumpfile("dump.vcd");
      $dumpvars;
      
      {init, reset_L, in_almost_full, in_almost_empty, FIFO_empty, FIFO_error} <= 'b0;

      @(posedge clk);
      
      @(posedge clk);
      reset_L<=1;

      @(posedge clk);
      enable <=1;
      
      

      repeat(500) begin
	 @(posedge clk);
      end
      @(posedge clk);
      
      @(posedge clk);

      @(posedge clk);

             
      
      $finish;
      
   end
   
   initial clk<=0;
   
   always	#1 clk	<= ~clk;
   
endmodule
