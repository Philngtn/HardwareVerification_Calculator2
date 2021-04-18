import dataModel::*;

class Agent;
  
  mailbox #(Transaction_ports) gen2agt, agt2drv;
  Transaction_ports trPorts;
  
  function new (input mailbox #(Transaction_ports) gen2agt, agt2drv);
    this.gen2agt = gen2agt;
    this.agt2drv = agt2drv;
  endfunction
  
  task main();
      
    forever begin
      gen2agt.get(trPorts);
      
      $display("AGENT RECEIVED");
      trPorts.display();
    
      agt2drv.put(trPorts);
 
    end
    
  endtask

endclass
