class apb_reset_test extends apb_base_test;

  `uvm_component_utils(apb_reset_test)

  function new(string name = "apb_reset_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);

    apb_reset_sequence  reset_seq;
    phase.raise_objection(this);
    reset_seq = apb_reset_sequence::type_id::create("reset_seq");

    reset_seq.start(env.agt.seqr);
    phase.drop_objection(this);

  endtask

endclass


    
