import dataModel::*;

class Checker;
  
  parameter DATA_WIDTH = 32;
  
   // Max # of transactions
  int max_package_cnt;
  event ended;
  
  // Number of good matches
  int match;
  
  // Transaction commming in 
  mailbox #(Transaction_ports) scr2ckc;
  mailbox #(Check_transactions) mor2ckc;
  
  
  // Constructor
  function new (int max_package_cnt, mailbox #(Transaction_ports) scr2ckc, mailbox #(Check_transactions) mor2ckc);
    this.max_package_cnt = max_package_cnt;
    this.mor2ckc = mor2ckc;
    this.scr2ckc = scr2ckc;
  endfunction
  
  task main(); 
  
    
    // Blueprint package with expected results
    Transaction_ports expectedResultAdded_package;
    
    // Actual results from mornitor
    Check_transactions calculatedResult;
    Check_transactions expectedResult;
    
    $display("STARTING CHECKER");
    

      forever 
        begin    
      
          // Get the package from the scoreboard 
          scr2ckc.get(expectedResultAdded_package);
          
          // Get the packge from the monitor
          mor2ckc.get(calculatedResult);
          
          // Extracted 
          
          expectedResultAdded_package.display();
          calculatedResult.display();
          
        end
    
  endtask
  
endclass
      
      
      
      
      
      
      
      
      
      
      
    