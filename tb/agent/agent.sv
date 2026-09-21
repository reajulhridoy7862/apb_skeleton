
class agent extends uvm_agent;

  `uvm_component_utils(agent)

  driver drv;
  seqcr seqr;
  monitor mon;

  function new(string name = "agent", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    `uvm_info(get_type_name(), "INSIDE AGENT BUILD PHASE", UVM_LOW)

    drv = driver::type_id::create("drv", this);

    mon = monitor::type_id::create("mon", this);

    seqr = seqcr::type_id::create("seqr", this);
    
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    
    `uvm_info(get_type_name(), "INSIDE AGENT CONNECT PHASE", UVM_LOW)
    drv.seq_item_port.connect(seqr.seq_item_export);

  endfunction


  task run_phase(uvm_phase phase);
    
    `uvm_info(get_type_name(), "INSIDE AGENT RUN PHASE", UVM_LOW)
  endtask
endclass





