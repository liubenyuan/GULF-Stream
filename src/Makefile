all: hls_ip assemble_ip GULF_stream

# top block
GULF_stream: assemble_ip scripts/full_core.tcl full_core/*
	vivado -mode tcl -source scripts/full_core.tcl -nolog -nojournal

# assemble IP interface (HLS IPs to mega block)
assemble_ip: hls_ip arp_server_100g_assemble udp_ip_server_100g_assemble

arp_server_100g_assemble: arp_server_ips scripts/arp.tcl
	vivado -mode tcl -source scripts/arp.tcl -nolog -nojournal

udp_ip_server_100g_assemble: udp_ip_server scripts/udp_ip.tcl
	vivado -mode tcl -source scripts/udp_ip.tcl -nolog -nojournal

# HLS IP from cpp
hls_ip: arp_server_ips protocol_filter udp_ip_server

arp_server: scripts/arp_server/arp_server.tcl arp_server/*
	vitis_hls scripts/arp_server/arp_server.tcl
	rm -f vitis_hls.log

arp_server_ips: scripts/arp_server/* arp_server/*
	vitis_hls scripts/arp_server/arp_receive.tcl
	# vitis_hls scripts/arp_server/arp_send.tcl
	rm -f vitis_hls.log

protocol_filter: scripts/protocol_filter/* protocol_filter/*
	vitis_hls scripts/protocol_filter/protocol_assembler.tcl
	vitis_hls scripts/protocol_filter/protocol_spliter.tcl
	rm -f vitis_hls.log

udp_ip_server: scripts/udp_ip_server/* udp_ip_server/*
	vitis_hls scripts/udp_ip_server/action_excecutor.tcl
	vitis_hls scripts/udp_ip_server/action_generator.tcl
	vitis_hls scripts/udp_ip_server/payload_checksum.tcl
	vitis_hls scripts/udp_ip_server/udp_ip_receive.tcl
	vitis_hls scripts/udp_ip_server/udp_ip_tx.tcl
	vitis_hls scripts/udp_ip_server/udp_eth_assemble.tcl
	rm -f vitis_hls.log
