
class base_test extends uvm_test;

  `uvm_component_utils(base_test)
  my_env env;

  function new(string name = "my_env", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    `uvm_info(get_type_name(), "INSIDE BASE CLASS BUILD PHASE", UVM_LOW)

    env = my_env::type_id::create("env", this);

  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    `uvm_info(get_type_name(), "INSIDE BASE CLASS CONNECT PHASE", UVM_LOW)

  endfunction

  task run_phase(uvm_phase phase);
    
    phase.raise_objection(this);

    `uvm_info(get_type_name(), "INSIDE BASE CLASS RUN PHASE", UVM_LOW)
    

    phase.drop_objection(this);

  endtask

endclass
