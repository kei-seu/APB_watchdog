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
#set TEST kei_watchdog_apbacc_test
#set VERB UVM_HIGH
#set SEED 0
#set SEED [expr int(rand() * 100)]
#vsim work.kei_watchdog_tb -novopt -classdebug -sv_seed $SEED +UVM_TESTNAME=$TEST +UVM_VERBOSITY=$VERB -l sim.log

# prepare simrun folder
set timetag [clock format [clock seconds] -format "%Y%b%d-%H_%M"]
file mkdir regr_ucdb_${timetag}

# simulate with specific testname sequentially
set TestSets {  {kei_watchdog_apbacc_test 1} \
                {kei_watchdog_regacc_test 1} \
                {kei_watchdog_integration_test 1} \
                {kei_watchdog_resen_test 1} \
                {kei_watchdog_countdown_test 1} \
                {kei_watchdog_disable_intr_test 1} \
                {kei_watchdog_lock_test 1} \ 
                {kei_watchdog_reload_test 1} \ 
              }

foreach testset $TestSets {
  set testname [lindex $testset 0]
  set LoopNum [lindex $testset 1]
  for {set loop 0} {$loop < $LoopNum} {incr loop} {
    set seed [expr int(rand() * 100)]
    echo simulating $testname
    echo $seed +UVM_TESTNAME=$testname -l regr_ucdb_${timetag}/run_${testname}_${seed}.log
    vsim -novopt -onfinish stop -cover -sv_seed $seed \
         +UVM_TESTNAME=$testname -l regr_ucdb_${timetag}/run_${testname}_${seed}.log work.kei_watchdog_tb
    run -all
    coverage save regr_ucdb_${timetag}/${testname}_${seed}.ucdb
    quit -sim
  }
}

# merge the ucdb per test
#vcover merge -testassociated regr_ucdb_${timetag}/regr_${timetag}.ucdb ../doc/questa_vplan.ucdb {*}[glob regr_ucdb_${timetag}/*.ucdb]
vcover merge -testassociated regr_ucdb_${timetag}/regr_${timetag}.ucdb {*}[glob regr_ucdb_${timetag}/*.ucdb]

quit -f

