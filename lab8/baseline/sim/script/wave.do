onerror {resume}
radix define States {
    "8'b000?????" "Play" -color "green",
    "8'b001?????" "Play Repeat" -color "purple",
    "8'b01??????" "Pause" -color "orange",
    "8'b10??????" "Seek" -color "blue",
    "8'b11??????" "Stop" -color "red",
    -default hexadecimal
    -defaultcolor white
}
radix define Opcode {
    "3'b000" "IDLE" -color "green",
    "3'b001" "FETCH" -color "green",
    "3'b011" "DECODE" -color "green",
    "3'b100" "DECODE ERROR" -color "green",
    "3'b010" "EXECUTE" -color "green",
    -default hexadecimal
    -defaultcolor white
}
radix define Output_States {
    "2'b00" "PLAY" -color "green",
    "2'b01" "PAUSE" -color "green",
    "2'b10" "SEEK" -color "green",
    "2'b11" "STOP" -color "green",
    -default hexadecimal
    -defaultcolor white
}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radixshowbase 0 /audio_processor_3000_tb/audio_processor/clk
add wave -noupdate -radixshowbase 0 /audio_processor_3000_tb/audio_processor/reset
add wave -noupdate -radixshowbase 0 /audio_processor_3000_tb/audio_processor/execute_btn
add wave -noupdate -radixshowbase 0 /audio_processor_3000_tb/audio_processor/sync
add wave -noupdate -radixshowbase 0 /audio_processor_3000_tb/audio_processor/led
add wave -noupdate -radixshowbase 0 /audio_processor_3000_tb/audio_processor/audio_out
add wave -noupdate -radix States -radixshowbase 0 /audio_processor_3000_tb/audio_processor/instruction
add wave -noupdate -radixshowbase 0 /audio_processor_3000_tb/audio_processor/repeat
add wave -noupdate -radix unsigned -radixshowbase 0 /audio_processor_3000_tb/audio_processor/PC
add wave -noupdate -radix unsigned -radixshowbase 0 /audio_processor_3000_tb/audio_processor/data_address
add wave -noupdate -radix unsigned -radixshowbase 0 /audio_processor_3000_tb/audio_processor/data_address_reg
add wave -noupdate -radix unsigned -radixshowbase 0 /audio_processor_3000_tb/audio_processor/data_address_play
add wave -noupdate -radix unsigned -radixshowbase 0 /audio_processor_3000_tb/audio_processor/data_address_play_repeat
add wave -noupdate -radix unsigned -radixshowbase 0 /audio_processor_3000_tb/audio_processor/data_address_stop
add wave -noupdate -radix unsigned -radixshowbase 0 /audio_processor_3000_tb/audio_processor/data_address_seek
add wave -noupdate -radix unsigned -radixshowbase 0 /audio_processor_3000_tb/audio_processor/data_address_pause
add wave -noupdate -radixshowbase 0 /audio_processor_3000_tb/audio_processor/edge
add wave -noupdate -radix Opcode -radixshowbase 0 /audio_processor_3000_tb/audio_processor/state_reg
add wave -noupdate -radix Opcode -radixshowbase 0 /audio_processor_3000_tb/audio_processor/state_next
add wave -noupdate -radixshowbase 0 /audio_processor_3000_tb/audio_processor/seek_address
add wave -noupdate -radix unsigned -radixshowbase 0 /audio_processor_3000_tb/audio_processor/opcode
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {45 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 202
configure wave -valuecolwidth 48
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
configure wave -timelineunits us
update
WaveRestoreZoom {0 ns} {2100 ns}
