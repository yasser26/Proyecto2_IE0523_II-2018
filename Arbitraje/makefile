CC0=iverilog
CC1=yosys
TARGET0=cmos_cells.v
TARGET1=testbench.v
TARGET2=sintesis.ys
TARGET4=arbitroEstructural.v


fsmControl: sintetizar compilar crearVCD compilarSynth
	gtkwave test.vcd gtkConfig.gtkw

	

compilar:
	$(CC0) $(TARGET1) -o arbitro

crearVCD:
	vvp arbitro

sintetizar:
	$(CC1) $(TARGET2)
	sed -i 's/arbitro/arbitroEstructural/g' arbitroEstructural.v
	sed -i 's/roundRobin/roundRobinEstructural/g' arbitroEstructural.v

compilarSynth:
	$(CC0) $(TARGET4) $(TARGET0) -o arbitroEstructural
