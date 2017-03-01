onerror {resume}
radix define States {
    "3'b000" "DISPLAY" -color "yellow",
    "3'b001" "EXECUTE" -color "yellow",
    "3'b010" "MS" -color "yellow",
    "3'b011" "WR_SAVE" -color "yellow",
    "3'b100" "MR" -color "yellow",
    "3'b101" "CLEAR" -color "yellow",
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
add wave -noupdate -radix binary -radixshowbase 0 /cpu_tb/uut/clk
add wave -noupdate -radix binary -radixshowbase 0 /cpu_tb/uut/reset
add wave -noupdate -radix binary -radixshowbase 0 /cpu_tb/uut/execute_btn
add wave -noupdate -radix SSD_States -radixshowbase 0 /cpu_tb/uut/display_one
add wave -noupdate -radix SSD_States -radixshowbase 0 /cpu_tb/uut/display_two
add wave -noupdate -radix SSD_States -radixshowbase 0 /cpu_tb/uut/display_three
add wave -noupdate -radix binary -radixshowbase 0 /cpu_tb/uut/state_LEDS
add wave -noupdate -radix binary -radixshowbase 0 /cpu_tb/uut/RAM_in
add wave -noupdate -radix binary -radixshowbase 0 /cpu_tb/uut/RAM_out
add wave -noupdate -radix binary -radixshowbase 0 /cpu_tb/uut/RAM_address
add wave -noupdate -radix binary -radixshowbase 0 /cpu_tb/uut/RAM_write
add wave -noupdate -radix Opcode -radixshowbase 0 /cpu_tb/uut/alu_operation
add wave -noupdate -radix unsigned -radixshowbase 0 /cpu_tb/uut/alu_result
add wave -noupdate -radix binary -radixshowbase 0 /cpu_tb/uut/dabble_value_sync
add wave -noupdate -radix binary -radixshowbase 0 /cpu_tb/uut/dabble_value
add wave -noupdate -radix States -radixshowbase 0 /cpu_tb/uut/next_state
add wave -noupdate -radix States -radixshowbase 0 /cpu_tb/uut/current_state
add wave -noupdate -radix binary -radixshowbase 0 /cpu_tb/uut/not_reset
add wave -noupdate -radix binary -radixshowbase 0 /cpu_tb/uut/state_logic_flags
add wave -noupdate -radix binary -radixshowbase 0 /cpu_tb/uut/state_process_trigger
add wave -noupdate -radix binary -radixshowbase 0 /cpu_tb/uut/instruction_sync
add wave -noupdate -radix binary -radixshowbase 0 /cpu_tb/uut/execute_sync
add wave -noupdate -radix binary -radixshowbase 0 /cpu_tb/uut/ROM_addr
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {29678 ns} 0}
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
WaveRestoreZoom {29605 ns} {30021 ns}
