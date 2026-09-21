
class scoreboard extends uvm_scoreboard;

  `uvm_component_utils(scoreboard)

  //Constructor

  function new(string name = "scoreboard", uvm_component parent = null);

    super.new(name, parent);

  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    `uvm_info(get_type_name(), "INSIDE SCOREBOARD BUILD PHASE", UVM_LOW)
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info(get_type_name(), "INSIDE SCOREBOARD CONNECT PHASE", UVM_LOW)

  endfunction

  task run_phase(uvm_phase phase);

    `uvm_info(get_type_name(), "INSIDE SCOREBOARD RUN PHASE", UVM_LOW)

  endtask

endclass


