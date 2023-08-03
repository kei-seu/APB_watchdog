`ifndef KEI_WATCHDOG_LOADCOUNT_SV
`define KEI_WATCHDOG_LOADCOUNT_SV
  
class kei_watchdog_loadcount extends kei_watchdog_base_element_sequence;
  `uvm_object_utils(kei_watchdog_loadcount)
  rand int load_val;

  constraint cstr{
    soft load_val inside{['h1:'hffffff]};
  };
  function new (string name = "kei_watchdog_loadcount");
    super.new(name);
  endfunction

  virtual task body();
    int rd_val;

    super.body();
    rgm.WDOGLOAD.mirror(status);
    @(posedge vif.wdg_clk);
    rgm.WDOGLOAD.write(status, load_val); 
    rgm.WDOGLOAD.read(status, rd_val); 
    void'(this.diff_value( rd_val , load_val));
  
  endtask



endclass


`endif
