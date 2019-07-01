`include "fifo.v"
`include "synth_fifo.v"
`include "cmos_cells.v"
`include "fifo_t.v"


module fifo_tb; 


    /*AUTOWIRE*/
    // Beginning of automatic wires (for undeclared instantiated-module outputs)
    wire		RESET_L;		// From prob of fifo_t.v
    wire		al_empty;		// From fifo of fifo.v, ...
    wire		al_empty_in;		// From prob of fifo_t.v
    wire		al_full;		// From fifo of fifo.v, ...
    wire		al_full_in;		// From prob of fifo_t.v
    wire		clk;			// From prob of fifo_t.v
    wire [5:0]		data_in;		// From prob of fifo_t.v
    wire [5:0]		data_out;		// From fifo of fifo.v, ...
    wire		err_fifo;		// From fifo of fifo.v, ...
    wire		fifo_empty;		// From fifo of fifo.v, ...
    wire		fifo_full;		// From fifo of fifo.v, ...
    wire		fifo_rd;		// From prob of fifo_t.v
    wire		fifo_wr;		// From prob of fifo_t.v
    // End of automatics
   
    fifo fifo(/*AUTOINST*/
	      // Outputs
	      .fifo_empty		(fifo_empty),
	      .fifo_full		(fifo_full),
	      .data_out			(data_out[5:0]),
	      .err_fifo			(err_fifo),
	      .al_empty			(al_empty),
	      .al_full			(al_full),
	      // Inputs
	      .clk			(clk),
	      .RESET_L			(RESET_L),
	      .data_in			(data_in[5:0]),
	      .fifo_rd			(fifo_rd),
	      .fifo_wr			(fifo_wr),
	      .al_empty_in		(al_empty_in),
	      .al_full_in		(al_full_in));

    fifo_t prob(/*AUTOINST*/
		// Outputs
		.clk			(clk),
		.RESET_L		(RESET_L),
		.data_in		(data_in[5:0]),
		.fifo_rd		(fifo_rd),
		.fifo_wr		(fifo_wr),
		.al_full_in		(al_full_in),
		.al_empty_in		(al_empty_in),
		// Inputs
		.fifo_empty		(fifo_empty),
		.fifo_full		(fifo_full),
		.data_out		(data_out[5:0]),
		.al_full		(al_full),
		.al_empty		(al_empty));

    synth_fifo synth(/*AUTOINST*/
		     // Outputs
		     .al_empty		(al_empty),
		     .al_full		(al_full),
		     .data_out		(data_out[5:0]),
		     .err_fifo		(err_fifo),
		     .fifo_empty	(fifo_empty),
		     .fifo_full		(fifo_full),
		     // Inputs
		     .RESET_L		(RESET_L),
		     .al_empty_in	(al_empty_in),
		     .al_full_in	(al_full_in),
		     .clk		(clk),
		     .data_in		(data_in[5:0]),
		     .fifo_rd		(fifo_rd),
		     .fifo_wr		(fifo_wr)); 
    
endmodule 
