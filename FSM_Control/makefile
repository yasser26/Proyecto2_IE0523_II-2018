CC0=iverilog
CC1=yosys
TARGET0=cmos_cells.v
TARGET1=testbench.v
TARGET2=sintesis.ys
TARGET4=fsm_ControlEstructural.v


fsmControl: sintetizar compilar crearVCD compilarSynth
	gtkwave fsmControl.vcd gtkConfig.gtkw

	

compilar:
	$(CC0) $(TARGET1) -o fsmControl

crearVCD:
	vvp fsmControl

sintetizar:
	$(CC1) $(TARGET2)
	sed -i 's/fsmControl/fsmControlEstructural/g' fsm_ControlEstructural.v

compilarSynth:
	$(CC0) $(TARGET4) $(TARGET0) -o fsmControlEstructural
