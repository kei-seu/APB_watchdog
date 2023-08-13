`ifndef KEI_WATCHDOG_DISABLE_INTR_VIRT_SEQ_SV
`define KEI_WATCHDOG_DISABLE_INTR_VIRT_SEQ_SV
  
class kei_watchdog_disable_intr_virt_seq extends kei_watchdog_base_virtual_sequence;
  `uvm_object_utils(kei_watchdog_disable_intr_virt_seq)

  function new (string name = "kei_watchdog_disable_intr_virt_seq");
    super.new(name);
  endfunction

  virtual task body();
    int rd_val;
    uvm_status_e status = UVM_IS_OK;
    super.body(); 
    `uvm_info("body", "Entered...", UVM_LOW)
    `uvm_do_with( loadcount_seq, { load_val == 'h20; })
    `uvm_do( enable_inrt_seq )
    repeat(10) @(posedge vif.wdg_clk );
    `uvm_do( disable_inrt_seq )
    repeat(10) @(posedge vif.wdg_clk );
    `uvm_do( enable_inrt_seq )
    wait_int_rise();
    check_mis_ris( 1 , 1 ); 
    repeat(4) @(posedge vif.wdg_clk);


    `uvm_do( disable_inrt_seq )
    check_mis_ris( 0 , 1 );
    #2us;
    rgm.WDOGVALUE.read(status, rd_val);
    `uvm_do( enable_inrt_seq )
    `uvm_info("body", "Exiting...", UVM_LOW)
  endtask
  
  // mis : interrupt status register
  // ris : raw interrupt register
  virtual task check_mis_ris(input bit mis, input bit ris);
    rgm.WDOGRIS.mirror(status);
    void'(this.diff_value( ris , rgm.WDOGRIS.RAWINT.get() ));
    rgm.WDOGMIS.mirror(status);
    void'(this.diff_value( mis , rgm.WDOGMIS.INT.get() ));
  endtask

endclass


`endif
