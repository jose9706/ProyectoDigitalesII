compilar:
		iverilog tx_tb.v -o result.o
		vvp result.o

yosys: 
	sudo yosys script.ys	
	sed -i 's/module tx/ module synth_tx/' synth_tx.v
	sed -i 's/fsm/synth_fsm/' synth_tx.v

ver: 
	gtkwave final.gtkw
	
