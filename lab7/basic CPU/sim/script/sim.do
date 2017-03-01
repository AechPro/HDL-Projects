vlib work
vmap altera_mf ../../src/altera_mf
vcom -93 -work work ../../src/alu/alu_components.vhd
vcom -93 -work work ../../src/alu/generic_adder_beh.vhd
vcom -93 -work work ../../src/alu/generic_subtractor_beh.vhd
vcom -93 -work work ../../src/alu/generic_multiplier_beh.vhd
vcom -93 -work work ../../src/alu/generic_divider_beh.vhd
vcom -93 -work work ../../src/alu/generic_and_beh.vhd
vcom -93 -work work ../../src/alu/generic_or_beh.vhd
vcom -93 -work work ../../src/alu/generic_not_beh.vhd
vcom -93 -work work ../../src/alu/generic_xor_beh.vhd
vcom -93 -work work ../../src/alu/alu.vhd
vcom -93 -work work ../../src/top.vhd
vcom -93 -work work ../../src/seven_seg.vhd
vcom -93 -work work ../../src/memory/src/memory.vhd
vcom -93 -work work ../../src/generic_counter.vhd
vcom -93 -work work ../../src/ROM/ROM.vhd
vcom -93 -work work ../src/CPU_tb.vhd
vsim -novopt -msgmode both CPU_tb
do wave.do
run 30000 ns
