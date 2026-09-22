class apb_all_address_sequence extends apb_base_sequence;

  `uvm_object_utils(apb_all_address_sequence)

  function new(string name = "apb_all_address_sequence");
    super.new(name);\
  endfunction


  task body();

    logic [31:0] data;

    send_reset();

    for (int addr = 0; addr<=255; addr++) begin

      assert(std::randomize(data))

      send_write(addr, data);

      send_read(addr);

    end

  endtask

endclass


