transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/XuJing/Desktop/Generator/src {C:/Users/XuJing/Desktop/Generator/src/WaveController.v}
vlog -vlog01compat -work work +incdir+C:/Users/XuJing/Desktop/Generator/src {C:/Users/XuJing/Desktop/Generator/src/TLV5614_CTRL.v}
vlog -vlog01compat -work work +incdir+C:/Users/XuJing/Desktop/Generator/src {C:/Users/XuJing/Desktop/Generator/src/GeneraterTop.v}
vlog -vlog01compat -work work +incdir+C:/Users/XuJing/Desktop/Generator/core {C:/Users/XuJing/Desktop/Generator/core/SINE_ROM.v}
vlog -vlog01compat -work work +incdir+C:/Users/XuJing/Desktop/Generator/core {C:/Users/XuJing/Desktop/Generator/core/TRI_ROM.v}
vlog -vlog01compat -work work +incdir+C:/Users/XuJing/Desktop/Generator/core {C:/Users/XuJing/Desktop/Generator/core/CTRL_ROM.v}

