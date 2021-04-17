import dataModel::*;

`include "cal_ifc.sv"

class Driver;
  
  // Declare interface
  vCAL ifc;
  
  // Mbx between Generator and Driver
  mailbox #(Transaction_ports) cal_agt2drv; 
  
  // Constructor
  function new (input mailbox#(Transaction_ports) cal_agt2drv, vCAL ifc);
    this.ifc = ifc;
    this.cal_agt2drv = cal_agt2drv;
  endfunction
  
  task run();
    
    // Init data blue print
    Transaction_ports tr_ports_received;
    
    // Reset at the beginning 
    reset(ifc);
    
    
    $display($time, ": Starting driver");
    
    
     forever begin
       
      // Get the transaction 
      cal_agt2drv.get(tr_ports_received); 
      
      // Print the received stacked data 
      tr_ports_received.display();
      
      // Send data to DUT simutaneously
      fork
        send2DUT_port1(tr_ports_received.transactionPorts[0],ifc);
        send2DUT_port2(tr_ports_received.transactionPorts[1],ifc);
        send2DUT_port3(tr_ports_received.transactionPorts[2],ifc);
        send2DUT_port4(tr_ports_received.transactionPorts[3],ifc);
      join
      
    end
   

  endtask: run
  
  // Number of clock wait after send all the data to ports
  task waitClock;
     repeat (7) @ifc.cb;
  endtask
  
  task send2DUT_port1 (Transaction_seq Tr_seq, vCAL ifc);
    foreach(Tr_seq.transactionArray[i]) begin
      ifc.cb.req1_cmd_in  <= Tr_seq.transactionArray[i].cmd;
      ifc.cb.req1_data_in <= Tr_seq.transactionArray[i].data[0];
      ifc.cb.req1_tag_in  <= Tr_seq.transactionArray[i].tagIn;      
      repeat (1) @ifc.cb;
      ifc.cb.req1_cmd_in  <= 0;
      ifc.cb.req1_tag_in  <= 0;  
      ifc.cb.req1_data_in <= Tr_seq.transactionArray[i].data[1];
      waitClock();
    end
  endtask: send2DUT_port1
  
   task send2DUT_port2 (Transaction_seq Tr_seq , vCAL ifc);
    foreach(Tr_seq.transactionArray[i]) begin
      ifc.cb.req2_cmd_in  <= Tr_seq.transactionArray[i].cmd;
      ifc.cb.req2_data_in <= Tr_seq.transactionArray[i].data[0];
      ifc.cb.req2_tag_in  <= Tr_seq.transactionArray[i].tagIn;      
      repeat (1)@ifc.cb;
      ifc.cb.req2_cmd_in  <= 0;
      ifc.cb.req2_tag_in  <= 0; 
      ifc.cb.req2_data_in <= Tr_seq.transactionArray[i].data[1];
      waitClock();
    end
  endtask: send2DUT_port2
  
   task send2DUT_port3 (Transaction_seq Tr_seq, vCAL ifc);
    foreach(Tr_seq.transactionArray[i]) begin
      ifc.cb.req3_cmd_in  <= Tr_seq.transactionArray[i].cmd;
      ifc.cb.req3_data_in <= Tr_seq.transactionArray[i].data[0];
      ifc.cb.req3_tag_in  <= Tr_seq.transactionArray[i].tagIn;      
      repeat (1) @ifc.cb;
      ifc.cb.req3_cmd_in  <= 0;
      ifc.cb.req3_tag_in  <= 0; 
      ifc.cb.req3_data_in <= Tr_seq.transactionArray[i].data[1];
      waitClock();
    end
  endtask: send2DUT_port3
  
   task send2DUT_port4 (Transaction_seq Tr_seq, vCAL ifc);
    foreach(Tr_seq.transactionArray[i]) begin
      ifc.cb.req4_cmd_in  <= Tr_seq.transactionArray[i].cmd;
      ifc.cb.req4_data_in <= Tr_seq.transactionArray[i].data[0];
      ifc.cb.req4_tag_in  <= Tr_seq.transactionArray[i].tagIn;      
      repeat (1) @ifc.cb;
      ifc.cb.req4_cmd_in  <= 0;
      ifc.cb.req4_tag_in  <= 0; 
      ifc.cb.req4_data_in <= Tr_seq.transactionArray[i].data[1];
      waitClock();
    end
  endtask: send2DUT_port4
  
  
  task reset(vCAL ifc);
    ifc.reset <= 1'b0;
    idle(ifc);
    ifc.reset <= 1'b1;
    repeat (3) @ifc.cb;
    ifc.reset <= 1'b0;
  endtask: reset
  
  task idle(vCAL ifc);
    ifc.cb.req1_cmd_in <= 0;
    ifc.cb.req2_cmd_in <= 0;
    ifc.cb.req3_cmd_in <= 0;
    ifc.cb.req4_cmd_in <= 0;
    
    ifc.cb.req1_data_in <= 0; 
    ifc.cb.req2_data_in <= 0;
    ifc.cb.req3_data_in <= 0;
    ifc.cb.req4_data_in <= 0;
    
    ifc.cb.req1_tag_in <=0;
    ifc.cb.req2_tag_in <=0;
    ifc.cb.req3_tag_in <=0;
    ifc.cb.req4_tag_in <=0;
  endtask: idle
  
endclass
      
      