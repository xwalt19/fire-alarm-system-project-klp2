onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix binary /mainboard/THRESHOLD
add wave -noupdate -radix binary /mainboard/TIME_DELAY
add wave -noupdate -radix binary /mainboard/clk
add wave -noupdate -radix binary /mainboard/reset
add wave -noupdate -radix binary /mainboard/temp_data
add wave -noupdate -radix binary /mainboard/alarm
add wave -noupdate -radix binary /mainboard/display
add wave -noupdate -radix binary /mainboard/clk_divider
add wave -noupdate -radix binary /mainboard/one_sec_clk
add wave -noupdate -radix binary /mainboard/timer_counter
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
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
WaveRestoreZoom {0 ns} {799 ns}
