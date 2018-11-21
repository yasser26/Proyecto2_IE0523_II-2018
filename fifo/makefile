all:	testbench.v
	yosys yosys.ys
	sed -i 's/fifo/fifoSynth/g' fifoSynth.v
	sed -i 's/memoria/memoriaSynth/g' fifoSynth.v
	iverilog testbench.v
	vvp a.out
	gtkwave fifo.vcd fifo.gtkw

clean:
	rm synth.v *.vcd 
