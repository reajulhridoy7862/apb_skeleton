module apb_assertion (
  
  apb_if vif
  );

  //1. When PENABLE is high PSEL must also be high

  property p_penable_requires_psel;
    @(posedge vif.PCLK)
    disable iff(!vif.PRESETn)
    vif.PENABLE |-> vif.PSEL;
  endproperty

  a_penable_requires_psel:
    assert property (p_penable_requires_psel)
    else $error("APB ASSERTION FAILED: PENABLE is high while Psel is low");


  //2. Every setup phase must be followed by access phase// 
  property p_setup_to_access;
    @(posedge vif.PCLK)
    disable iff(!vif.PRESETn)
    (vif.PSEL && !vif.PENABLE) |=> (vif.PSEL && vif.PENABLE);
  endproperty

  a_setup_to_access: 
    assert property (p_setup_to_access)
    else $error("APB ASSERTION FAILED: Setup Phase was not followed by Access Phase");


  //3. PREADY is meaningful only in access phase

  property p_pready_only_in_access_phase;
    @(posedge vif.PCLK)
    disable iff(!vif.PRESETn)
    vif.PREADY |-> (vif.PSEL && vif.PENABLE);
  endproperty

  a_pready_only_in_access_phase:
    assert property (p_pready_only_in_access_phase)
    else $error("APB ASSERTION FAILED: PREADY asserted outside Access Phase");

  
  //4. Read transaction must have PWRITE = 0
  property p_read_transaction;
    @(posedge vif.PCLK)
    disable iff (!vif.PRESETn)
    (vif.PSEL && vif.PENABLE && !vif.PWRITE) |-> !vif.PWRITE;
  endproperty

  a_read_transaction:
    assert property (p_read_transaction)
    else $error("APB ASSERTION FAILED: Invalid READ transaction");

  //5. Write transaction must have Pwrite = 1
  property p_write_transaction;
    @(posedge vif.PCLK)
    (vif.PSEL && vif.PENABLE && vif.PWRITE) |-> vif.PWRITE;
  endproperty

  a_write_transaction:
    assert property (p_write_transaction)
    else $error("APB ASSERTION FAILED: Invalid WRITE transaction");






  //4. PSLVERR is valid only when transfer complete
  property P_pslverr_only_in_completion;
    @(posedge vif.PCLK)
    vif.PSLVERR |-> (vif.PSEL && vif.PENABLE && vif.PREADY);
  endproperty

  a_pslverr_only_in_completion:
    assert property (P_pslverr_only_in_completion)
    else $error("APB ASSERTION FAILED: PSLVERR asserted before transfer completion");

  //5.PADDR must be stable during wait
  property p_address_stable_during_wait;
    @(posedge vif.PCLK)
    disable iff (!vif.PRESETn)
    (vif.PSEL && vif.PENABLE && !vif.PREADY) |=> $stable(vif.PADDR);
  endproperty

  a_address_stable_during_wait:
    assert property (p_address_stable_during_wait)
    else $error("APB ASSERTION FAILED: PADDR changed during wait state");

  //6. Write Data must not change during active write

  property p_write_data_stable;
    @(posedge vif.PCLK)
    disable iff (!vif.PRESETn)
    (vif.PSEL && vif.PENABLE && vif.PWRITE && !vif.PREADY) |=> $stable(vif.PWDATA);
  endproperty

  a_write_data_stable:
    assert property (p_write_data_stable)
    else $error("APB ASSERTION FAILED: PWDATA changed during active write");

  //6. A transfer must eventually complete
  property p_transfer_eventually_completes;
    @(posedge vif.PCLK)
    disable iff (!vif.PRESETn)
    (vif.PSEL && vif.PENABLE) |-> ##[1:100] vif.PREADY;
  endproperty

  a_transfer_eventually_completes:
    assert property (p_transfer_eventually_completes)
    else $error("APB ASSERTION FAILED: Transfer did not complete within 100 cycles");

  

  // 7. No PREADY during Setup phase
  property p_no_pready_during_setup;
    @(posedge vif.PCLK)
    disable iff (!vif.PRESETn)
    (vif.PSEL && !vif.PENABLE) |-> !vif.PREADY;
  endproperty

  a_no_pready_during_setup:
    assert property (p_no_pready_during_setup)
    else $error("APB ASSERTION FAILED: PREADY asserted during Setup phase");

endmodule























  
