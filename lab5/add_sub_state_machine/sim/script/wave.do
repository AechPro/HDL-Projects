onerror {resume}
radix define States {
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
add wave -noupdate /counter_display_tb/uut/clk
add wave -noupdate /counter_display_tb/uut/reset
add wave -noupdate /counter_display_tb/uut/enable
add wave -noupdate /counter_display_tb/uut/add_button
add wave -noupdate /counter_display_tb/uut/subtract_button
add wave -noupdate /counter_display_tb/uut/add_sub_flag
add wave -noupdate -radix unsigned /counter_display_tb/uut/input_a
add wave -noupdate -radix unsigned /counter_display_tb/uut/input_b
add wave -noupdate /counter_display_tb/uut/adder_cout
add wave -noupdate -radix unsigned -childformat {{/counter_display_tb/uut/input_a_padded(3) -radix binary} {/counter_display_tb/uut/input_a_padded(2) -radix binary} {/counter_display_tb/uut/input_a_padded(1) -radix binary} {/counter_display_tb/uut/input_a_padded(0) -radix binary}} -subitemconfig {/counter_display_tb/uut/input_a_padded(3) {-height 15 -radix binary} /counter_display_tb/uut/input_a_padded(2) {-height 15 -radix binary} /counter_display_tb/uut/input_a_padded(1) {-height 15 -radix binary} /counter_display_tb/uut/input_a_padded(0) {-height 15 -radix binary}} /counter_display_tb/uut/input_a_padded
add wave -noupdate -radix unsigned -childformat {{/counter_display_tb/uut/input_b_padded(3) -radix binary} {/counter_display_tb/uut/input_b_padded(2) -radix binary} {/counter_display_tb/uut/input_b_padded(1) -radix binary} {/counter_display_tb/uut/input_b_padded(0) -radix binary}} -subitemconfig {/counter_display_tb/uut/input_b_padded(3) {-height 15 -radix binary} /counter_display_tb/uut/input_b_padded(2) {-height 15 -radix binary} /counter_display_tb/uut/input_b_padded(1) {-height 15 -radix binary} /counter_display_tb/uut/input_b_padded(0) {-height 15 -radix binary}} /counter_display_tb/uut/input_b_padded
add wave -noupdate /counter_display_tb/uut/adder_cin
add wave -noupdate -radix unsigned -childformat {{/counter_display_tb/uut/adder_result(3) -radix binary} {/counter_display_tb/uut/adder_result(2) -radix binary} {/counter_display_tb/uut/adder_result(1) -radix binary} {/counter_display_tb/uut/adder_result(0) -radix binary}} -subitemconfig {/counter_display_tb/uut/adder_result(3) {-height 15 -radix binary} /counter_display_tb/uut/adder_result(2) {-height 15 -radix binary} /counter_display_tb/uut/adder_result(1) {-height 15 -radix binary} /counter_display_tb/uut/adder_result(0) {-height 15 -radix binary}} /counter_display_tb/uut/adder_result
add wave -noupdate -radix unsigned /counter_display_tb/uut/subtractor_result
add wave -noupdate /counter_display_tb/uut/subtractor_cin
add wave -noupdate /counter_display_tb/uut/subtractor_cout
add wave -noupdate -radix States /counter_display_tb/uut/left_display_output
add wave -noupdate -radix States /counter_display_tb/uut/center_display_output
add wave -noupdate -radix States /counter_display_tb/uut/right_display_output
add wave -noupdate -radix binary /counter_display_tb/uut/bcd_result
add wave -noupdate -radix States /counter_display_tb/uut/display_one
add wave -noupdate -radix States /counter_display_tb/uut/display_two
add wave -noupdate -radix States /counter_display_tb/uut/display_three
add wave -noupdate -group adder -radix binary -childformat {{/counter_display_tb/uut/adder/a(3) -radix binary} {/counter_display_tb/uut/adder/a(2) -radix binary} {/counter_display_tb/uut/adder/a(1) -radix binary} {/counter_display_tb/uut/adder/a(0) -radix binary}} -subitemconfig {/counter_display_tb/uut/adder/a(3) {-height 15 -radix binary} /counter_display_tb/uut/adder/a(2) {-height 15 -radix binary} /counter_display_tb/uut/adder/a(1) {-height 15 -radix binary} /counter_display_tb/uut/adder/a(0) {-height 15 -radix binary}} /counter_display_tb/uut/adder/a
add wave -noupdate -group adder -radix binary -childformat {{/counter_display_tb/uut/adder/b(3) -radix binary} {/counter_display_tb/uut/adder/b(2) -radix binary} {/counter_display_tb/uut/adder/b(1) -radix binary} {/counter_display_tb/uut/adder/b(0) -radix binary}} -subitemconfig {/counter_display_tb/uut/adder/b(3) {-height 15 -radix binary} /counter_display_tb/uut/adder/b(2) {-height 15 -radix binary} /counter_display_tb/uut/adder/b(1) {-height 15 -radix binary} /counter_display_tb/uut/adder/b(0) {-height 15 -radix binary}} /counter_display_tb/uut/adder/b
add wave -noupdate -group adder -radix binary /counter_display_tb/uut/adder/cin
add wave -noupdate -group adder -radix binary -childformat {{/counter_display_tb/uut/adder/sum(3) -radix binary} {/counter_display_tb/uut/adder/sum(2) -radix binary} {/counter_display_tb/uut/adder/sum(1) -radix binary} {/counter_display_tb/uut/adder/sum(0) -radix binary}} -subitemconfig {/counter_display_tb/uut/adder/sum(3) {-height 15 -radix binary} /counter_display_tb/uut/adder/sum(2) {-height 15 -radix binary} /counter_display_tb/uut/adder/sum(1) {-height 15 -radix binary} /counter_display_tb/uut/adder/sum(0) {-height 15 -radix binary}} /counter_display_tb/uut/adder/sum
add wave -noupdate -group adder -radix binary /counter_display_tb/uut/adder/cout
add wave -noupdate -group adder -radix binary -childformat {{/counter_display_tb/uut/adder/sum_temp(4) -radix binary} {/counter_display_tb/uut/adder/sum_temp(3) -radix binary} {/counter_display_tb/uut/adder/sum_temp(2) -radix binary} {/counter_display_tb/uut/adder/sum_temp(1) -radix binary} {/counter_display_tb/uut/adder/sum_temp(0) -radix binary}} -subitemconfig {/counter_display_tb/uut/adder/sum_temp(4) {-height 15 -radix binary} /counter_display_tb/uut/adder/sum_temp(3) {-height 15 -radix binary} /counter_display_tb/uut/adder/sum_temp(2) {-height 15 -radix binary} /counter_display_tb/uut/adder/sum_temp(1) {-height 15 -radix binary} /counter_display_tb/uut/adder/sum_temp(0) {-height 15 -radix binary}} /counter_display_tb/uut/adder/sum_temp
add wave -noupdate -group adder -radix binary /counter_display_tb/uut/adder/cin_guard
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1484 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 143
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
WaveRestoreZoom {0 ns} {3184 ns}
