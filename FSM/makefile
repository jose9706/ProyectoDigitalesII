comp:
	iverilog fsm_tb.v -o result.o
	vvp result.o
yosys:
	yosys script.ys 
	sed -i 's/mf_l/synth_mf_l/' synth_fsm.v
	sed -i 's/mf_h/synth_mf_h/' synth_fsm.v
	sed -i 's/vco_l/synth_vco_l/' synth_fsm.v
	sed -i 's/module / module synth_/' synth_fsm.v
	sed -i 's/vco_h/synth_vco_h/' synth_fsm.v
	sed -i 's/vc1_l/synth_vc1_l/' synth_fsm.v
	sed -i 's/vc1_h/synth_vc1_h/' synth_fsm.v
	sed -i 's/do_l/synth_do_l/' synth_fsm.v
	sed -i 's/do_h/synth_do_h/' synth_fsm.v
	sed -i 's/d1_l/synth_d1_l/' synth_fsm.v
	sed -i 's/d1_h/synth_d1_h/' synth_fsm.v
	sed -i 's/error_out/synth_error_out/' synth_fsm.v
	sed -i 's/active_out/synth_active_out/' synth_fsm.v
	sed -i 's/idle_out/synth_idle_out/' synth_fsm.v