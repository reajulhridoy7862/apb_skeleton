class apb_random_test extends apb_base_test;
  `uvm_component_utils(apb_random_test)

  function new(string name = "apb_random_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    apb_reset_sequence   reset_seq;
    apb_write_sequence   write_seq;
    apb_read_sequence    read_seq;
    logic [31:0]         write_data;
    int                  addr;
    int num_random      = 20;

    phase.raise_objection(this);
    
    `uvm_info("TEST", "APB RANDOM ADDRESS WRITE AND READ WITH RANDOM DATA", UVM_NONE)
    //reset
    reset_seq = apb_reset_sequence::type_id::create("reset_seq");
    reset_seq.start(env.agt.seqr);

    
    `uvm_info("TEST", "Starting Write and read of all Address.....", UVM_LOW)
    for (int i=0; i<=num_random; i++) begin
      //write
      write_data = $urandom;
      addr       = $urandom_range(1, 255);
      write_seq = apb_write_sequence::type_id::create("write_seq");
      write_seq.addr = addr;
      write_seq.data = write_data;
      `uvm_info("TEST", $sformatf("WRITE: ADDR=0x%0h WDATA=0x%0h", addr, write_data), UVM_LOW)
      write_seq.start(env.agt.seqr);
    
      //Read
      read_seq = apb_read_sequence::type_id::create("read_seq");
      read_seq.addr = addr;
      `uvm_info("TEST", $sformatf("WRITE: ADDR=0x%0h", addr), UVM_LOW)
      read_seq.start(env.agt.seqr);
    end 

    phase.drop_objection(this);

  endtask

endclass


