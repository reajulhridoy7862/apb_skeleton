class dummy_test extends apb_base_test;
  `uvm_component_utils(dummy_test)

  function new(string name = "dummy_test", uvm_component parent = null);
    super.new(name);
  endfunction

  task run_phase(uvm_phase phase);
    apb_write_read_sequence seq;

    phase.raise_objection(this);

    seq = apb_write_read_sequence::type_id::create("seq");

    seq.addr = 32'h00000010;
    seq.data = 32'h12345678;

    seq.start(env.agt.seqr);

    phase.drop_objection(this);
    
  endtask

endclass


