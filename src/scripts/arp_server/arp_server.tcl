set root_dir [file normalize [file join [file dirname [file normalize [info script]]] "../../../"]]
source $root_dir/src/scripts/env.tcl
set target [get_env_param TARGET_FPGA "xczu19eg-ffvc1760-2-i"]
set src_list "\
  arp_send.cpp\
  arp_receive.cpp\
  arp_server.cpp\
  arp_server.h\
"
gen_hls_ip "arp_server" "arp_server" $src_list $target
