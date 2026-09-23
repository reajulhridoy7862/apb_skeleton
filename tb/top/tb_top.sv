import apb_test_lib_pkg::*;

`include "uvm_macros.svh"
import uvm_pkg::*;

module tb_top;

  bit PCLK;
  apb_if intf(PCLK);

  initial begin
    PCLK = 0;
    forever #(`APB_CLK_PERIOD_NS / 2) PCLK = ~PCLK;
  end

  initial begin
    run_test("dummy_test");
  end


  initial begin 
    uvm_config_db#(virtual apb_if)::set(null, "uvm_test_top.env.agt.*", "vif", intf);
  end

  initial begin
    $dumpfile("waveform.vcd");
    $dumpvars(1, tb_top);
  end

endmodule

