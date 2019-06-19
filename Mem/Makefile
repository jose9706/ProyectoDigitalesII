comp:
	iverilog test.v -o out.o
	vvp out.o
yosys:
	yosys script.ys 
	sed -i 's/module / module synth_/' synth_mem.v

autoinst_verilog: 
	emacs-tealeg --batch --no-site-file -l verilog-mode.el test.v -f verilog-auto -f save-buffer
