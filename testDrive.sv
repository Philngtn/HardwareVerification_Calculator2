`include "driver.sv"
`include "generator.sv"
import dataModel::*;


program automatic testDrive(cal_ifc.TEST ifc);
  
  mailbox #(Transaction_ports) mbx;
  Generator gen;
  Driver drv;

  
  int Max_Gen_Package = 1;
  
  initial begin
 //   mbx = new();
  //  gen = new(mbx, Max_Gen_Package);
  //  drv = new(mbx, ifc);
    
  //  count = 1
  //fork
 //     gen.run(count);
 //     drv.run();
 //   join
    
    
  //  $stop;
  end
  

  
  
endprogram