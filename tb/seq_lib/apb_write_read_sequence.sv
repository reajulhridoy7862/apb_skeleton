class apb_write_read_sequence extends apb_base_sequence;

  `uvm_object_utils(apb_write_read_sequence);

  logic [31:0] addr;
  logic [31:0] data;

  function new(string name = "apb_write_read_sequence");
    super.new(name);
  endfunction

  task body();

    //RESET
    send_reset();

    //WRITE
    send_write(addr, data);

    //READ
    send_read(addr);

  endtask

endclass
