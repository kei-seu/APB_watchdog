#############################
# User variables
#############################
TB       	= kei_watchdog_tb
SEED     	= 1
GUI      ?= 0
VERDI    ?= 0
COV      ?= 1
VERB     ?= UVM_HIGH
OUT      ?= out
TESTNAME ?= kei_watchdog_regacc_test
DFILES  	= ../../cmsdk_apb_watchdog/cmsdk_apb_watchdog.v \
						../../cmsdk_apb_watchdog/cmsdk_apb_watchdog_defs.v \
						../../cmsdk_apb_watchdog/cmsdk_apb_watchdog_frc.v 
VFILES   +=  ../vip_lib/apb_pkg/apb_if.sv \
						 ../vip_lib/apb_pkg/apb_pkg.sv \
						 ../env/kei_watchdog_pkg.sv \
						 ../tb/kei_watchdog_if.sv \
						 ../tb/kei_watchdog_tb.sv
TESTLIST  = kei_watchdog_apbacc_test \
						kei_watchdog_regacc_test \
						kei_watchdog_integration_test \
						kei_watchdog_resen_test \
						kei_watchdog_countdown_test \
						kei_watchdog_disable_intr_test \
						kei_watchdog_lock_test \
						kei_watchdog_reload_test 
#############################
# Environment variables
#############################
VCOMP_INC = +incdir+../../cmsdk_apb_watchdog \
						+incdir+../vip_lib/apb_pkg \
						+incdir+../{cfg,cov,reg,env,seq_lib,seq_lib/elem_seq_lib,test,tb} 
VCOMP    = vlogan -full64 -ntb_opts uvm-1.2 -sverilog -timescale=1ps/1ps -nc -l $(OUT)/log/comp.log $(VCOMP_INC)
ELAB     = vcs -full64 -ntb_opts uvm-1.2 -debug_acc+all -l $(OUT)/log/elab.log -sim_res=1ps 
RUN      = $(OUT)/obj/$(TB).simv -l run.log -sml +ntb_random_seed=$(SEED)  +UVM_VERBOSITY=$(VERB) -cm_name $(CM_NAME)
COV_OPTS = -full64 -dir 
CM_DIR  ?= $(OUT)/cov.vdb
CM_REGR_DIR ?= $(OUT)/merge.vdb
CM_NAME ?= $(TESTNAME)_$(SEED)
ifeq ($(GUI),1)
RUN += -gui
endif
ifeq ($(VERDI),1)
VCOMP += -kdb -lca
RUN += -verdi
endif
ifeq ($(COV),1)
	ELAB  += -cm line+cond+fsm+tgl+branch+assert -cm_dir $(CM_DIR)
	RUN += -cm line+cond+fsm+tgl+branch+assert -covg_cont_on_error
endif

all: clean prepare comp elab regr mergecov dvemergecov

prepare:
	mkdir -p $(OUT)/work
	mkdir -p $(OUT)/log
	mkdir -p $(OUT)/sim
	mkdir -p $(OUT)/obj

comp: prepare
	$(VCOMP) 
	$(VCOMP) $(DFILES) $(VFILES)

elab: comp
	$(ELAB) -top $(TB) -o $(OUT)/obj/$(TB).simv

run:
	$(RUN) +UVM_TESTNAME=$(TESTNAME) -cm_dir $(CM_DIR)

regr: 
			for t in $(TESTLIST); do \
			$(RUN) +UVM_TESTNAME=$$t -l $(OUT)/sim/$$t.log +vpdfile+$(OUT)/sim/$$t_$(SEED)_$(VPDFILE) -cm_dir $(OUT)/$$t.vdb; \
			done

mergecov:
	urg -format both $(COV_OPTS) $(OUT)/*.vdb -dbname $(CM_REGR_DIR)

dvecov:
	dve $(COV_OPTS) $(CM_DIR)

dvemergecov:
	dve $(COV_OPTS) $(CM_REGR_DIR)

verdicov:
	verdi -cov -covdir $(CM_DIR)

verdimergecov:
	verdi -cov -covdir $(CM_REGR_DIR)

htmlmergecov:
	firefox urgReport/dashboard.html

clean:
	rm -rf $(OUT) 64 AN.DB DVEfiles csrc *.simv *.simv.daidir *.simv.vdb ucli.key
	rm -rf *.log* *.vpd *.h urgReport

