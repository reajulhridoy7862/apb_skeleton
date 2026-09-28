
class apb_environment extends uvm_env;

  `uvm_component_utils(apb_environment )

  apb_agent agt;
  apb_scoreboard sb;
  apb_functional_coverage fc;

  function new(string name = "apb_environment", uvm_component parent = null);
    super.new(name, parent);

  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    `uvm_info(get_type_name(), "INSIDE ENVIRONMENT BUILD PHASE", UVM_LOW)

    agt = apb_agent::type_id::create("agt", this);

    sb = apb_scoreboard::type_id::create("sb", this);
    fc = apb_functional_coverage::type_id::create("fc", this);

  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    agt.mon.analysis_port.connect(sb.analysis_imp);
    agt.mon.analysis_port.connect(fc.analysis_export);

    `uvm_info(get_type_name(), "INSIDE ENVIRONMENT CONNECT PHASE", UVM_LOW)

  endfunction

  task run_phase(uvm_phase phase);

    `uvm_info(get_type_name(), "INSIDE ENVIRONMENT RUN PHASE", UVM_LOW)
    
  endtask

endclass


