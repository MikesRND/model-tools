load_package flow
set top_level hdlconvert_demo
set src_dir "[pwd]"
set prj_dir "q2dir"
file mkdir ../$prj_dir
cd ../$prj_dir
project_new $top_level -revision $top_level -overwrite
set_global_assignment -name FAMILY "Stratix IV"
set_global_assignment -name DEVICE EP4SGX230KF40C2
set_global_assignment -name TOP_LEVEL_ENTITY $top_level
set_global_assignment -name VHDL_FILE "$src_dir/hdlconvert_demo_pkg.vhd"
set_global_assignment -name VHDL_FILE "$src_dir/hdlconvert_demo.vhd"
execute_flow -compile
project_close
