class apb_all_addr_data_pattern_test extends apb_base_test;

  `uvm_component_utils(apb_all_addr_data_pattern_test)

  function new(string name = "apb_all_addr_data_pattern_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction


  task run_phase(uvm_phase phase);

    apb_reset_sequence   reset_seq;
    apb_write_sequence   write_seq;
    apb_read_sequence    read_seq;
    logic [31:0] patterns [0:3];

    phase.raise_objection(this);
    `uvm_info("TEST", "APB ALL ADDRESS DATA PATTERN TEST", UVM_NONE)

    patterns[0] = 32'h00000000;
    patterns[1] = 32'hFFFFFFFF;
    patterns[2] = 32'hAAAAAAAA;
    patterns[3] = 32'h55555555;

    //Reset
    reset_seq = apb_reset_sequence::type_id::create("reset_seq");
    reset_seq.start(env.agt.seqr);

    for (int addr = 0; addr <= 255; addr++) begin
      `uvm_info("TEST", $sformatf("Testing Address = 0x%0h", addr), UVM_LOW)
      foreach (patterns[i]) begin
        write_seq = apb_write_sequence::type_id::create("write_seq");
        write_seq.addr = addr;
        write_seq.data = patterns[i];
        `uvm_info("TEST", $sformatf("WRITE: ADDR=0x%0h DATA=0x%08h", addr, patterns[i]), UVM_LOW)
        write_seq.start(env.agt.seqr);

        // READ
        read_seq = apb_read_sequence::type_id::create("read_seq");
        read_seq.addr = addr;
        `uvm_info("TEST", $sformatf("READ : ADDR=0x%0h EXPECTED=0x%08h", addr, patterns[i]), UVM_LOW)
        read_seq.start(env.agt.seqr);
      end
    end
    phase.drop_objection(this);
  endtask
endclass
