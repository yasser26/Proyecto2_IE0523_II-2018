CC0=iverilog
CC1=yosys
TARGET0=cmos_cells.v
TARGET1=testbench.v
TARGET2=sintesis.ys
TARGET4=roundRobinEstructural.v


fsmControl: sintetizar compilar crearVCD compilarSynth
	gtkwave round_robin.vcd gtkConfig.gtkw

	

compilar:
	$(CC0) $(TARGET1) -o roundRobin

crearVCD:
	vvp roundRobin

sintetizar:
	$(CC1) $(TARGET2)
	sed -i 's/roundRobin/roundRobinEstructural/g' roundRobinEstructural.v

compilarSynth:
	$(CC0) $(TARGET4) $(TARGET0) -o roundRobinEstructural
