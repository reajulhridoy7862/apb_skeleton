class apb_reset_sequence extends apb_base_sequence;

  `uvm_object_utils(apb_reset_sequence)

  function new(string name = "apb_reset_sequence");
    super.new(name);
  endfunction


  task body();

    apb_seq_item req;
    req = apb_seq_item::type_id::create("req");

    start_item(req);

    req.PRESETn = 1'b0;
    req.PADDR   = '0;
    req.PWDATA  = '0;

    finish_item(req);
    

  endtask

endclass
