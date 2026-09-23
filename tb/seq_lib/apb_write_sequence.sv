class apb_write_sequence extends apb_base_sequence;

  `uvm_object_utils(apb_write_sequence)

  logic [31:0] addr;
  logic [31:0] data;

  function new(string name = "apb_write_sequence");
    super.new(name);
  endfunction

  task body();

    apb_seq_item req;
    req = apb_seq_item::type_id::create("req");
    
    start_item(req);
    req.PWRITE  = 1'b1;
    req.PADDR   = addr;
    req.PWDATA  = data;
    finish_item(req);

  endtask

endclass

