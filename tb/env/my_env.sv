
class my_env extends uvm_env;

  `uvm_component_utils(my_env)

  agent agt;
  scoreboard sb;

  function new(string name = "my_env", uvm_component parent = null);
    super.new(name, parent);

  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    `uvm_info(get_type_name(), "INSIDE ENVIRONMENT BUILD PHASE", UVM_LOW)

    agt = agent::type_id::create("agt", this);

    sb = scoreboard::type_id::create("sb", this);

  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    `uvm_info(get_type_name(), "INSIDE ENVIRONMENT CONNECT PHASE", UVM_LOW)

  endfunction

  task run_phase(uvm_phase phase);

    `uvm_info(get_type_name(), "INSIDE ENVIRONMENT RUN PHASE", UVM_LOW)
    
  endtask

endclass


