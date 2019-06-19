`include "pro.v"
`include "mem.v"
`include "synth_mem.v"
`include "cmos_cells.v"
module test;

parameter DATA_WIDTH = 6;
parameter ADDR_WIDTH =3;
	/*AUTOWIRE*/
	// Beginning of automatic wires (for undeclared instantiated-module outputs)
	wire		RESET_L;		// From B of pro.v
	wire [2:0]	address;		// From B of pro.v
	wire		clk;			// From B of pro.v
	wire [5:0]	data;			// From B of pro.v
	wire [DATA_WIDTH-1:0] data_out;		// From A of mem.v, ..., Couldn't Merge
	wire		err;			// From A of mem.v, ...
	wire		read;			// From B of pro.v
	wire		valid_out;		// From A of mem.v, ...
	wire		write;			// From B of pro.v
	// End of automatics


	mem A(/*AUTOINST*/
	      // Outputs
	      .data_out			(data_out[DATA_WIDTH-1:0]),
	      .valid_out		(valid_out),
	      .err			(err),
	      // Inputs
	      .clk			(clk),
	      .address			(address[ADDR_WIDTH-1:0]),
	      .write			(write),
	      .read			(read),
	      .data			(data[DATA_WIDTH-1:0]),
	      .RESET_L			(RESET_L));


	pro B(/*AUTOINST*/
	      // Outputs
	      .clk			(clk),
	      .RESET_L			(RESET_L),
	      .address			(address[2:0]),
	      .data			(data[5:0]),
	      .write			(write),
	      .read			(read));
	
   
   synth_mem F(/*AUTOINST*/
	       // Outputs
	       .data_out		(data_out[5:0]),
	       .err			(err),
	       .valid_out		(valid_out),
	       // Inputs
	       .RESET_L			(RESET_L),
	       .address			(address[2:0]),
	       .clk			(clk),
	       .data			(data[5:0]),
	       .read			(read),
	       .write			(write));
   

endmodule
