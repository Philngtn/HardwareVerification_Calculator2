import dataModel::*;

class Scoreboard;
  
  parameter DATA_WIDTH = 32;
  
  // Transaction commming in 
  mailbox #(Transaction_ports) agt2scr, scr2ckc;
  
  // Constructor
  function new (int max_package_cnt, mailbox #(Transaction_ports) agt2scr, scr2ckc);

    this.agt2scr = agt2scr;
    this.scr2ckc = scr2ckc;
  endfunction
  
  task main();
    
    Transaction_ports processed_drv_tr;
    $display($time, ": Starting scoreboard for %0d packages", max_package_cnt);
    
    forever 
      begin
        
        // Get package from the agt
        agt2scr.get(processed_drv_tr);
        
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
                end
              2:
                begin
                  // Calculate the adding subtracting result
                  processed_drv_tr.transactionPorts[i].transactionArray[j].expectedValue = 
                  
                  subtracting_command(processed_drv_tr.transactionPorts[i].transactionArray[j].data[0],
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
                   $display("@%0d: Fatal error: Scoreboard received illegal master transaction at the package '%0d'", 
                       $time, processed_drv_tr.package_cnt);
                  end
            endcase 
          end
        end
        
        
        // Send to checker
        src2ckc.put(processed_drv_tr);
      
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
  
endclass
