`include "driver.sv"
`include "generator.sv"
`include "agent.sv"
`include "scoreboard.sv"
`include "monitor.sv"
`include "checker.sv"

import dataModel::*;


program automatic testDrive(cal_ifc.TEST ifc);
  
  mailbox #(Transaction_ports) gen2agt,agt2drv,scr2ckc,mon2ckc;
  Generator gen;
  Agent agt;
  Driver drv;
  Scoreboard scr;
  Monitor mon;
  Checker ckc;
  
  int Max_Gen_Package = 1;
  
  initial begin
    
    gen2agt = new();
    agt2drv = new();
    scr2ckc = new();
    mon2ckc = new();
    
    gen = new(gen2agt, Max_Gen_Package);
    agt = new(gen2agt, agt2drv);
    drv = new(agt2drv, ifc);
    mon = new(mon2ckc, ifc);
    scr = new(agt2drv, scr2ckc);
    ckc = new(Max_Gen_Package, scr2ckc, mon2ckc);
  
  
  
    fork 
      gen.main();
      agt.main();
      
      drv.main();
      mon.main();
    
      ckc.main();
      scr.main();
    join
    
    
    
    $stop;
  end

  
  
endprogram