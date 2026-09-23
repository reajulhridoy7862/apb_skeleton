class apb_overwrite_test extends apb_base_test;
  `uvm_component_utils(apb_overwrite_test)

  function new(string name = "apb_overwrite_test", uvm_component parent = null);
    super.new(name);
  endfunction

  task run_phase(uvm_phase phase);

    apb_reset_sequence    reset_seq;
    apb_write_sequence    write_seq;
    apb_read_sequence     read_seq;

    phase.raise_objection(this);

    //reset
    reset_seq = apb_reset_sequence::type_id::create("reset_seq");
    reset_seq.start(env.agt.seqr);

    //write 1st
    write_seq = apb_write_sequence::type_id::create("write_seq");
    write_seq.addr = 32'h00000014;
    write_seq.data = 32'h00000AAA;
    write_seq.start(env.agt.seqr);

    //write 2nd
    write_seq = apb_write_sequence::type_id::create("write_seq");
    write_seq.addr = 32'h00000014;
    write_seq.data = 32'h00000BBB;
    write_seq.start(env.agt.seqr);

    //write 3rd
    write_seq = apb_write_sequence::type_id::create("write_seq");
    write_seq.addr = 32'h00000014;
    write_seq.data = 32'h00000CCC;
    write_seq.start(env.agt.seqr);
    
    //read
    read_seq = apb_read_sequence::type_id::create("read_seq");
    read_seq.addr = 32'h00000014;
    read_seq.start(env.agt.seqr);

    phase.drop_objection(this);

    
  endtask

endclass


