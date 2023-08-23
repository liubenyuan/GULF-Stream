# environment related stuff
# $ad_hdl_dir
# $ad_ghdl_dir
# $required_vivado_version

# This helper pocedure retrieves the value of varible from environment if exists,
# other case returns the provided default value
#  name - name of the environment variable
#  default_value - returned vale in case environment variable does not exists
proc get_env_param {name default_value} {
    if {[info exists ::env($name)]} {
        puts "Getting from environment the parameter: $name=$::env($name) "
        return $::env($name)
    } else {
        return $default_value
    }
}

variable ad_hdl_dir
# normalize gets absolute directory
set ad_hdl_default [file normalize [file join "../" [file dirname [info script]]]]
set ad_hdl_dir [get_env_param ADI_HDL_DIR $ad_hdl_default]
set required_vivado_version [get_env_param REQUIRED_VIVADO_VERSION "2022.2"]

# Define the ADI_IGNORE_VERSION_CHECK environment variable to skip version check
if {[info exists ::env(ADI_IGNORE_VERSION_CHECK)]} {
    set IGNORE_VERSION_CHECK 1
} elseif {![info exists IGNORE_VERSION_CHECK]} {
    set IGNORE_VERSION_CHECK 0
}

# perform version check
if {${IGNORE_VERSION_CHECK} == 0} {
    set current_vivado_version [version -short]

    if { [string first $required_vivado_version $current_vivado_version] == -1 } {
        puts ""
        catch {common::send_gid_msg -ssname BD::TCL -id 2041 -severity "ERROR" "This script was generated using Vivado <$required_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

        return 1
    }
}

# set ip_repo
proc set_ip_library {ip_repo} {
    variable ad_hdl_dir
    variable lib_dirs
    set lib_dirs $ad_hdl_dir/library
    set lib_dirs $ad_hdl_dir/ip_repo
    if {[info exists ::env(ADI_GHDL_DIR)]} {
        if {$ad_hdl_dir ne $ad_ghdl_dir} {
            lappend lib_dirs $ad_ghdl_dir/library
        }
    } else {
        # puts -nonew-line "INFO: ADI_GHDL_DIR not defined.\n"
    }

    if {$ip_repo ne ""} {
        lappend lib_dirs $ip_repo
    }

    return $lib_dirs
}

proc gen_hls_ip {ip_name module_name src_list target} {
    variable root_dir
    set proj_dir $root_dir/ip_repo/hls_ips/$ip_name
    file mkdir $proj_dir
    cd $proj_dir
    open_project $module_name
    set_top $module_name
    foreach src $src_list {
        add_files $root_dir/src/$ip_name/$src
    }
    open_solution "solution1" -flow_target vivado
    set_part $target
    create_clock -period 3.103 -name default
    config_rtl -reset all
    csynth_design
    export_design -rtl verilog
    # -display_name "ARP Server for 10G TOE Design" -description "Replies to ARP queries and resolves IP addresses." -vendor "ethz" -version "1.0"
}

proc addip {ipName displayName} {
    set vlnv_version_independent [lindex [get_ipdefs -all *${ipName}* -filter {UPGRADE_VERSIONS == ""}] end]
    return [create_bd_cell -type ip -vlnv $vlnv_version_independent $displayName]
}

# puts $ad_hdl_dir
# puts $required_vivado_version
# puts [file normalize [info script]]
