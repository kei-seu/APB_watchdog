`ifndef KEI_WATCHDOG_REG_ENABLE_INRT_SV
`define KEI_WATCHDOG_REG_ENABLE_INRT_SV
  
class kei_watchdog_reg_enable_inrt extends kei_watchdog_base_element_sequence;
  `uvm_object_utils(kei_watchdog_reg_enable_inrt)

  function new (string name = "kei_watchdog_reg_enable_inrt");
    super.new(name);
  endfunction

  virtual task body();
    int rd_val;
    
    super.body();
    rgm.WDOGCONTROL.mirror(status);
    @(posedge vif.apb_clk); 
    rgm.WDOGCONTROL.INTEN.set('b1);
    rgm.WDOGCONTROL.update(status);
  
  endtask



endclass


`endif
