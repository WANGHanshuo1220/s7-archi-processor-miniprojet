vlib work

vcom -93 Telemetre_us.vhd
vcom -93 Telemetre_us_banc.vhd

vsim -novopt Telemetre_us_banc(one)

view signals
add wave *

run 150ms