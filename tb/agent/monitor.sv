
class monitor extends uvm_monitor;

  //Factory Registration
  `uvm_component_utils(monitor)

  //Constructor
  function new(string name = "monitor", uvm_component parent = null);
    super.new(name, parent);
  endfunction

 // Build Phase 

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info(get_type_name(), "INSIDE MONITOR BUILD PHASE", UVM_LOW)
  endfunction

 // connect Phase 

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info(get_type_name(), "INSIDE MONITOR CONNECT PHASE", UVM_LOW)
  endfunction

 // RUN Phase 

  task run_phase(uvm_phase phase);
   
    `uvm_info(get_type_name(), "INSIDE MONITOR RUN PHASE", UVM_LOW)
  endtask

endclass


