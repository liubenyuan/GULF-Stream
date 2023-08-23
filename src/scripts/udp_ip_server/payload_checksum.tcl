set root_dir [file normalize [file join [file dirname [file normalize [info script]]] "../../../"]]
source $root_dir/src/scripts/env.tcl
set target [get_env_param TARGET_FPGA "xczu19eg-ffvc1760-2-i"]
set src_list "\
  payload_checksum.cpp\
  util.cpp\
  udp_ip_rx.h\
"
gen_hls_ip "udp_ip_server" "payload_checksum" $src_list $target
