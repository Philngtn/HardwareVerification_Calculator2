import dataModel::*;
`include "cal_ifc.sv"


class Monitor;
  
  // Data memeber in charge of holding monitored transaction
  Check_transactions calculatorResult;
  
  // Interface
  virtual cal_ifc ifc;
  
  // Mailbox to checker
  mailbox #(Check_transactions) mon2ckc;
  
  // Constructor
  function new (input mailbox#(Check_transactions) mon2ckc, virtual cal_ifc ifc);
    this.ifc = ifc;
    this.mon2ckc = mon2ckc;
  endfunction
  
  task main();
    
    //Get data
    Check_transactions DUT_result1;
    Check_transactions DUT_result2;
    Check_transactions DUT_result3;
    Check_transactions DUT_result4;
    
    $display("STARTING MONITOR");
    
    forever 
      begin
        
        //$display("Send Results to CHECKER");
    
          if (ifc.out_tag1 != 0) begin
            DUT_result1.data = ifc.out_data1;     // Result
            DUT_result1.resp = ifc.out_resp1;     // Response
            DUT_result1.tag  = ifc.out_tag1;      // Tags
            
            $display(ifc.out_tag1);
            
            mon2ckc.put(DUT_result1);
            
          end
          
          if (ifc.out_tag2 != 0) begin
            DUT_result2.data = ifc.out_data2;
            DUT_result2.resp = ifc.out_resp2; 
            DUT_result2.tag  = ifc.out_tag2;
            mon2ckc.put(DUT_result2);
           
          end
          
          if (ifc.out_tag3 != 0) begin
            DUT_result3.data = ifc.out_data3;
            DUT_result3.resp = ifc.out_resp3; 
            DUT_result3.tag  = ifc.out_tag3;
            mon2ckc.put(DUT_result3);
          end
          
          if (ifc.out_tag4 != 0) begin
            DUT_result4.data = ifc.out_data4;
            DUT_result4.resp = ifc.out_resp4; 
            DUT_result4.tag  = ifc.out_tag4;
            mon2ckc.put(DUT_result4);
          end

      end //End loop
    endtask
  
endclass