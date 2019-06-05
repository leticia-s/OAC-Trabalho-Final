transcript on
if {[file exists gate_work]} {
	vdel -lib gate_work -all
}
vlib gate_work
vmap work gate_work

vcom -93 -work work {uniciclo.vho}

vcom -93 -work work {C:/Users/letic/OneDrive/Oac/150015178 - Projeto Final/mips_uniciclo/uniciclo_tb.vhd}

vsim -t 1ps +transport_int_delays +transport_path_delays -sdftyp /i1=uniciclo_vhd.sdo -L cycloneii -L gate_work -L work -voptargs="+acc"  uniciclo_tb

add wave *
view structure
view signals
run 16 ns
