import dataModel::*;

class Scoreboard;
  
  parameter DATA_WIDTH = 32;
  
  // Transaction commming in 
  mailbox #(Transaction_ports) agt2scr;
  mailbox #(Transaction_ports) scr2ckc;
  
  // Constructor
  function new (mailbox #(Transaction_ports) agt2scr, scr2ckc);

    this.agt2scr = agt2scr;
    this.scr2ckc = scr2ckc;
    
  endfunction
  
  task main();
    
    Transaction_ports processed_drv_tr;
    $display("STARTING SCOREBOARD");
    
    forever 
      begin
        
        // Get package from the agt
        agt2scr.get(processed_drv_tr);
        
        $display("SCOREBOARD RECEIVED");
        processed_drv_tr.display();
        
        
        
        // Calcualte the expected value;
        foreach (processed_drv_tr.transactionPorts[i]) begin
          foreach (processed_drv_tr.transactionPorts[i].transactionArray[j]) begin
            case(processed_drv_tr.transactionPorts[i].transactionArray[j].cmd)
              1:
                begin
                  // Calculate the adding expected result
                  processed_drv_tr.transactionPorts[i].transactionArray[j].expectedValue = 
                  
                  adding_command(processed_drv_tr.transactionPorts[i].transactionArray[j].data[0],
                                 processed_drv_tr.transactionPorts[i].transactionArray[j].data[1]);
                                 
                  processed_drv_tr.transactionPorts[i].transactionArray[j].expectedResp = 
                  
                  overflow_response_check( processed_drv_tr.transactionPorts[i].transactionArray[j].data[0],
                                           processed_drv_tr.transactionPorts[i].transactionArray[j].data[1]);               
                  
                end
              2:
                begin
                  // Calculate the adding subtracting result
                  processed_drv_tr.transactionPorts[i].transactionArray[j].expectedValue = 
                  
                  subtracting_command(processed_drv_tr.transactionPorts[i].transactionArray[j].data[0],
                                      processed_drv_tr.transactionPorts[i].transactionArray[j].data[1]);
                  
                  processed_drv_tr.transactionPorts[i].transactionArray[j].expectedResp = 
                                      
                  underflow_response_check( processed_drv_tr.transactionPorts[i].transactionArray[j].data[0],
                                            processed_drv_tr.transactionPorts[i].transactionArray[j].data[1]);                    
                                      
                end
              5:
                begin
                  // Calculate the adding shiftleft result
                  processed_drv_tr.transactionPorts[i].transactionArray[j].expectedValue = 
                  
                  shiftLeft_command(processed_drv_tr.transactionPorts[i].transactionArray[j].data[0],
                                    processed_drv_tr.transactionPorts[i].transactionArray[j].data[1]);
                                    
                end
              6:
                begin
                  // Calculate the adding shiftwrite result
                  processed_drv_tr.transactionPorts[i].transactionArray[j].expectedValue = 
                  
                  shiftRight_command(processed_drv_tr.transactionPorts[i].transactionArray[j].data[0],
                                     processed_drv_tr.transactionPorts[i].transactionArray[j].data[1]);
                end
          
             default:
                begin
                   processed_drv_tr.transactionPorts[i].transactionArray[j].expectedResp = 2'b10;
                  
                   $display("@%0d: Fatal error: Scoreboard received illegal master transaction at the package '%0d'", 
                       $time, processed_drv_tr.package_cnt);
                  end
            endcase 
          end
        end
        
        
        // Send the package to checker
        scr2ckc.put(processed_drv_tr);
      
      end
   endtask  
   
   
   function  bit [0:31] adding_command (input bit [0:31] data_1, data_2);
        return data_1 + data_2;
   endfunction
   
   function  bit [0:31] subtracting_command (input bit [0:31] data_1, data_2);
        return data_1 - data_2;
   endfunction
   
   function  bit [0:31] shiftLeft_command (input bit [0:31] data_1, data_2);
        return data_1 << data_2;
   endfunction
   
   function  bit [0:31] shiftRight_command (input bit [0:31] data_1, data_2);
        return data_1 >> data_2;
   endfunction
   
   function bit [0:1] overflow_response_check (input bit [0:31] data_1, data_2);
        
        if (data_1 > 2147483647 && data_2 > 2147483647) begin
          return 2;
        end
        
        return 1;
        
   endfunction
    
   function bit [0:1] underflow_response_check (input bit [0:31] data_1, data_2);
        
        if (data_1 < data_2) begin
          return 2;
        end
        
        return 1;
        
   endfunction
    
  
endclass
