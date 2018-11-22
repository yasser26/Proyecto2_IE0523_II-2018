all:	testbench.v
	yosys yosys.ys
	sed -i 's/PCIE_trans/PCIE_Synth/' PCIE_Synth.v
	sed -i 's/memoria/memoria_Synth/' PCIE_Synth.v
	sed -i 's/roundRobin/roundRobin_Synth/' PCIE_Synth.v
	sed -i 's/arbitro/arbitroSynth/' PCIE_Synth.v
	sed -i 's/FIFO_mod/FIFOSynth/' PCIE_Synth.v
	sed -i 's/fsmControl/fsmControlSynth/' PCIE_Synth.v
	iverilog testbench.v
	vvp a.out
	gtkwave pcie.vcd final.gtkw

clean:
	rm synth.v *.vcd 
