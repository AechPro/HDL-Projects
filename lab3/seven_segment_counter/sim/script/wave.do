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
    -default default
}
quietly WaveActivateNextPane {} 0
add wave -noupdate /counter_display_tb/uut/clk
add wave -noupdate /counter_display_tb/uut/reset
add wave -noupdate -radix States /counter_display_tb/uut/display_output
add wave -noupdate /counter_display_tb/uut/enable
add wave -noupdate -radix unsigned /counter_display_tb/uut/adder_sum
add wave -noupdate -radix unsigned /counter_display_tb/uut/sum_sig
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1761 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 177
configure wave -valuecolwidth 40
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
WaveRestoreZoom {0 ns} {3150 ns}
