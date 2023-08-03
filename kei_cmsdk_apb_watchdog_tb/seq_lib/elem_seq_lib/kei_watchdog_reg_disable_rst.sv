`ifndef KEI_WATCHDOG_REG_DISABLE_RST_SV
`define KEI_WATCHDOG_REG_DISABLE_RST_SV
  
class kei_watchdog_reg_disable_rst extends kei_watchdog_base_element_sequence;
  `uvm_object_utils(kei_watchdog_reg_disable_rst)

  function new (string name = "kei_watchdog_reg_disable_rst");
    super.new(name);
  endfunction

  virtual task body();
    int rd_val;
    
    super.body();
    rgm.WDOGCONTROL.RESEN.set('b0);
    rgm.WDOGCONTROL.update(status);
  
  endtask



endclass


`endif
