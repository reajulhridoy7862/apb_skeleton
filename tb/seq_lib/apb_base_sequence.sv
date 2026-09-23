
class apb_base_sequence extends uvm_sequence #(apb_seq_item);
  
  `uvm_object_utils(apb_base_sequence);
  
  function new(string name = "apb_base_sequence");
    super.new(name);

  endfunction


 /* task send_write(logic [31:0] addr, logic [31:0] data);

    apb_seq_item req;

    req = apb_seq_item::type_id::create("req");

    start_item(req);

    req.PWRITE  = 1'b1;
    req.PADDR   = addr;
    req.PWDATA  = data;

    finish_item(req);

  endtask

  task send_read(logic [31:0] addr);

    apb_seq_item req;

    req = apb_seq_item::type_id::create("req");

    start_item(req);

    req.PWRITE  = 1'b0;
    req.PADDR   = addr;

    finish_item(req);

  endtask


  task send_reset();

    apb_seq_item req;

    req = apb_seq_item::type_id::create("req");

    start_item(req);
    req.PRESETn = 0;

    req.PADDR   = '0;
    req.PWDATA  = '0;

    finish_item(req);

  endtask*/





  /*
  task body();
    `uvm_info(get_type_name(), "INSIDE SEQUENCE BODY", UVM_LOW);
  endtask*/

endclass


