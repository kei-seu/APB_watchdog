`ifndef KEI_WATCHDOG_PKG_SV
`define KEI_WATCHDOG_PKG_SV

package kei_watchdog_pkg;

  import uvm_pkg::*;
  `include "uvm_macros.svh"
  import apb_pkg::*;

  `include "kei_watchdog_reg.svh"
  `include "kei_watchdog_config.svh"
  `include "kei_watchdog_subscriber.sv"
  `include "kei_watchdog_cov.svh"
            
  `include "kei_watchdog_scoreboard.sv"
  `include "kei_watchdog_virtual_sequencer.sv"
  `include "kei_watchdog_env.sv"
  `include "kei_watchdog_adapter.sv"
            
  `include "kei_watchdog_seq_lib.svh"
  `include "kei_watchdog_tests.svh"

endpackage


`endif // KEI_WATCHDOG_PKG_SV
