
class base_seq extends uvm_sequence #(seq_item);
  
  // factory Registration

  `uvm_object_utils(base_seq);
  
  
  
  // Constructor-----------------

  function new(string name = "base_seq");
    super.new(name);

  endfunction


  task body();
    `uvm_info(get_type_name(), "INSIDE SEQUENCE BODY", UVM_LOW);
  endtask

endclass


