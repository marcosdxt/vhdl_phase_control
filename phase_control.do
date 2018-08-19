vlib work
vcom phase_control.vhd
vcom phase_control_tb.vhd


vsim -t ns work.phase_control_tb

add wave -color "red"    -label CLK     -unsigned phase_control_tb.u1.clkin
add wave -color "orange" -label ZERO    -unsigned phase_control_tb.u1.zero_cross
add wave -color "black"  -label PRESET  -unsigned phase_control_tb.u1.preset 
add wave -color "white"  -label LOAD    -unsigned phase_control_tb.u1.load_preset
add wave -color "blue"   -label ENABLE  -unsigned phase_control_tb.u1.enable
add wave -color "red"    -label RESET   -unsigned phase_control_tb.u1.reset
add wave -color "purple" -label GATE    -unsigned phase_control_tb.u1.gate_signal
add wave -color "gray"   -label CNT     -unsigned phase_control_tb.u1.counter


run 500ns


