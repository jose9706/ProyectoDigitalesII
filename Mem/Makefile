comp:
	iverilog test.v -o out.o
	vvp out.o
yosys:
	yosys script.ys 
	sed -i 's/data_out/synth_data_out/' synth_mem.v
	sed -i 's/valid_out/synth_valid_out/' synth_mem.v
	sed -i 's/err/synth_err/' synth_mem.v
	sed -i 's/module / module synth_/' synth_mem.v


autoinst_verilog: 
	emacs-tealeg --batch --no-site-file -l verilog-mode.el test.v -f verilog-auto -f save-buffer
