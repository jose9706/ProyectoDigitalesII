`include "tx.v"
`include "tx_t.v"
`include "synth_tx.v"
`include "cmos_cells.v"

module tx_tb;
   /*AUTOWIRE*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire [4:0]		D1_high;		// From probador of tx_t.v
   wire [4:0]		D1_low;			// From probador of tx_t.v
   wire [5:0]		DATA_IN_TX;		// From probador of tx_t.v
   wire [5:0]		DATA_OUT_D0;		// From proyecto of tx.v, ...
   wire [5:0]		DATA_OUT_D1;		// From proyecto of tx.v, ...
   wire [4:0]		Do_high;		// From probador of tx_t.v
   wire [4:0]		Do_low;			// From probador of tx_t.v
   wire			MAIN_PAUSE;		// From proyecto of tx.v, ...
   wire			POP_D0;			// From probador of tx_t.v
   wire			POP_D1;			// From probador of tx_t.v
   wire			PUSH_MAIN;		// From probador of tx_t.v
   wire			RESET_L;		// From probador of tx_t.v
   wire [4:0]		Vc1_high;		// From probador of tx_t.v
   wire [4:0]		Vc1_low;		// From probador of tx_t.v
   wire [4:0]		Vco_high;		// From probador of tx_t.v
   wire [4:0]		Vco_low;		// From probador of tx_t.v
   wire			clk;			// From probador of tx_t.v
   wire			init;			// From probador of tx_t.v
   wire [4:0]		main_fifo_high;		// From probador of tx_t.v
   wire [4:0]		main_fifo_low;		// From probador of tx_t.v
   // End of automatics
   
    tx proyecto(/*AUTOINST*/
		// Outputs
		.DATA_OUT_D0		(DATA_OUT_D0[5:0]),
		.DATA_OUT_D1		(DATA_OUT_D1[5:0]),
		.MAIN_PAUSE		(MAIN_PAUSE),
		// Inputs
		.clk			(clk),
		.RESET_L		(RESET_L),
		.PUSH_MAIN		(PUSH_MAIN),
		.init			(init),
		.POP_D0			(POP_D0),
		.POP_D1			(POP_D1),
		.DATA_IN_TX		(DATA_IN_TX[5:0]),
		.main_fifo_low		(main_fifo_low[4:0]),
		.main_fifo_high		(main_fifo_high[4:0]),
		.Vco_low		(Vco_low[4:0]),
		.Vco_high		(Vco_high[4:0]),
		.Vc1_low		(Vc1_low[4:0]),
		.Vc1_high		(Vc1_high[4:0]),
		.Do_low			(Do_low[4:0]),
		.Do_high		(Do_high[4:0]),
		.D1_low			(D1_low[4:0]),
		.D1_high		(D1_high[4:0]));


    tx_t probador(/*AUTOINST*/
		  // Outputs
		  .clk			(clk),
		  .RESET_L		(RESET_L),
		  .PUSH_MAIN		(PUSH_MAIN),
		  .init			(init),
		  .POP_D0		(POP_D0),
		  .POP_D1		(POP_D1),
		  .DATA_IN_TX		(DATA_IN_TX[5:0]),
		  .main_fifo_low	(main_fifo_low[4:0]),
		  .main_fifo_high	(main_fifo_high[4:0]),
		  .Vco_low		(Vco_low[4:0]),
		  .Vco_high		(Vco_high[4:0]),
		  .Vc1_low		(Vc1_low[4:0]),
		  .Vc1_high		(Vc1_high[4:0]),
		  .Do_low		(Do_low[4:0]),
		  .Do_high		(Do_high[4:0]),
		  .D1_low		(D1_low[4:0]),
		  .D1_high		(D1_high[4:0]),
		  // Inputs
		  .MAIN_PAUSE		(MAIN_PAUSE));

  synth_tx synth(/*AUTOINST*/
		 // Outputs
		 .DATA_OUT_D0		(DATA_OUT_D0[5:0]),
		 .DATA_OUT_D1		(DATA_OUT_D1[5:0]),
		 .MAIN_PAUSE		(MAIN_PAUSE),
		 // Inputs
		 .D1_high		(D1_high[4:0]),
		 .D1_low		(D1_low[4:0]),
		 .DATA_IN_TX		(DATA_IN_TX[5:0]),
		 .Do_high		(Do_high[4:0]),
		 .Do_low		(Do_low[4:0]),
		 .POP_D0		(POP_D0),
		 .POP_D1		(POP_D1),
		 .PUSH_MAIN		(PUSH_MAIN),
		 .RESET_L		(RESET_L),
		 .Vc1_high		(Vc1_high[4:0]),
		 .Vc1_low		(Vc1_low[4:0]),
		 .Vco_high		(Vco_high[4:0]),
		 .Vco_low		(Vco_low[4:0]),
		 .clk			(clk),
		 .init			(init),
		 .main_fifo_high	(main_fifo_high[4:0]),
		 .main_fifo_low		(main_fifo_low[4:0]));
   

endmodule // tx_tb
