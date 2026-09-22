
class apb_driver extends uvm_driver#(apb_seq_item);

  //Factory Registration
  `uvm_component_utils(apb_driver)

  virtual apb_if vif;

  //Constructor
  function new(string name = "apb_driver", uvm_component parent = null);
    super.new(name, parent);
  endfunction

 // Build Phase 

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    if (!uvm_config_db#(virtual apb_if)::get(this, "", "vif", vif))
      `uvm_fatal("NO_VIF", "Virtual interface not found")

    `uvm_info(get_type_name(), "INSIDE DRIVER BUILD PHASE", UVM_LOW)
  endfunction

 // connect Phase 

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info(get_type_name(), "INSIDE DRIVER CONNECT PHASE", UVM_LOW)
  endfunction

 // RUN Phase 

  task run_phase(uvm_phase phase);

    forever begin

      seq_item_port.get_next_item(req);

      if (!req.PRESETn) begin
        drive_reset();
      end
      else if (req.PWRITE) begin

        drive_write();
      end

      else begin
        drive_read();
      end

      seq_item_port.item_done();


    end
  endtask

  task drive_reset();
    `uvm_info("DRIVER", "Driving RESET", UVM_LOW)

    vif.PRESETn     <= 0;
    vif.PSEL        <= 0;
    vif.PENABLE     <= 0;
    vif.PADDR       <= 0;

    @(posedge vif.PCLK);

    vif.PRESETn   <=1;

  endtask

  task drive_write();
    `uvm_info("DRIVER", "Driving Write", UVM_LOW)

    //setup Phase 
    
    vif.PSEL       <= 1'b1;
    vif.PENABLE     <= 1'b0;
    vif.PWRITE      <= 1'b1;
    vif.PADDR       <= req.PADDR;
    vif.PWDATA      <= req.PWDATA;
    vif.PREADY      <= 0;

  //  `uvm_info("DRIVER", $sformat("SETUP: WRITE=%0b ADDR=0x%08h DATA=0x%08h",req.PWRITE, req.PADDR, req.PWDATA), UVM_LOW)

    //Access Phase
    @(posedge vif.PCLK);
    vif.PENABLE     <= 1'b1;

    for (int i=0; i<100; i++) begin
      @(posedge vif.PCLK);
      if (vif.PREADY == 1'b1)
        break;
    end

    if (vif.PREADY != 1'b1)
      `uvm_fatal("APB_TIMEOUT", "PREADY was not asserted within 100 clock cycle")

    //wait (vif.PREADY == 1'b1);

    //End Transfer

    @(posedge vif.PCLK);
    vif.PSEL      <= 1'b0;
    vif.PENABLE   <= 1'b0;

  endtask

  task drive_read();
    `uvm_info("DRIVER", "Driving Read", UVM_LOW)

    //setup Phase

    vif.PSEL        <= 1'b1;
    vif.PENABLE     <= 1'b0;
    vif.PWRITE      <= 1'b0;
    vif.PADDR       <= req.PADDR;
    vif.PREADY      <= 0;
    
  //  `uvm_info("DRIVER", $sformat("SETUP: WRITE=%0b ADDR=0x%08h",req.PWRITE, req.PADDR), UVM_LOW)


    //Access Phase
    @(posedge vif.PCLK);
    vif.PENABLE     <= 1'b1;


    for (int i=0; i<100; i++) begin
      @(posedge vif.PCLK);
      if (vif.PREADY == 1'b1)
        break;
    end 

    if (vif.PREADY != 1'b1)
      `uvm_fatal("APB_TIMEOUT", "PREADY was not asserted within 100 clock cycle")


    //wait (vif.PREADY == 1'b1);

    //End Transfer

    @(posedge vif.PCLK);
    vif.PSEL     <= 1'b0;
    vif.PENABLE   <= 1'b0;

  endtask







endclass





