class apb_minimum_address_sequence extends apb_base_sequence;

  `uvm_object_utils(apb_minimum_address_sequence)

  logic [31:0] addr;
  logic [31:0] data;

  function new(string name = "apb_minimum_address_sequence");
    super.new(name);
  endfunction


  task body();

    send_reset();

    send_write(addr, data);
    send_read(addr);

  endtask 
endclass
