class apb_read_sequence extends apb_base_sequence;

  `uvm_object_utils(apb_read_sequence)

  logic [31:0] addr;

  function new(string name = "apb_write_sequence");
    super.new(name);
  endfunction


  task body();

    apb_seq_item req;
    req = apb_seq_item::type_id::create("req");

    start_item(req);
    req.PWRITE  = 1'b0;
    req.PADDR   = addr;
    finish_item(req);

  endtask

endclass

