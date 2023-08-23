set root_dir [file normalize [file join [file dirname [file normalize [info script]]] "../../../"]]
source $root_dir/src/scripts/env.tcl
set target [get_env_param TARGET_FPGA "xczu19eg-ffvc1760-2-i"]
set src_list "\
  udp_eth_assemble.cpp\
  udp_ip_tx.h\
"
gen_hls_ip "udp_ip_server" "udp_eth_assemble" $src_list $target
