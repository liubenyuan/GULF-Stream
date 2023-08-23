set root_dir [file normalize [file join [file dirname [file normalize [info script]]] "../../../"]]
source $root_dir/src/scripts/env.tcl
set target [get_env_param TARGET_FPGA "xczu19eg-ffvc1760-2-i"]
set src_list "\
  ether_protocol_spliter.cpp\
  ether_protocol_spliter.h\
"
gen_hls_ip "protocol_filter" "ether_protocol_spliter" $src_list $target
