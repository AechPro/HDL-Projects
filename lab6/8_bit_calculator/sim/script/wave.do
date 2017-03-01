onerror {resume}
radix define States {
    "3'b000" "DISPLAY" -color "yellow",
    "3'b001" "EXECUTE" -color "yellow",
    "3'b010" "MS" -color "yellow",
    "3'b100" "MR" -color "yellow",
    "3'b110" "MEM_WRITE" -color "yellow",
    -default default
}
radix define Opcode {
    "3'b000" "ADD" -color "blue",
    "3'b001" "SUBTRACT" -color "blue",
    "3'b010" "MULTIPLY" -color "blue",
    "3'b011" "DIVIDE" -color "blue",
    "3'b100" "AND" -color "blue",
    "3'b101" "OR" -color "blue",
    "3'b110" "NOT" -color "blue",
    "3'b111" "XOR" -color "blue",
    -default default
}
radix define SSD_States {
    "7'b1111111" "OFF" -color "red",
    "7'b1000000" "0" -color "red",
    "7'b1111001" "1" -color "red",
    "7'b0100100" "2" -color "red",
    "7'b0110000" "3" -color "red",
    "7'b0011001" "4" -color "red",
    "7'b0010010" "5" -color "red",
    "7'b0000010" "6" -color "red",
    "7'b1111000" "7" -color "red",
    "7'b0000000" "8" -color "red",
    "7'b0010000" "9" -color "red",
    "7'b0001000" "A" -color "red",
    "7'b0000011" "b" -color "red",
    "7'b1000110" "c" -color "red",
    "7'b0100001" "d" -color "red",
    "7'b0000110" "E" -color "red",
    "7'b0001110" "F" -color "red",
    -default default
}
quietly WaveActivateNextPane {} 0
add wave -noupdate /calc_tb/clk
add wave -noupdate /calc_tb/reset
add wave -noupdate -radix SSD_States -radixshowbase 0 /calc_tb/SSD1
add wave -noupdate -radix SSD_States -radixshowbase 0 /calc_tb/SSD2
add wave -noupdate -radix SSD_States -radixshowbase 0 /calc_tb/SSD3
add wave -noupdate -expand -group UUT -radix binary -radixshowbase 0 /calc_tb/uut/button_input
add wave -noupdate -expand -group UUT -radix binary -radixshowbase 0 /calc_tb/uut/button_input_synced
add wave -noupdate -expand -group UUT -radix binary -radixshowbase 0 /calc_tb/uut/op_input
add wave -noupdate -expand -group UUT -radix binary -radixshowbase 0 /calc_tb/uut/alu_operation
add wave -noupdate -expand -group UUT -radix unsigned -radixshowbase 0 /calc_tb/uut/switch_input
add wave -noupdate -expand -group UUT -radix unsigned -radixshowbase 0 /calc_tb/uut/synced_switches
add wave -noupdate -expand -group UUT -radix unsigned -radixshowbase 0 /calc_tb/uut/RAM_in
add wave -noupdate -expand -group UUT -radix unsigned -radixshowbase 0 /calc_tb/uut/RAM_out
add wave -noupdate -expand -group UUT -radix binary -radixshowbase 0 /calc_tb/uut/RAM_address
add wave -noupdate -expand -group UUT -radix unsigned -radixshowbase 0 /calc_tb/uut/RAM_write
add wave -noupdate -expand -group UUT -radix unsigned -radixshowbase 0 /calc_tb/uut/alu_result
add wave -noupdate -expand -group UUT -color {Violet Red} -radix unsigned -radixshowbase 0 /calc_tb/uut/dabble_value
add wave -noupdate -expand -group UUT -color {Violet Red} -radix unsigned -radixshowbase 0 /calc_tb/uut/dabble_value_sync
add wave -noupdate -expand -group UUT -radix unsigned -radixshowbase 0 /calc_tb/uut/left_display_input
add wave -noupdate -expand -group UUT -radix unsigned -radixshowbase 0 /calc_tb/uut/center_display_input
add wave -noupdate -expand -group UUT -radix unsigned -radixshowbase 0 /calc_tb/uut/right_display_input
add wave -noupdate -expand -group UUT -radix States -radixshowbase 0 /calc_tb/uut/current_state
add wave -noupdate -expand -group UUT -radix States -radixshowbase 0 /calc_tb/uut/next_state
add wave -noupdate -expand -group UUT -radix binary -radixshowbase 0 /calc_tb/uut/state_LEDS
add wave -noupdate -expand -group ALU -radix unsigned -radixshowbase 0 /calc_tb/uut/calculation_unit/saturation_value
add wave -noupdate -expand -group ALU -radix Opcode -radixshowbase 0 /calc_tb/uut/calculation_unit/op
add wave -noupdate -expand -group ALU -radix unsigned -radixshowbase 0 /calc_tb/uut/calculation_unit/a
add wave -noupdate -expand -group ALU -radix unsigned -radixshowbase 0 /calc_tb/uut/calculation_unit/b
add wave -noupdate -expand -group ALU -radix unsigned -radixshowbase 0 /calc_tb/uut/calculation_unit/result
add wave -noupdate -expand -group ALU -radix unsigned -radixshowbase 0 /calc_tb/uut/calculation_unit/adder_result
add wave -noupdate -expand -group ALU -radix unsigned -radixshowbase 0 /calc_tb/uut/calculation_unit/subtractor_result
add wave -noupdate -expand -group ALU -radix unsigned -radixshowbase 0 /calc_tb/uut/calculation_unit/mult_result
add wave -noupdate -expand -group ALU -radix unsigned -radixshowbase 0 /calc_tb/uut/calculation_unit/div_result
add wave -noupdate -expand -group ALU -radix unsigned -radixshowbase 0 /calc_tb/uut/calculation_unit/internal_result
add wave -noupdate -expand -group ALU -radix unsigned -radixshowbase 0 /calc_tb/uut/calculation_unit/padder
add wave -noupdate -expand -group MEM /calc_tb/uut/RAM_block/clk
add wave -noupdate -expand -group MEM /calc_tb/uut/RAM_block/we
add wave -noupdate -expand -group MEM -radix unsigned -radixshowbase 0 /calc_tb/uut/RAM_block/addr
add wave -noupdate -expand -group MEM -radix unsigned -radixshowbase 0 /calc_tb/uut/RAM_block/din
add wave -noupdate -expand -group MEM -radix unsigned -radixshowbase 0 /calc_tb/uut/RAM_block/dout
add wave -noupdate -expand -group MEM -radix unsigned -childformat {{/calc_tb/uut/RAM_block/RAM(3) -radix unsigned} {/calc_tb/uut/RAM_block/RAM(2) -radix unsigned} {/calc_tb/uut/RAM_block/RAM(1) -radix unsigned} {/calc_tb/uut/RAM_block/RAM(0) -radix unsigned}} -radixshowbase 0 -expand -subitemconfig {/calc_tb/uut/RAM_block/RAM(3) {-height 15 -radix unsigned -radixshowbase 0} /calc_tb/uut/RAM_block/RAM(2) {-height 15 -radix unsigned -radixshowbase 0} /calc_tb/uut/RAM_block/RAM(1) {-height 15 -radix unsigned -radixshowbase 0} /calc_tb/uut/RAM_block/RAM(0) {-height 15 -radix unsigned -radixshowbase 0}} /calc_tb/uut/RAM_block/RAM
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {140 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 247
configure wave -valuecolwidth 56
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {416 ns}
