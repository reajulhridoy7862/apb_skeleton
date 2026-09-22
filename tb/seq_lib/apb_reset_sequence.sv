class apb_reset_seq extends apb_base_sequence;

  `uvm_object_utils(apb_reset_sequence)

  function new(string name = "apb_reset_seq");
    super.new(name);
  endfunction


  task body();

    send_reset();
    

  endtask

endclass
