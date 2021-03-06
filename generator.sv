import dataModel::*;
`include "SV_RAND_CHECK.sv"


class Generator;
  
  // Generate random package of transactions for 4 ports    
  Transaction_ports TrPorts;
  
  // Test terminates when the packages is greater than max_pakage_cnt memeber
  int max_package_cnt;
  
  // Event notifing that all transactions were sent
  event ended;
  
  // Counts the number of performed packages
  int package_cnt = 0;
  
  // Mailbox to transmists to Agent
  mailbox #(Transaction_ports) mbx;
  
  // Constructor
  function new(input mailbox #(Transaction_ports) mbx, int max_package_cnt);
    this.mbx = mbx;
    this.max_package_cnt = max_package_cnt;
  endfunction
  
 //  task run(input int count);
 //   repeat (count) begin
 //     TrPorts = new();
 //     `SV_RAND_CHECK(TrPorts.randomize);
 //     mbx.put(TrPorts); // Send out transaction
 //   end
 //  endtask
  
 task main();
       $display($time, ": Starting generator for %0d package of transactions", max_package_cnt);
       
       // Start this generator 
       
       while (!end_of_test())
          begin
            TrPorts = new();
            
            // Wait & Get a transaction
            // TrPorts = get_transaction();
            `SV_RAND_CHECK(this.TrPorts.randomize());
      
            TrPorts.package_cnt = package_cnt;
            
            // Increase the number of sent packages
            ++package_cnt;
            
            // Sebt the data to the agent
            mbx.put(TrPorts);
          end // While end of test 
       
    
       // Notify the package is sent
       -> ended;
           
  endtask
  
  
  
  // Returns TRUE when the test should stop
  virtual function bit end_of_test();
    end_of_test = (package_cnt >= max_package_cnt);
  endfunction
    
  // Returns a transaction (associated with tr member)
  virtual function Transaction_ports get_transaction();
    
    // Mark the sent package for checker
    TrPorts.package_cnt = package_cnt;
    
    if (!this.TrPorts.randomize())
      begin
        $display("apb_gen::randomize failed");
        $finish;
      end
    return TrPorts.copy();
 
  endfunction

endclass
      
