# Get the directory where this script is located
set script_dir [file dirname [file normalize [info script]]]

# Change to script directory
cd $script_dir

# Set project name and location
set project_name "project_1"
set project_dir "./vivado"

# Create project
create_project $project_name $project_dir -part xc7a200tsbg484-1 -force

# Set project properties
set_property target_language Verilog [current_project]
set_property simulator_language Mixed [current_project]

# Parse a filelist (.f): ignore blank lines and comments, resolve relative paths.
proc read_filelist {base_dir filelist_name} {
    set filelist_path [file normalize [file join $base_dir $filelist_name]]
    if {![file exists $filelist_path]} {
        error "Filelist not found: $filelist_path"
    }

    set fp [open $filelist_path r]
    set content [read $fp]
    close $fp

    set files [list]
    foreach line [split $content "\n"] {
        set trimmed [string trim $line]
        if {$trimmed eq ""} {
            continue
        }
        if {[string match "#*" $trimmed]} {
            continue
        }

        lappend files [file normalize [file join $base_dir $trimmed]]
    }
    return $files
}

# Read filelists
set sv_files    [read_filelist $script_dir "filelist_sv.f"]
set vhdl_files  [read_filelist $script_dir "filelist_vhdl.f"]
set tb_files    [read_filelist $script_dir "filelist_tb.f"]

# Add source files (SystemVerilog + VHDL)
set source_files [concat $sv_files $vhdl_files]
if {[llength $source_files] > 0} {
    add_files -fileset sources_1 $source_files
}

# Add testbench files
if {[llength $tb_files] > 0} {
    add_files -fileset sim_1 $tb_files
}

# Set top module
set_property top fullAdder [get_filesets sources_1]
set_property top test_fullAdder [get_filesets sim_1]

# Update compile order
update_compile_order -fileset sources_1
update_compile_order -fileset sim_1

puts "Project created successfully!"