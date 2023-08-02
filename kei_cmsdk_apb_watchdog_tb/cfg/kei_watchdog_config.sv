class kei_watchdog_config extends uvm_object;
  int seq_check_count;
  int seq_error_count;
  int scb_check_count;
  int scb_error_count;

  bit enable_cov = 1;
  bit enable_scb = 1;

  `uvm_object_utils(kei_watchdog_config)
  apb_config apb_cfg;
  // USER to specify the config items
  virtual kei_watchdog_if vif; 
  kei_watchdog_rgm rgm;

  function new (string name = "kei_watchdog_config");
    super.new(name);
    apb_cfg = apb_config::type_id::create("apb_cfg");

  endfunction : new


endclass