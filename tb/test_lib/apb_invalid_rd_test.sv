class apb_invalid_rd_test extends apb_base_test;
  `uvm_component_utils(apb_invalid_rd_test)

  function new(string name = "apb_invalid_rd_test", uvm_component parent = null);
    super.new(name);
  endfunction

  task run_phase(uvm_phase phase);

    apb_reset_sequence    reset_seq;
    apb_write_sequence    write_seq;
    apb_read_sequence     read_seq;

    phase.raise_objection(this);

    `uvm_info("TEST", $sformatf("=============INVALID_ADDRESS_READ================"), UVM_LOW)

    //reset
    reset_seq = apb_reset_sequence::type_id::create("reset_seq");
    reset_seq.start(env.agt.seqr);


    //read
    read_seq = apb_read_sequence::type_id::create("read_seq");
    read_seq.addr = 32'hAAAAAAAA;
    `uvm_info("TEST", $sformatf("GEN: ADDR=0x%0h", read_seq.addr), UVM_LOW)
    read_seq.start(env.agt.seqr);


    phase.drop_objection(this);

    
  endtask

endclass



