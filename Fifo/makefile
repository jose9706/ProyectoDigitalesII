comp:
	iverilog fifo_tb.v -o result.o
	vvp result.o
yosys:
	sudo yosys script.ys
	#sed -i 's/fifo_empty/synth_fifo_empty/' synth_fifo.v
	#sed  -i 's/fifo_full/synth_fifo_full/' synth_fifo.v
	#sed -i 's/err_full/synth_err_full/' synth_fifo.v
	#sed -i 's/data_out/synth_data_out/' synth_fifo.v	
	#sed -i 's/module fifo/ module synth_fifo/' synth_fifo.v
	
