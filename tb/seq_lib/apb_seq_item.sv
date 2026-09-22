
class apb_seq_item extends uvm_sequence_item;

  logic             PRESETn;
  logic             PWRITE;
  rand logic [31:0] PADDR;
  rand logic [31:0] PWDATA;

  logic             PRDATA;
  logic             PREADY;
  logic             PSLVERR;




  `uvm_object_utils(apb_seq_item)
  
  function new(string name = "apb_seq_item");
    
    super.new(name);

  endfunction



endclass



