class apb_wr_all_rd_all_test extends apb_base_test;
  `uvm_component_utils(apb_wr_all_rd_all_test)

  function new(string name = "apb_wr_all_rd_all_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    apb_reset_sequence   reset_seq;
    apb_write_sequence   write_seq;
    apb_read_sequence    read_seq;
    logic [31:0]         write_data;

    phase.raise_objection(this);
    
    `uvm_info("TEST", "APB WRITE ALL ADDRESS / READ ALL ADDRESS", UVM_NONE)
    //reset
    reset_seq = apb_reset_sequence::type_id::create("reset_seq");
    reset_seq.start(env.agt.seqr);

    //write
    `uvm_info("TEST", "Starting Write of all Address.....", UVM_LOW)
    for (int addr=0; addr<=255; addr++) begin
      write_data = $urandom;
      write_seq = apb_write_sequence::type_id::create("write_seq");
      write_seq.addr = addr;
      write_seq.data = write_data;
      `uvm_info("TEST", $sformatf("WRITE: ADDR=0x%0h WDATA=0x%0h", addr, write_data), UVM_LOW)
      write_seq.start(env.agt.seqr);
      
    end

    //Read
    `uvm_info("TEST", "Starting Read of all Address.....", UVM_LOW)
    
    for (int addr=0; addr<=255; addr++) begin
      read_seq = apb_read_sequence::type_id::create("read_seq");
      read_seq.addr = addr;
      `uvm_info("TEST", $sformatf("WRITE: ADDR=0x%0h", addr), UVM_LOW)
      read_seq.start(env.agt.seqr);
    
    end

    phase.drop_objection(this);

  endtask

endclass





