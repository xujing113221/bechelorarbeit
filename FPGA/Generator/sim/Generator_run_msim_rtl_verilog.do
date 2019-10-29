transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/XuJing/Desktop/Generator/src {C:/Users/XuJing/Desktop/Generator/src/FSMC_CTRL.v}
vlog -vlog01compat -work work +incdir+C:/Users/XuJing/Desktop/Generator/core {C:/Users/XuJing/Desktop/Generator/core/FSMC_RAM.v}
vlog -vlog01compat -work work +incdir+C:/Users/XuJing/Desktop/Generator/core {C:/Users/XuJing/Desktop/Generator/core/PLL.v}
vlog -vlog01compat -work work +incdir+C:/Users/XuJing/Desktop/Generator/prj/db {C:/Users/XuJing/Desktop/Generator/prj/db/pll_altpll.v}

vlog -vlog01compat -work work +incdir+C:/Users/XuJing/Desktop/Generator/prj/../sim {C:/Users/XuJing/Desktop/Generator/prj/../sim/FSMC_CTRL.vt}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  FSMC_CTRL_vlg_tst

add wave *
view structure
view signals
run -all
