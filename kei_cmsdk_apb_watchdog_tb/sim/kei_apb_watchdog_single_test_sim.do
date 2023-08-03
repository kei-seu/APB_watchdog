#======================================#
# TCL script for a mini regression     #
#======================================#
onbreak resume
onerror resume

# set environment variables
setenv DUT_SRC ../../cmsdk_apb_watchdog
setenv TB_SRC .

set INCDIR "+incdir+../../cmsdk_apb_watchdog \
					  +incdir+../vip_lib/apb_pkg \
					  +incdir+../cfg \
					  +incdir+../cov \
					  +incdir+../reg \
					  +incdir+../env \
					  +incdir+../seq_lib \
					  +incdir+../seq_lib/elem_seq_lib \
					  +incdir+../test "

set VCOMP "vlog -cover bst -timescale=1ns/1ps -l comp.log $INCDIR"


# clean the environment and remove trash files
set delfiles [glob work *.log *.ucdb sim.list]

file delete -force {*}$delfiles

# compile the design and dut with a filelist
vlib work
eval $VCOMP -f  kei_cmsdk_apb_watchdog.flist
eval $VCOMP -sv ../vip_lib/apb_pkg/apb_if.sv
eval $VCOMP -sv ../vip_lib/apb_pkg/apb_pkg.sv
eval $VCOMP -sv ../env/kei_watchdog_pkg.sv
eval $VCOMP -sv ../tb/kei_watchdog_if.sv
eval $VCOMP -sv ../tb/kei_watchdog_tb.sv

# call a UVM test
set TEST kei_watchdog_apbacc_test
set VERB UVM_HIGH
set SEED 0
#set SEED [expr int(rand() * 100)]
vsim work.kei_watchdog_tb -novopt -classdebug -sv_seed $SEED +UVM_TESTNAME=$TEST +UVM_VERBOSITY=$VERB -l sim.log

