import dataModel::*;
`include "SV_RAND_CHECK.sv"


class Generator;
  
  Transaction_ports TrPorts;
  mailbox #(Transaction_ports) mbx;
  
  function new(input mailbox #(Transaction_ports) mbx);
    this.mbx = mbx;
  endfunction
  
  task run(input int count);
    repeat (count) begin
      TrPorts = new();
      `SV_RAND_CHECK(TrPorts.randomize);
      mbx.put(TrPorts); // Send out transaction
    end
  endtask


endclass
      
