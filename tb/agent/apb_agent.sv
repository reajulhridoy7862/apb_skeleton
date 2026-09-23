
class apb_agent extends uvm_agent;

  `uvm_component_utils(apb_agent)

  apb_driver drv;
  apb_sequencer seqr;
  apb_monitor mon;
  virtual apb_if vif;

  function new(string name = "apb_agent", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);


    `uvm_info(get_type_name(), "INSIDE AGENT BUILD PHASE", UVM_LOW)

    drv = apb_driver::type_id::create("drv", this);

    mon = apb_monitor::type_id::create("mon", this);

    seqr = apb_sequencer::type_id::create("seqr", this);
    
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





