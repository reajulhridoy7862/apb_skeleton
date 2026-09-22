
class apb_environment extends uvm_env;

  `uvm_component_utils(apb_environment )

  apb_agent agt;
  //apb_scoreboard sb;

  function new(string name = "apb_environment", uvm_component parent = null);
    super.new(name, parent);

  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    `uvm_info(get_type_name(), "INSIDE ENVIRONMENT BUILD PHASE", UVM_LOW)

    agt = apb_agent::type_id::create("agt", this);

    //sb = apb_scoreboard::type_id::create("sb", this);

  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    `uvm_info(get_type_name(), "INSIDE ENVIRONMENT CONNECT PHASE", UVM_LOW)

  endfunction

  task run_phase(uvm_phase phase);

    `uvm_info(get_type_name(), "INSIDE ENVIRONMENT RUN PHASE", UVM_LOW)
    
  endtask

endclass


