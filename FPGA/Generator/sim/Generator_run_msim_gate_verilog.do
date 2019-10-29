transcript on
if {[file exists gate_work]} {
	vdel -lib gate_work -all
}
vlib gate_work
vmap work gate_work

vlog -vlog01compat -work work +incdir+. {Generator_min_1200mv_0c_fast.vo}

vlog -vlog01compat -work work +incdir+C:/Users/XuJing/Desktop/Generator/prj/../sim {C:/Users/XuJing/Desktop/Generator/prj/../sim/GeneraterTop.vt}

vsim -t 1ps +transport_int_delays +transport_path_delays -L altera_ver -L cycloneive_ver -L gate_work -L work -voptargs="+acc"  GeneraterTop_vlg_tst

add wave *
view structure
view signals
run -all
