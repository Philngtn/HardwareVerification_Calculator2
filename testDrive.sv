`include "driver.sv"
`include "generator.sv"
import dataModel::*;


program automatic testDrive(cal_ifc.TEST ifc);
  
  mailbox #(Transaction_ports) mbx;
  Generator gen;
  Driver drv;

  
  int count;
  
  initial begin
    mbx = new();
    gen = new(mbx);
    drv = new(mbx, ifc);
    
    count = 1;
        
    
    fork
      gen.run(count);
      drv.run(count);
    join
    
    
      //$stop;
  end
  

  
  
endprogram