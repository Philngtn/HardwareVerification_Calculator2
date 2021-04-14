import dataModel::*;

`include "cal_ifc.sv"

class Driver;
  
  
  vCAL ifc;
  mailbox #(Transaction_ports) cal_agt2drv; // Mbx between Generator and Driver
  
  function new (input mailbox#(Transaction_ports) cal_agt2drv, vCAL ifc);
    this.ifc = ifc;
    this.cal_agt2drv = cal_agt2drv;
  endfunction
  
  task run(input int count);
    // Init data
    
    Transaction_ports tr_ports_received;
    reset(ifc);
    $display($time, ": Starting driver");
    
    
    repeat (count) begin
      // Get the transaction 
      cal_agt2drv.get(tr_ports_received); 
      
   
      
      tr_ports_received.display();
      
     
      
      // Send data to DUT
      fork
        send2DUT_port1(tr_ports_received.transactionPorts[0],ifc);
        send2DUT_port2(tr_ports_received.transactionPorts[1],ifc);
        send2DUT_port3(tr_ports_received.transactionPorts[2],ifc);
        send2DUT_port4(tr_ports_received.transactionPorts[3],ifc);
        
        //send2DUT_allports(tr_ports_received.transactionPorts[0],tr_ports_received.transactionPorts[1],
        //                  tr_ports_received.transactionPorts[2],tr_ports_received.transactionPorts[3],
        //                  ifc);
        
      join
      
    end
   

  endtask: run
  
 
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
  
 
   task send2DUT_allports (Transaction_seq port1, port2, port3, port4, vCAL ifc);
    for(int i = 0; i<4; i++)begin
      ifc.cb.req1_cmd_in  <= port1.transactionArray[i].cmd;
      ifc.cb.req1_data_in <= port1.transactionArray[i].data[0];
      ifc.cb.req1_tag_in  <= port1.transactionArray[i].tagIn; 
      
      ifc.cb.req2_cmd_in  <= port2.transactionArray[i].cmd;
      ifc.cb.req2_data_in <= port2.transactionArray[i].data[0];
      ifc.cb.req2_tag_in  <= port2.transactionArray[i].tagIn;  
      
      
      ifc.cb.req3_cmd_in  <= port3.transactionArray[i].cmd;
      ifc.cb.req3_data_in <= port3.transactionArray[i].data[0];
      ifc.cb.req3_tag_in  <= port3.transactionArray[i].tagIn;  
      
      ifc.cb.req4_cmd_in  <= port4.transactionArray[i].cmd;
      ifc.cb.req4_data_in <= port4.transactionArray[i].data[0];
      ifc.cb.req4_tag_in  <= port4.transactionArray[i].tagIn;  

           
      repeat (1) @ifc.cb;
      ifc.cb.req1_data_in <= port1.transactionArray[i].data[1];
      ifc.cb.req2_data_in <= port2.transactionArray[i].data[1];
      ifc.cb.req3_data_in <= port3.transactionArray[i].data[1];
      ifc.cb.req4_data_in <= port4.transactionArray[i].data[1];
      
      repeat (2) @ifc.cb;
    end
  
  endtask
 
  
endclass
      
      