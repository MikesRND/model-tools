onbreak resume
onerror resume
vsim -novopt work.hdlconvert_demo_tb

add wave sim:/hdlconvert_demo_tb/u_hdlconvert_demo/din
add wave sim:/hdlconvert_demo_tb/u_hdlconvert_demo/din_vec
add wave sim:/hdlconvert_demo_tb/u_hdlconvert_demo/bestrange_d
add wave sim:/hdlconvert_demo_tb/bestrange_d_ref
add wave sim:/hdlconvert_demo_tb/u_hdlconvert_demo/bestprecision_d
add wave sim:/hdlconvert_demo_tb/bestprecision_d_ref
add wave sim:/hdlconvert_demo_tb/u_hdlconvert_demo/brfloor_d
add wave sim:/hdlconvert_demo_tb/brfloor_d_ref
add wave sim:/hdlconvert_demo_tb/u_hdlconvert_demo/brcvg_d
add wave sim:/hdlconvert_demo_tb/brcvg_d_ref
add wave sim:/hdlconvert_demo_tb/u_hdlconvert_demo/nosat_d
add wave sim:/hdlconvert_demo_tb/nosat_d_ref
add wave sim:/hdlconvert_demo_tb/u_hdlconvert_demo/dout_vec
add wave sim:/hdlconvert_demo_tb/dout_vec_ref
run -all

quit -f