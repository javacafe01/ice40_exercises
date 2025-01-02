PROJ      = blinky
BUILD     = ./build
DEVICE    = 1k
FOOTPRINT = ct256

FILES = top.v

.PHONY: all clean burn timing

all $(BUILD)/$(PROJ).asc $(BUILD)/$(PROJ).bin:
	mkdir -p $(BUILD)
	# Synthesize using Yosys
	yosys -p "synth_ice40 -top top -blif $(BUILD)/$(PROJ).blif -json $(BUILD)/$(PROJ).json" $(FILES)
	# Place and route using nextpnr
	nextpnr-ice40 --hx$(DEVICE) --json build/$(PROJ).json --package vq100 --pcf pinmap.pcf --asc build/$(PROJ).asc --placed-svg "build/placed.svg" --routed-svg "build/routed.svg"
	# Convert to bitstream using icepack
	icepack $(BUILD)/$(PROJ).asc $(BUILD)/$(PROJ).bin

burn: $(BUILD)/$(PROJ).bin
	iceprog $(BUILD)/$(PROJ).bin

timing: $(BUILD)/$(PROJ).asc
	icetime -tmd hx$(DEVICE) $(BUILD)/$(PROJ).asc

clean:
	rm build/*
