
class apb_scoreboard extends uvm_scoreboard;

  `uvm_component_utils(apb_scoreboard)

  uvm_analysis_imp #(apb_seq_item, apb_scoreboard) analysis_imp;

  //Reference model

  bit [31:0] ref_mem [bit [31:0]];

  int pass_count = 0;
  int fail_count = 0;


  //Constructor

  function new(string name = "apb_scoreboard", uvm_component parent = null);

    super.new(name, parent);

  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    analysis_imp = new("analysis_imp", this);

    `uvm_info(get_type_name(), "INSIDE SCOREBOARD BUILD PHASE", UVM_LOW)
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info(get_type_name(), "INSIDE SCOREBOARD CONNECT PHASE", UVM_LOW)

  endfunction

  task run_phase(uvm_phase phase);

    `uvm_info(get_type_name(), "INSIDE SCOREBOARD RUN PHASE", UVM_LOW)

  endtask


  function void write(apb_seq_item tr);

    //RESET 
    if (!tr.PRESETn) begin
      ref_mem.delete();
      return;

    end

   //INVALID ADDRESS
   if(tr.PADDR > 32'd255) begin
     if (tr.PSLVERR == 1'b1) begin
       `uvm_info("SCOREBOARD", "PASS: Invalid address generated PSLVERR", UVM_LOW)
       pass_count++;
     end

     else begin
       `uvm_info("SCOREBOARD", "FAIL: Invalid address did not generated PSLVERR", UVM_LOW)
       fail_count++;

     end
     return;


   end

   //VALID WRITE ADDRESS

   if (tr.PWRITE) begin

     if (tr.PSLVERR !== 1'b0) begin
       `uvm_info("SCOREBOARD", "FAIL: valid write  generated PSLVERR", UVM_LOW)
       fail_count++;
     end

     else begin

       ref_mem[tr.PADDR] = tr.PWDATA;

       `uvm_info("SCOREBOARD", $sformatf("WRITE: EX_ADDR=0x%0h EX_DATA=0x%0h", tr.PADDR, ref_mem[tr.PADDR]), UVM_LOW)
       pass_count++;

     end
   end

   //VALID READ

   else begin

     if (tr.PSLVERR !== 1'b0) begin
       `uvm_info("SCOREBOARD", "FAIL: valid read  generated PSLVERR", UVM_LOW)

     end

     else if (ref_mem.exists(tr.PADDR)) begin
       `uvm_info("SCOREBOARD", $sformatf("PASS:READ -----------  ADDR=0x%0h EXPECTED= 0x%0h ACTUAL=0x%0h", tr.PADDR, ref_mem[tr.PADDR], tr.PRDATA), UVM_LOW)

       if (tr.PRDATA == ref_mem[tr.PADDR]) begin
         `uvm_info("SCOREBOARD", $sformatf("PASS:READ -----------  ADDR=0x%0h EXPECTED= 0x%0h ACTUAL=0x%0h", tr.PADDR, ref_mem[tr.PADDR], tr.PRDATA), UVM_LOW)
         pass_count++;

       end
     

       else begin

         `uvm_info("SCOREBOARD", "FAIL: ACTUAL and EXPECTED does not meet", UVM_LOW)

         fail_count++;

       end
     end

  end

  endfunction


  function void report_phase(uvm_phase phase);
     `uvm_info("SCOREBOARD", $sformatf("===================SCOREBOARD SUMMARY==============="), UVM_LOW)
     `uvm_info("SCOREBOARD", $sformatf("TOTAL PASS= %0d", pass_count), UVM_LOW)
     `uvm_info("SCOREBOARD", $sformatf("TOTAL FAIL= %0d", fail_count), UVM_LOW)
     `uvm_info("SCOREBOARD", $sformatf("====================================================="), UVM_LOW)
  endfunction

endclass


