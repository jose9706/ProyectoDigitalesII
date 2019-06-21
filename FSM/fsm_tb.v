`include "fsm.v"
`include "fsm_prob.v"


module fsm_tb; 


    /*AUTOWIRE*/
    // Beginning of automatic wires (for undeclared instantiated-module outputs)
    wire [4:0]		D1_high;		// From master of fsm_prob.v
    wire [4:0]		D1_low;			// From master of fsm_prob.v
    wire [4:0]		Do_high;		// From master of fsm_prob.v
    wire [4:0]		Do_low;			// From master of fsm_prob.v
    wire [4:0]		Vc1_high;		// From master of fsm_prob.v
    wire [4:0]		Vc1_low;		// From master of fsm_prob.v
    wire [4:0]		Vco_high;		// From master of fsm_prob.v
    wire [4:0]		Vco_low;		// From master of fsm_prob.v
    wire		active_out;		// From slave of fsm.v
    wire		clk;			// From master of fsm_prob.v
    wire [4:0]		d1_h;			// From slave of fsm.v
    wire [4:0]		d1_l;			// From slave of fsm.v
    wire [4:0]		do_h;			// From slave of fsm.v
    wire [4:0]		do_l;			// From slave of fsm.v
    wire [4:0]		empties;		// From master of fsm_prob.v
    wire		error_out;		// From slave of fsm.v
    wire [4:0]		errors;			// From master of fsm_prob.v
    wire		idle_out;		// From slave of fsm.v
    wire		init;			// From master of fsm_prob.v
    wire [4:0]		main_fifo_high;		// From master of fsm_prob.v
    wire [4:0]		main_fifo_low;		// From master of fsm_prob.v
    wire [4:0]		mf_h;			// From slave of fsm.v
    wire [4:0]		mf_l;			// From slave of fsm.v
    wire		reset;			// From master of fsm_prob.v
    wire [4:0]		vc1_h;			// From slave of fsm.v
    wire [4:0]		vc1_l;			// From slave of fsm.v
    wire [4:0]		vco_h;			// From slave of fsm.v
    wire [4:0]		vco_l;			// From slave of fsm.v
    // End of automatics
   
    fsm slave(/*AUTOINST*/
	      // Outputs
	      .error_out		(error_out),
	      .active_out		(active_out),
	      .idle_out			(idle_out),
	      .mf_l			(mf_l[4:0]),
	      .mf_h			(mf_h[4:0]),
	      .vco_l			(vco_l[4:0]),
	      .vco_h			(vco_h[4:0]),
	      .vc1_l			(vc1_l[4:0]),
	      .vc1_h			(vc1_h[4:0]),
	      .do_l			(do_l[4:0]),
	      .do_h			(do_h[4:0]),
	      .d1_l			(d1_l[4:0]),
	      .d1_h			(d1_h[4:0]),
	      // Inputs
	      .clk			(clk),
	      .reset			(reset),
	      .init			(init),
	      .main_fifo_low		(main_fifo_low[4:0]),
	      .main_fifo_high		(main_fifo_high[4:0]),
	      .Vco_low			(Vco_low[4:0]),
	      .Vco_high			(Vco_high[4:0]),
	      .Vc1_low			(Vc1_low[4:0]),
	      .Vc1_high			(Vc1_high[4:0]),
	      .Do_low			(Do_low[4:0]),
	      .Do_high			(Do_high[4:0]),
	      .D1_low			(D1_low[4:0]),
	      .D1_high			(D1_high[4:0]),
	      .empties			(empties[4:0]),
	      .errors			(errors[4:0]));

    fsm_prob master(/*AUTOINST*/
		    // Outputs
		    .clk		(clk),
		    .reset		(reset),
		    .init		(init),
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
		    .empties		(empties[4:0]),
		    .errors		(errors[4:0]));
    





endmodule 
