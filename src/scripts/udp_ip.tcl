set root_dir [file normalize [file join [file dirname [file normalize [info script]]] "../../"]]
set project_dir $root_dir/ip_repo/assembled_ips
set project_name "udp_ip_server_100g"
source ${root_dir}/src/scripts/env.tcl

set target [get_env_param TARGET_FPGA "xczu19eg-ffvc1760-2-i"]
create_project $project_name $project_dir/$project_name -part $target
#set_property board_part fidus.com:sidewinder100:part0:1.0 [current_project]
create_bd_design $project_name

set_property ip_repo_paths "${project_dir}/../hls_ips" [current_project]
update_ip_catalog -rebuild

addip udp_ip_receive udp_ip_receive_0
addip action_generator action_generator_0
addip payload_checksum payload_checksum_0
addip action_excecutor action_excecutor_0
addip fifo_generator fifo_generator_0
set_property -dict [list CONFIG.Fifo_Implementation {Common_Clock_Block_RAM} CONFIG.Performance_Options {First_Word_Fall_Through} CONFIG.Input_Data_Width {65} CONFIG.Input_Depth {256} CONFIG.Output_Data_Width {65} CONFIG.Output_Depth {256} CONFIG.Use_Embedded_Registers {false} CONFIG.Reset_Type {Asynchronous_Reset} CONFIG.Full_Flags_Reset_Value {1} CONFIG.Valid_Flag {true} CONFIG.Use_Extra_Logic {true} CONFIG.Data_Count_Width {9} CONFIG.Write_Data_Count_Width {9} CONFIG.Read_Data_Count_Width {9} CONFIG.Full_Threshold_Assert_Value {255} CONFIG.Full_Threshold_Negate_Value {254} CONFIG.Empty_Threshold_Assert_Value {4} CONFIG.Empty_Threshold_Negate_Value {5} CONFIG.Enable_Safety_Circuit {false}] [get_bd_cells fifo_generator_0]

addip fifo_generator fifo_generator_1
set_property -dict [list CONFIG.Fifo_Implementation {Common_Clock_Block_RAM} CONFIG.Performance_Options {First_Word_Fall_Through} CONFIG.Input_Data_Width {161} CONFIG.Input_Depth {256} CONFIG.Output_Data_Width {161} CONFIG.Output_Depth {256} CONFIG.Use_Embedded_Registers {false} CONFIG.Reset_Type {Asynchronous_Reset} CONFIG.Full_Flags_Reset_Value {1} CONFIG.Valid_Flag {true} CONFIG.Use_Extra_Logic {true} CONFIG.Data_Count_Width {9} CONFIG.Write_Data_Count_Width {9} CONFIG.Read_Data_Count_Width {9} CONFIG.Full_Threshold_Assert_Value {255} CONFIG.Full_Threshold_Negate_Value {254} CONFIG.Empty_Threshold_Assert_Value {4} CONFIG.Empty_Threshold_Negate_Value {5} CONFIG.Enable_Safety_Circuit {false}] [get_bd_cells fifo_generator_1]

addip fifo_generator axis_data_fifo_0
set_property -dict [list CONFIG.INTERFACE_TYPE {AXI_STREAM} CONFIG.Reset_Type {Asynchronous_Reset} CONFIG.TDATA_NUM_BYTES {64} CONFIG.TUSER_WIDTH {0} CONFIG.Enable_TLAST {true} CONFIG.TSTRB_WIDTH {64} CONFIG.HAS_TKEEP {true} CONFIG.TKEEP_WIDTH {64} CONFIG.FIFO_Implementation_wach {Common_Clock_Distributed_RAM} CONFIG.Full_Threshold_Assert_Value_wach {15} CONFIG.Empty_Threshold_Assert_Value_wach {14} CONFIG.FIFO_Implementation_wdch {Common_Clock_Builtin_FIFO} CONFIG.FIFO_Implementation_wrch {Common_Clock_Distributed_RAM} CONFIG.Full_Threshold_Assert_Value_wrch {15} CONFIG.Empty_Threshold_Assert_Value_wrch {14} CONFIG.FIFO_Implementation_rach {Common_Clock_Distributed_RAM} CONFIG.Full_Threshold_Assert_Value_rach {15} CONFIG.Empty_Threshold_Assert_Value_rach {14} CONFIG.FIFO_Implementation_rdch {Common_Clock_Builtin_FIFO} CONFIG.FIFO_Implementation_axis {Common_Clock_Block_RAM} CONFIG.Input_Depth_axis {256} CONFIG.Full_Threshold_Assert_Value_axis {255} CONFIG.Empty_Threshold_Assert_Value_axis {254}] [get_bd_cells axis_data_fifo_0]

addip fifo_generator axis_data_fifo_1
set_property -dict [list CONFIG.INTERFACE_TYPE {AXI_STREAM} CONFIG.Reset_Type {Asynchronous_Reset} CONFIG.TDATA_NUM_BYTES {64} CONFIG.TUSER_WIDTH {0} CONFIG.Enable_TLAST {true} CONFIG.TSTRB_WIDTH {64} CONFIG.HAS_TKEEP {true} CONFIG.TKEEP_WIDTH {64} CONFIG.FIFO_Implementation_wach {Common_Clock_Distributed_RAM} CONFIG.Full_Threshold_Assert_Value_wach {15} CONFIG.Empty_Threshold_Assert_Value_wach {14} CONFIG.FIFO_Implementation_wdch {Common_Clock_Builtin_FIFO} CONFIG.FIFO_Implementation_wrch {Common_Clock_Distributed_RAM} CONFIG.Full_Threshold_Assert_Value_wrch {15} CONFIG.Empty_Threshold_Assert_Value_wrch {14} CONFIG.FIFO_Implementation_rach {Common_Clock_Distributed_RAM} CONFIG.Full_Threshold_Assert_Value_rach {15} CONFIG.Empty_Threshold_Assert_Value_rach {14} CONFIG.FIFO_Implementation_rdch {Common_Clock_Builtin_FIFO} CONFIG.FIFO_Implementation_axis {Common_Clock_Block_RAM} CONFIG.Input_Depth_axis {256} CONFIG.Full_Threshold_Assert_Value_axis {255} CONFIG.Empty_Threshold_Assert_Value_axis {254}] [get_bd_cells axis_data_fifo_1]

addip udp_eth_assemble udp_eth_assemble_0
addip udp_ip_tx udp_ip_tx_0
addip util_vector_logic util_vector_logic_0
set_property -dict [list CONFIG.C_SIZE {1} CONFIG.C_OPERATION {not} CONFIG.LOGO_FILE {data/sym_notgate.png}] [get_bd_cells util_vector_logic_0]

make_bd_pins_external  [get_bd_pins udp_ip_receive_0/ap_clk]
make_bd_pins_external  [get_bd_pins udp_ip_receive_0/ap_rst]
make_bd_pins_external  [get_bd_pins udp_ip_receive_0/myIP]
make_bd_pins_external  [get_bd_pins udp_ip_receive_0/ip_in_data]
make_bd_pins_external  [get_bd_pins udp_ip_receive_0/ip_in_valid]
make_bd_pins_external  [get_bd_pins payload_checksum_0/payload_in_data]
make_bd_pins_external  [get_bd_pins payload_checksum_0/payload_in_valid]
make_bd_pins_external  [get_bd_pins payload_checksum_0/payload_in_last]
make_bd_pins_external  [get_bd_pins payload_checksum_0/payload_length_data]
make_bd_pins_external  [get_bd_pins payload_checksum_0/payload_length_valid]
make_bd_pins_external  [get_bd_pins action_excecutor_0/payload_out_data]
make_bd_pins_external  [get_bd_pins action_excecutor_0/payload_out_keep]
make_bd_pins_external  [get_bd_pins action_excecutor_0/payload_out_valid]
make_bd_pins_external  [get_bd_pins action_excecutor_0/payload_out_last]
make_bd_pins_external  [get_bd_pins action_excecutor_0/src_ip]
make_bd_pins_external  [get_bd_pins action_excecutor_0/src_port]
make_bd_pins_external  [get_bd_pins action_excecutor_0/dst_port]
make_bd_pins_external  [get_bd_pins udp_ip_tx_0/dst_ip]
make_bd_pins_external  [get_bd_pins udp_ip_tx_0/dst_mac]
make_bd_pins_external  [get_bd_pins udp_ip_tx_0/src_port]
make_bd_pins_external  [get_bd_pins udp_ip_tx_0/dst_port]
make_bd_pins_external  [get_bd_pins udp_ip_tx_0/arp_status]
make_bd_pins_external  [get_bd_pins udp_ip_tx_0/payload_in_data]
make_bd_pins_external  [get_bd_pins udp_ip_tx_0/payload_in_keep]
make_bd_pins_external  [get_bd_pins udp_ip_tx_0/payload_in_valid]
make_bd_pins_external  [get_bd_pins udp_ip_tx_0/payload_in_last]
make_bd_pins_external  [get_bd_pins udp_ip_tx_0/payload_in_ready]
make_bd_pins_external  [get_bd_pins udp_eth_assemble_0/packet_out_ready]
make_bd_pins_external  [get_bd_pins udp_eth_assemble_0/packet_out_data]
make_bd_pins_external  [get_bd_pins udp_eth_assemble_0/packet_out_keep]
make_bd_pins_external  [get_bd_pins udp_eth_assemble_0/packet_out_valid]
make_bd_pins_external  [get_bd_pins udp_eth_assemble_0/packet_out_last]
make_bd_pins_external  [get_bd_pins udp_eth_assemble_0/myMac]
make_bd_pins_external  [get_bd_pins udp_ip_receive_0/arp_internal_resp_Mac_IP]
make_bd_pins_external  [get_bd_pins udp_ip_receive_0/arp_internal_resp_valid]

set_property name clk [get_bd_ports ap_clk_0]
set_property name rst [get_bd_ports ap_rst_0]
foreach port [get_bd_ports *_0] {
        set_property name [regsub "_0" [regsub "/" $port ""] ""] $port
}
set_property name remote_ip_rx [get_bd_ports src_ip]
set_property name remote_port_rx [get_bd_ports src_port]
set_property name local_port_rx [get_bd_ports dst_port]
set_property name remote_ip_tx [get_bd_ports dst_ip]
set_property name local_port_tx [get_bd_ports src_port_1]
set_property name remote_port_tx [get_bd_ports dst_port_1]

connect_bd_net [get_bd_ports clk] [get_bd_pins payload_checksum_0/ap_clk]
connect_bd_net [get_bd_ports clk] [get_bd_pins udp_eth_assemble_0/ap_clk]
connect_bd_net [get_bd_ports clk] [get_bd_pins action_excecutor_0/ap_clk]
connect_bd_net [get_bd_ports clk] [get_bd_pins action_generator_0/ap_clk]
connect_bd_net [get_bd_ports clk] [get_bd_pins axis_data_fifo_0/s_aclk]
connect_bd_net [get_bd_ports clk] [get_bd_pins axis_data_fifo_1/s_aclk]
connect_bd_net [get_bd_ports clk] [get_bd_pins fifo_generator_0/clk]
connect_bd_net [get_bd_ports clk] [get_bd_pins fifo_generator_1/clk]
connect_bd_net [get_bd_ports clk] [get_bd_pins udp_ip_tx_0/ap_clk]

connect_bd_net [get_bd_ports rst] [get_bd_pins payload_checksum_0/ap_rst]
connect_bd_net [get_bd_ports rst] [get_bd_pins udp_eth_assemble_0/ap_rst]
connect_bd_net [get_bd_ports rst] [get_bd_pins udp_ip_tx_0/ap_rst]
connect_bd_net [get_bd_ports rst] [get_bd_pins action_excecutor_0/ap_rst]
connect_bd_net [get_bd_ports rst] [get_bd_pins action_generator_0/ap_rst]
connect_bd_net [get_bd_ports rst] [get_bd_pins util_vector_logic_0/Op1]
connect_bd_net [get_bd_ports rst] [get_bd_pins fifo_generator_0/rst]
connect_bd_net [get_bd_ports rst] [get_bd_pins fifo_generator_1/rst]
connect_bd_net [get_bd_pins util_vector_logic_0/Res] [get_bd_pins axis_data_fifo_0/s_aresetn]
connect_bd_net [get_bd_pins util_vector_logic_0/Res] [get_bd_pins axis_data_fifo_1/s_aresetn]
connect_bd_net [get_bd_pins udp_ip_receive_0/meta_out_src_ip] [get_bd_pins action_generator_0/meta_in_src_ip]
connect_bd_net [get_bd_pins udp_ip_receive_0/meta_out_protocol_header] [get_bd_pins action_generator_0/meta_in_protocol_header]
connect_bd_net [get_bd_pins udp_ip_receive_0/meta_out_checksum] [get_bd_pins action_generator_0/meta_in_checksum]
connect_bd_net [get_bd_pins udp_ip_receive_0/meta_out_action] [get_bd_pins action_generator_0/meta_in_action]
connect_bd_net [get_bd_pins action_generator_0/action_out] [get_bd_pins fifo_generator_0/din]
connect_bd_net [get_bd_pins action_generator_0/action_out_valid] [get_bd_pins fifo_generator_0/wr_en]
connect_bd_net [get_bd_pins fifo_generator_0/dout] [get_bd_pins action_excecutor_0/action]
connect_bd_net [get_bd_pins fifo_generator_0/rd_en] [get_bd_pins action_excecutor_0/action_re]
connect_bd_net [get_bd_pins fifo_generator_0/empty] [get_bd_pins action_excecutor_0/action_empty]
connect_bd_net [get_bd_pins fifo_generator_0/valid] [get_bd_pins action_excecutor_0/action_valid]
connect_bd_net [get_bd_pins payload_checksum_0/payload_out_data] [get_bd_pins axis_data_fifo_0/s_axis_tdata]
connect_bd_net [get_bd_pins payload_checksum_0/payload_out_keep] [get_bd_pins axis_data_fifo_0/s_axis_tkeep]
connect_bd_net [get_bd_pins payload_checksum_0/payload_out_valid] [get_bd_pins axis_data_fifo_0/s_axis_tvalid]
connect_bd_net [get_bd_pins payload_checksum_0/payload_out_last] [get_bd_pins axis_data_fifo_0/s_axis_tlast]
connect_bd_net [get_bd_pins axis_data_fifo_0/m_axis_tvalid] [get_bd_pins action_excecutor_0/payload_in_valid]
connect_bd_net [get_bd_pins action_excecutor_0/payload_in_keep] [get_bd_pins axis_data_fifo_0/m_axis_tkeep]
connect_bd_net [get_bd_pins axis_data_fifo_0/m_axis_tdata] [get_bd_pins action_excecutor_0/payload_in_data]
connect_bd_net [get_bd_pins action_excecutor_0/payload_in_last] [get_bd_pins axis_data_fifo_0/m_axis_tlast]
connect_bd_net [get_bd_pins action_excecutor_0/payload_ready] [get_bd_pins axis_data_fifo_0/m_axis_tready]
connect_bd_net [get_bd_pins payload_checksum_0/checksum_data] [get_bd_pins action_generator_0/payload_cksum_data]
connect_bd_net [get_bd_pins payload_checksum_0/checksum_valid] [get_bd_pins action_generator_0/payload_cksum_valid]
connect_bd_net [get_bd_pins udp_ip_tx_0/payload_out_ready] [get_bd_pins axis_data_fifo_1/s_axis_tready]
connect_bd_net [get_bd_pins udp_ip_tx_0/payload_out_data] [get_bd_pins axis_data_fifo_1/s_axis_tdata]
connect_bd_net [get_bd_pins udp_ip_tx_0/payload_out_keep] [get_bd_pins axis_data_fifo_1/s_axis_tkeep]
connect_bd_net [get_bd_pins udp_ip_tx_0/payload_out_valid] [get_bd_pins axis_data_fifo_1/s_axis_tvalid]
connect_bd_net [get_bd_pins udp_ip_tx_0/payload_out_last] [get_bd_pins axis_data_fifo_1/s_axis_tlast]
connect_bd_net [get_bd_pins udp_ip_tx_0/action_out] [get_bd_pins fifo_generator_1/din]
connect_bd_net [get_bd_pins udp_ip_tx_0/action_out_we] [get_bd_pins fifo_generator_1/wr_en]
connect_bd_net [get_bd_pins fifo_generator_1/dout] [get_bd_pins udp_eth_assemble_0/action]
connect_bd_net [get_bd_pins fifo_generator_1/rd_en] [get_bd_pins udp_eth_assemble_0/action_re]
connect_bd_net [get_bd_pins fifo_generator_1/empty] [get_bd_pins udp_eth_assemble_0/action_empty]
connect_bd_net [get_bd_pins fifo_generator_1/valid] [get_bd_pins udp_eth_assemble_0/action_valid]
connect_bd_net [get_bd_ports myIP] [get_bd_pins udp_eth_assemble_0/myIP]
connect_bd_net [get_bd_ports myIP] [get_bd_pins udp_ip_tx_0/myIP]
connect_bd_net [get_bd_pins udp_eth_assemble_0/payload_in_data] [get_bd_pins axis_data_fifo_1/m_axis_tdata]
connect_bd_net [get_bd_pins udp_eth_assemble_0/payload_in_keep] [get_bd_pins axis_data_fifo_1/m_axis_tkeep]
connect_bd_net [get_bd_pins udp_eth_assemble_0/payload_in_valid] [get_bd_pins axis_data_fifo_1/m_axis_tvalid]
connect_bd_net [get_bd_pins udp_eth_assemble_0/payload_in_last] [get_bd_pins axis_data_fifo_1/m_axis_tlast]
connect_bd_net [get_bd_pins udp_eth_assemble_0/payload_ready] [get_bd_pins axis_data_fifo_1/m_axis_tready]
save_bd_design

make_wrapper -files [get_files $project_dir/$project_name/${project_name}.srcs/sources_1/bd/${project_name}/${project_name}.bd] -top
add_files -norecurse $project_dir/$project_name/${project_name}.srcs/sources_1/bd/${project_name}/hdl/${project_name}_wrapper.v

ipx::package_project -import_files -root_dir $project_dir/$project_name/${project_name}.srcs/sources_1/bd/${project_name} -vendor clarkshen.com -library user -taxonomy /UserIP
set_property vendor_display_name {clarkshen.com} [ipx::current_core]
set_property name $project_name [ipx::current_core]
set_property display_name $project_name [ipx::current_core]
set_property description $project_name [ipx::current_core]

ipx::add_bus_interface arp_internal_resp [ipx::current_core]
set_property abstraction_type_vlnv xilinx.com:interface:axis_rtl:1.0 [ipx::get_bus_interfaces arp_internal_resp -of_objects [ipx::current_core]]
set_property bus_type_vlnv xilinx.com:interface:axis:1.0 [ipx::get_bus_interfaces arp_internal_resp -of_objects [ipx::current_core]]
set_property display_name arp_internal_resp [ipx::get_bus_interfaces arp_internal_resp -of_objects [ipx::current_core]]
set_property interface_mode master [ipx::get_bus_interfaces arp_internal_resp -of_objects [ipx::current_core]]
ipx::add_port_map TDATA [ipx::get_bus_interfaces arp_internal_resp -of_objects [ipx::current_core]]
set_property physical_name arp_internal_resp_Mac_IP [ipx::get_port_maps TDATA -of_objects [ipx::get_bus_interfaces arp_internal_resp -of_objects [ipx::current_core]]]
ipx::add_port_map TVALID [ipx::get_bus_interfaces arp_internal_resp -of_objects [ipx::current_core]]
set_property physical_name arp_internal_resp_valid [ipx::get_port_maps TVALID -of_objects [ipx::get_bus_interfaces arp_internal_resp -of_objects [ipx::current_core]]]
ipx::associate_bus_interfaces -busif arp_internal_resp -clock clk [ipx::current_core]

ipx::add_bus_interface ip_in [ipx::current_core]
set_property abstraction_type_vlnv xilinx.com:interface:axis_rtl:1.0 [ipx::get_bus_interfaces ip_in -of_objects [ipx::current_core]]
set_property bus_type_vlnv xilinx.com:interface:axis:1.0 [ipx::get_bus_interfaces ip_in -of_objects [ipx::current_core]]
set_property display_name ip_in [ipx::get_bus_interfaces ip_in -of_objects [ipx::current_core]]
ipx::add_port_map TDATA [ipx::get_bus_interfaces ip_in -of_objects [ipx::current_core]]
set_property physical_name ip_in_data [ipx::get_port_maps TDATA -of_objects [ipx::get_bus_interfaces ip_in -of_objects [ipx::current_core]]]
ipx::add_port_map TVALID [ipx::get_bus_interfaces ip_in -of_objects [ipx::current_core]]
set_property physical_name ip_in_valid [ipx::get_port_maps TVALID -of_objects [ipx::get_bus_interfaces ip_in -of_objects [ipx::current_core]]]
ipx::associate_bus_interfaces -busif ip_in -clock clk [ipx::current_core]

ipx::add_bus_interface packet_m_axis [ipx::current_core]
set_property abstraction_type_vlnv xilinx.com:interface:axis_rtl:1.0 [ipx::get_bus_interfaces packet_m_axis -of_objects [ipx::current_core]]
set_property bus_type_vlnv xilinx.com:interface:axis:1.0 [ipx::get_bus_interfaces packet_m_axis -of_objects [ipx::current_core]]
set_property display_name packet_m_axis [ipx::get_bus_interfaces packet_m_axis -of_objects [ipx::current_core]]
set_property interface_mode master [ipx::get_bus_interfaces packet_m_axis -of_objects [ipx::current_core]]
ipx::add_port_map TDATA [ipx::get_bus_interfaces packet_m_axis -of_objects [ipx::current_core]]
set_property physical_name packet_out_data [ipx::get_port_maps TDATA -of_objects [ipx::get_bus_interfaces packet_m_axis -of_objects [ipx::current_core]]]
ipx::add_port_map TLAST [ipx::get_bus_interfaces packet_m_axis -of_objects [ipx::current_core]]
set_property physical_name packet_out_last [ipx::get_port_maps TLAST -of_objects [ipx::get_bus_interfaces packet_m_axis -of_objects [ipx::current_core]]]
ipx::add_port_map TVALID [ipx::get_bus_interfaces packet_m_axis -of_objects [ipx::current_core]]
set_property physical_name packet_out_valid [ipx::get_port_maps TVALID -of_objects [ipx::get_bus_interfaces packet_m_axis -of_objects [ipx::current_core]]]
ipx::add_port_map TKEEP [ipx::get_bus_interfaces packet_m_axis -of_objects [ipx::current_core]]
set_property physical_name packet_out_keep [ipx::get_port_maps TKEEP -of_objects [ipx::get_bus_interfaces packet_m_axis -of_objects [ipx::current_core]]]
ipx::add_port_map TREADY [ipx::get_bus_interfaces packet_m_axis -of_objects [ipx::current_core]]
set_property physical_name packet_out_ready [ipx::get_port_maps TREADY -of_objects [ipx::get_bus_interfaces packet_m_axis -of_objects [ipx::current_core]]]
ipx::associate_bus_interfaces -busif packet_m_axis -clock clk [ipx::current_core]

ipx::add_bus_interface payload_in_rx [ipx::current_core]
set_property abstraction_type_vlnv xilinx.com:interface:aximm_rtl:1.0 [ipx::get_bus_interfaces payload_in_rx -of_objects [ipx::current_core]]
set_property bus_type_vlnv xilinx.com:interface:aximm:1.0 [ipx::get_bus_interfaces payload_in_rx -of_objects [ipx::current_core]]
set_property display_name payload_in_rx [ipx::get_bus_interfaces payload_in_rx -of_objects [ipx::current_core]]
set_property abstraction_type_vlnv xilinx.com:interface:axis_rtl:1.0 [ipx::get_bus_interfaces payload_in_rx -of_objects [ipx::current_core]]
set_property bus_type_vlnv xilinx.com:interface:axis:1.0 [ipx::get_bus_interfaces payload_in_rx -of_objects [ipx::current_core]]
ipx::add_port_map TDATA [ipx::get_bus_interfaces payload_in_rx -of_objects [ipx::current_core]]
set_property physical_name payload_in_data [ipx::get_port_maps TDATA -of_objects [ipx::get_bus_interfaces payload_in_rx -of_objects [ipx::current_core]]]
ipx::add_port_map TLAST [ipx::get_bus_interfaces payload_in_rx -of_objects [ipx::current_core]]
set_property physical_name payload_in_last [ipx::get_port_maps TLAST -of_objects [ipx::get_bus_interfaces payload_in_rx -of_objects [ipx::current_core]]]
ipx::add_port_map TVALID [ipx::get_bus_interfaces payload_in_rx -of_objects [ipx::current_core]]
set_property physical_name payload_in_valid [ipx::get_port_maps TVALID -of_objects [ipx::get_bus_interfaces payload_in_rx -of_objects [ipx::current_core]]]
ipx::associate_bus_interfaces -busif payload_in_rx -clock clk [ipx::current_core]

ipx::add_bus_interface payload_from_user [ipx::current_core]
set_property abstraction_type_vlnv xilinx.com:interface:axis_rtl:1.0 [ipx::get_bus_interfaces payload_from_user -of_objects [ipx::current_core]]
set_property bus_type_vlnv xilinx.com:interface:axis:1.0 [ipx::get_bus_interfaces payload_from_user -of_objects [ipx::current_core]]
set_property display_name payload_from_user [ipx::get_bus_interfaces payload_from_user -of_objects [ipx::current_core]]
ipx::add_port_map TDATA [ipx::get_bus_interfaces payload_from_user -of_objects [ipx::current_core]]
set_property physical_name payload_in_data_1 [ipx::get_port_maps TDATA -of_objects [ipx::get_bus_interfaces payload_from_user -of_objects [ipx::current_core]]]
ipx::add_port_map TLAST [ipx::get_bus_interfaces payload_from_user -of_objects [ipx::current_core]]
set_property physical_name payload_in_last_1 [ipx::get_port_maps TLAST -of_objects [ipx::get_bus_interfaces payload_from_user -of_objects [ipx::current_core]]]
ipx::add_port_map TVALID [ipx::get_bus_interfaces payload_from_user -of_objects [ipx::current_core]]
set_property physical_name payload_in_valid_1 [ipx::get_port_maps TVALID -of_objects [ipx::get_bus_interfaces payload_from_user -of_objects [ipx::current_core]]]
ipx::add_port_map TKEEP [ipx::get_bus_interfaces payload_from_user -of_objects [ipx::current_core]]
set_property physical_name payload_in_keep [ipx::get_port_maps TKEEP -of_objects [ipx::get_bus_interfaces payload_from_user -of_objects [ipx::current_core]]]
ipx::add_port_map TREADY [ipx::get_bus_interfaces payload_from_user -of_objects [ipx::current_core]]
set_property physical_name payload_in_ready [ipx::get_port_maps TREADY -of_objects [ipx::get_bus_interfaces payload_from_user -of_objects [ipx::current_core]]]
ipx::associate_bus_interfaces -busif payload_from_user -clock clk [ipx::current_core]

ipx::add_bus_interface payload_to_user [ipx::current_core]
set_property abstraction_type_vlnv xilinx.com:interface:axis_rtl:1.0 [ipx::get_bus_interfaces payload_to_user -of_objects [ipx::current_core]]
set_property bus_type_vlnv xilinx.com:interface:axis:1.0 [ipx::get_bus_interfaces payload_to_user -of_objects [ipx::current_core]]
set_property interface_mode master [ipx::get_bus_interfaces payload_to_user -of_objects [ipx::current_core]]
set_property display_name payload_to_user [ipx::get_bus_interfaces payload_to_user -of_objects [ipx::current_core]]
ipx::add_port_map TDATA [ipx::get_bus_interfaces payload_to_user -of_objects [ipx::current_core]]
set_property physical_name payload_out_data [ipx::get_port_maps TDATA -of_objects [ipx::get_bus_interfaces payload_to_user -of_objects [ipx::current_core]]]
ipx::add_port_map TLAST [ipx::get_bus_interfaces payload_to_user -of_objects [ipx::current_core]]
set_property physical_name payload_out_last [ipx::get_port_maps TLAST -of_objects [ipx::get_bus_interfaces payload_to_user -of_objects [ipx::current_core]]]
ipx::add_port_map TVALID [ipx::get_bus_interfaces payload_to_user -of_objects [ipx::current_core]]
set_property physical_name payload_out_valid [ipx::get_port_maps TVALID -of_objects [ipx::get_bus_interfaces payload_to_user -of_objects [ipx::current_core]]]
ipx::add_port_map TKEEP [ipx::get_bus_interfaces payload_to_user -of_objects [ipx::current_core]]
set_property physical_name payload_out_keep [ipx::get_port_maps TKEEP -of_objects [ipx::get_bus_interfaces payload_to_user -of_objects [ipx::current_core]]]
ipx::associate_bus_interfaces -busif payload_to_user -clock clk [ipx::current_core]

ipx::add_bus_interface payload_len_rx [ipx::current_core]
set_property abstraction_type_vlnv xilinx.com:interface:axis_rtl:1.0 [ipx::get_bus_interfaces payload_len_rx -of_objects [ipx::current_core]]
set_property bus_type_vlnv xilinx.com:interface:axis:1.0 [ipx::get_bus_interfaces payload_len_rx -of_objects [ipx::current_core]]
set_property display_name payload_len_rx [ipx::get_bus_interfaces payload_len_rx -of_objects [ipx::current_core]]
ipx::add_port_map TDATA [ipx::get_bus_interfaces payload_len_rx -of_objects [ipx::current_core]]
set_property physical_name payload_length_data [ipx::get_port_maps TDATA -of_objects [ipx::get_bus_interfaces payload_len_rx -of_objects [ipx::current_core]]]
ipx::add_port_map TVALID [ipx::get_bus_interfaces payload_len_rx -of_objects [ipx::current_core]]
set_property physical_name payload_length_valid [ipx::get_port_maps TVALID -of_objects [ipx::get_bus_interfaces payload_len_rx -of_objects [ipx::current_core]]]
ipx::associate_bus_interfaces -busif payload_len_rx -clock clk [ipx::current_core]
set_property supported_families {virtexu Beta virtexuplus Beta virtexuplusHBM Beta zynquplus Beta kintexu Beta kintexuplus Beta} [ipx::current_core]

set_property core_revision 0 [ipx::current_core]
ipx::create_xgui_files [ipx::current_core]
ipx::update_checksums [ipx::current_core]
ipx::save_core [ipx::current_core]
set_property ip_repo_paths [list "$project_dir/$project_name/${project_name}.srcs/sources_1/bd/${project_name}" "${project_dir}/../hls_ips"] [current_project]
update_ip_catalog
ipx::check_integrity -quiet [ipx::current_core]
ipx::archive_core $project_dir/$project_name/${project_name}.srcs/sources_1/bd/${project_name}/${project_name}_1.0.zip [ipx::current_core]
close_project
exit
