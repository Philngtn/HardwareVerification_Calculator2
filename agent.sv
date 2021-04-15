import dataModel::*;

class Agent;
  
  mailbox #(Transaction_ports) gen2agt, agt2drv, agt2scr;
  Transaction_ports trPorts;
  
  function new (input mailbox #(Transaction_ports) gen2agt, agt2drv, agt2scr);
    this.gen2agt = gen2agt;
    this.agt2drv = agt2drv;
    this.agt2scr = agt2scr;
  endfunction
  
  task run();
    
    forever begin
      gen2agt.get(trPorts);
      agt2scr.put(trPorts);
      agt2drv.put(trPorts);
    end
    
  endtask
  
  task wrap_up();
  endtask


endclass
