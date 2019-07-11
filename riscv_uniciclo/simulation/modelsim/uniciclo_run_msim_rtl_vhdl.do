transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {C:/Users/letic/Documents/GitHub/OAC-Trabalho-Final/riscv_uniciclo/xreg.vhd}
vcom -93 -work work {C:/Users/letic/Documents/GitHub/OAC-Trabalho-Final/riscv_uniciclo/data_memory.vhd}
vcom -93 -work work {C:/Users/letic/Documents/GitHub/OAC-Trabalho-Final/riscv_uniciclo/memory_instruction.vhd}
vcom -93 -work work {C:/Users/letic/Documents/GitHub/OAC-Trabalho-Final/riscv_uniciclo/types_components.vhd}
vcom -93 -work work {C:/Users/letic/Documents/GitHub/OAC-Trabalho-Final/riscv_uniciclo/uniciclo.vhd}
vcom -93 -work work {C:/Users/letic/Documents/GitHub/OAC-Trabalho-Final/riscv_uniciclo/control.vhd}
vcom -93 -work work {C:/Users/letic/Documents/GitHub/OAC-Trabalho-Final/riscv_uniciclo/c_ula.vhd}
vcom -93 -work work {C:/Users/letic/Documents/GitHub/OAC-Trabalho-Final/riscv_uniciclo/ula.vhd}
vcom -93 -work work {C:/Users/letic/Documents/GitHub/OAC-Trabalho-Final/riscv_uniciclo/somador.vhd}
vcom -93 -work work {C:/Users/letic/Documents/GitHub/OAC-Trabalho-Final/riscv_uniciclo/pc.vhd}
vcom -93 -work work {C:/Users/letic/Documents/GitHub/OAC-Trabalho-Final/riscv_uniciclo/multiplexador_32_bits.vhd}
vcom -93 -work work {C:/Users/letic/Documents/GitHub/OAC-Trabalho-Final/riscv_uniciclo/genImm32.vhd}

vcom -93 -work work {C:/Users/letic/Documents/GitHub/OAC-Trabalho-Final/riscv_uniciclo/uniciclo_tb.vhd}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L cycloneii -L rtl_work -L work -voptargs="+acc"  uniciclo_tb

add wave *
view structure
view signals
run 16 ns
