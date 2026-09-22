class apb_overwrite_sequence extends apb_base_sequence;

  `uvm_object_utils(apb_overwrite_sequence)

  function new(string name = "apb_overwrite_sequence");
    super.new(name);
  endfunction


  task body();

    //RESET 
    send_reset();
  
    //WRITE 1ST
    send_write(32'h14, 32'hAAAA_AAAA);

    //WRITE 2ND
    send_write(32'h14, 32'hBBBB_BBBB);

    //WRITE 3RD
    send_write(32'h14, 32'hCCCC_CCCC);

    //READ
    send_read(32'h14);

  endtask

endclass
    
    



