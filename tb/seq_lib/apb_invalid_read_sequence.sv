class apb_invalid_read_sequence extends apb_base_sequence;

  `uvm_object_utils(apb_invalid_raed_sequence)

  logic [31:0] invalid_addr;
  logic [31:0] data;

  function new(string name = "apb_invalid_read_sequence");
    super.new(name);
  endfunction


  task body();

    send_reset();

    send_read(invalid_addr, data);

  endtask

endclass


