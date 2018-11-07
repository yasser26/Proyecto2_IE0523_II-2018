all:	testbench.v
	yosys yosys.ys
	sed -i 's/memoria/memoriaSynth/g' memoriaSynth.v
	iverilog testbench.v
	vvp a.out
	gtkwave dump.vcd dump.gtkw

clean:
	rm synth.v *.vcd 
