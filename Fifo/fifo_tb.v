`include "fifo.v"
`include "fifo_t.v"


module fifo_tb; 


    /*AUTOWIRE*/
    // Beginning of automatic wires (for undeclared instantiated-module outputs)
    wire		RESET_L;		// From prob of fifo_t.v
    wire		clk;			// From prob of fifo_t.v
    wire [5:0]		data_in;		// From prob of fifo_t.v
    wire [5:0]		data_out;		// From fifo of fifo.v
    wire		err_full;		// From fifo of fifo.v
    wire		fifo_empty;		// From fifo of fifo.v
    wire		fifo_full;		// From fifo of fifo.v
    wire		fifo_rd;		// From prob of fifo_t.v
    wire		fifo_wr;		// From prob of fifo_t.v
    // End of automatics
   
    fifo fifo(/*AUTOINST*/
	      // Outputs
	      .fifo_empty		(fifo_empty),
	      .fifo_full		(fifo_full),
	      .data_out			(data_out[5:0]),
	      .err_full			(err_full),
	      // Inputs
	      .clk			(clk),
	      .RESET_L			(RESET_L),
	      .data_in			(data_in[5:0]),
	      .fifo_rd			(fifo_rd),
	      .fifo_wr			(fifo_wr));

    fifo_t prob(/*AUTOINST*/
		// Outputs
		.clk			(clk),
		.RESET_L		(RESET_L),
		.data_in		(data_in[5:0]),
		.fifo_rd		(fifo_rd),
		.fifo_wr		(fifo_wr),
		// Inputs
		.fifo_empty		(fifo_empty),
		.fifo_full		(fifo_full),
		.data_out		(data_out[5:0]),
		.err_full		(err_full));
    
endmodule 
