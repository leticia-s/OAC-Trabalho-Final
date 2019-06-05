transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {C:/Users/TEMP.W311918.000/Desktop/Uniciclo/mips_pkg.vhd}
vcom -93 -work work {C:/Users/TEMP.W311918.000/Desktop/Uniciclo/uniciclo.vhd}
vcom -93 -work work {C:/Users/TEMP.W311918.000/Desktop/Uniciclo/somador.vhd}

vcom -93 -work work {C:/Users/TEMP.W311918.000/Desktop/Uniciclo/uniciclo_tb.vhd}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L cycloneii -L rtl_work -L work -voptargs="+acc"  uniciclo_tb

add wave *
view structure
view signals
run 100 ns
