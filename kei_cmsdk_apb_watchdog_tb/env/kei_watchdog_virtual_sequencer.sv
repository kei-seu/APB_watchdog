`ifndef KEI_WATCHDOG_VIRTUAL_SEQUENCER_SV
`define KEI_WATCHDOG_VIRTUAL_SEQUENCER_SV

class kei_watchdog_virtual_sequencer extends uvm_sequencer;

  // add sub-instances' sqr handles below for routing
  apb_master_sequencer apb_mst_sqr;
  kei_watchdog_config cfg;
  kei_watchdog_rgm rgm;

  `uvm_component_utils(kei_watchdog_virtual_sequencer)


  function new (string name = "kei_watchdog_virtual_sequencer", uvm_component parent);
    super.new(name, parent);
  endfunction

function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(kei_watchdog_config)::get(this, "", "cfg",cfg)) begin
      `uvm_fatal("GTCFG","cannot get cfg from confgdb")
    end
    if(!uvm_config_db#(kei_watchdog_rgm)::get(this, "", "rgm",rgm)) begin
      `uvm_fatal("GTCFG","cannot get rgm from confgdb")
    end
  endfunction

  

endclass


`endif
