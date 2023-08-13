`ifndef KEI_WATCHDOG_RESEN_TEST_SV
`define KEI_WATCHDOG_RESEN_TEST_SV
class kei_watchdog_resen_test extends kei_watchdog_base_test;
  
  `uvm_component_utils(kei_watchdog_resen_test)

  function new (string name = "kei_watchdog_resen_test", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
  endfunction

 task run_phase(uvm_phase phase);

    kei_watchdog_resen_virt_seq seq; 
    seq = kei_watchdog_resen_virt_seq::type_id::create("seq");
    super.run_phase(phase);
    
    phase.raise_objection(this);
    seq.start(env.virt_sqr);
    phase.drop_objection(this);
  endtask

  virtual task do_init_clks();
    // wait reset posedge
    #1ns;
    @(negedge env.cfg.vif.apb_rstn);
    @(posedge env.cfg.vif.apb_rstn);
   // wait(env.apb_mst.vif.rstn == 1 );
   // wait(env.apb_mst.vif.rstn == 0 );
   // wait(env.apb_mst.vif.rstn == 1 );
    // TODO in sub-class
  endtask

  virtual task do_init_regs();
    // TODO in sub-class
  endtask
endclass


`endif
