
class apb_monitor extends uvm_monitor;

  //Factory Registration
  `uvm_component_utils(apb_monitor)

  virtual apb_if vif;
  uvm_analysis_port #(apb_seq_item) analysis_port;

  //Constructor
  function new(string name = "apb_monitor", uvm_component parent = null);
    super.new(name, parent);
  endfunction

 // Build Phase 

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual apb_if)::get(this, "", "vif", vif))
      `uvm_fatal("NO_VIF", "Virtual Interface not found")
    analysis_port = new("analysis_port", this);


    `uvm_info(get_type_name(), "INSIDE MONITOR BUILD PHASE", UVM_LOW)
  endfunction

 // connect Phase 

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info(get_type_name(), "INSIDE MONITOR CONNECT PHASE", UVM_LOW)
  endfunction

 // RUN Phase 

  task run_phase(uvm_phase phase);

    forever begin 
      collect_transaction();
    end
   
    `uvm_info(get_type_name(), "INSIDE MONITOR RUN PHASE", UVM_LOW)
  endtask
  
  task collect_transaction();
    apb_seq_item tr;

    //wait for Access
    @(posedge vif.PCLK);

    if (vif.PSEL && vif.PENABLE) begin
      //wait untill pready high
      wait( vif.PREADY == 1'b1);

      tr = apb_seq_item::type_id::create("tr");

      tr.PWRITE   <= vif.PWRITE;
      tr.PADDR    <= vif.PADDR;
      tr.PSLVERR  <= vif.PSLVERR;

      if (vif.PWRITE) begin
        tr.PWDATA     <= vif.PWDATA;
      end

      else begin
        tr.PRDATA     <= vif.PRDATA;

      end

      analysis_port.write(tr);

    end

  endtask

endclass


