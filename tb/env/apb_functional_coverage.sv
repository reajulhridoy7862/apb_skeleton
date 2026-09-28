class apb_functional_coverage extends uvm_subscriber #(apb_seq_item);

  `uvm_component_utils(apb_functional_coverage)

  apb_seq_item req;

  covergroup apb_cg;

    cp_write_read: coverpoint req.PWRITE {
      bins  READ = {0};
      bins WRITE = {1};
    }

    cp_error: coverpoint req.PSLVERR {
      bins NO_ERROR = {0};
      bins ERROR    = {1};
    }

    cp_address_valid: coverpoint (req.PADDR <= 32'd255) {
      bins VALID   = {1};
      bins INVALID = {0};
  }

    cp_address: coverpoint req.PADDR {
      bins LOW_ADDR   = {[0:63]};
      bins MID_LOW    = {[64:127]};
      bins MID_HIGH   = {[128:191]};
      bins HIGH_ADDR  = {[192:255]};
    }

    cp_write_data: coverpoint req.PWDATA iff (req.PWRITE) {
      bins ALL_ZERO = {32'h00000000};
      bins ALL_ONE  = {32'hFFFFFFFF};
      bins PATTERN_A = {32'hAAAAAAAA};
      bins PATTERN_5 = {32'h55555555};

      bins OTHER = default;
    }

    cp_read_data: coverpoint req.PRDATA iff (!req.PWRITE) {
      bins ALL_ZERO  = {32'h00000000};
      bins ALL_ONE   = {32'hFFFFFFFF};
      bins PATTERN_A = {32'hAAAAAAAA};
      bins PATTERN_5 = {32'h55555555};
      bins OTHER     = default;
    }

    cross cp_write_read, cp_address_valid;

  endgroup

  function new(string name = "apb_functional_coverage", uvm_component parent = null);
    super.new(name, parent);
    apb_cg =new();
    `uvm_info("FUNCTIONAL_COVERAGE", "Inside Functional coverage Constructor", UVM_LOW)
  endfunction

  function void write(apb_seq_item t);
    this.req = t;

    `uvm_info("FUNCTIONAL_COVERAGE", $sformatf("Sampling: PWRITE=%0b ADDR=0x%0h PWDATA=0x%0h PSLVERR=%0b", t.PWRITE, t.PADDR, t.PWDATA, t.PSLVERR), UVM_LOW)

    apb_cg.sample();
  endfunction

  function void report_phase(uvm_phase phase);

    `uvm_info("FUNCTIONAL_COVERAGE", $sformatf("Functional Coverage = %0.2f%%", apb_cg.get_coverage()), UVM_NONE)
  endfunction

endclass
