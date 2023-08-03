`ifndef KEI_WATCHDOG_REG_ENABLE_RST_SV
`define KEI_WATCHDOG_REG_ENABLE_RST_SV
  
class kei_watchdog_reg_enable_rst extends kei_watchdog_base_element_sequence;
  `uvm_object_utils(kei_watchdog_reg_enable_rst)

  function new (string name = "kei_watchdog_reg_enable_rst");
    super.new(name);
  endfunction

  virtual task body();
    int rd_val;
    super.body();
    rgm.WDOGCONTROL.RESEN.set('b1);  //set resen value = 1
    rgm.WDOGCONTROL.update(status);
  endtask

endclass


`endif
