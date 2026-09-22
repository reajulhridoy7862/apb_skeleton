class apb_random_sequence extends apb_base_sequence;

  `uvm_object_utils(apb_random_sequence)

  int num_random;

  function new(string name = "apb_random_sequence");
    super.new(name);

    num_random = 10;

  endfunction

  task body();

    send_reset();

    apb_seq_item req;

    for (int i=0; i<num_random; i++) begin
      req = apb_seq_item::type_id::create("req");

      if (!req.randomize())
        `uvm_fatal("RAN_ERR", "Randomizatiion Failed")

      send_write(req.PADDR, req.PWDATA);

      send_read(req.PADDR);

    end

  endtask 

endclass



