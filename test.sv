import dataModel::*;
`include "SV_RAND_CHECK.sv"

program automatic test;


Transaction_seq TrSeq;
Transaction_ports TrPorts;
Transaction_ports TrPortsCopy;

initial begin
  
  
    
    //TrSeq = new();
    
    //`SV_RAND_CHECK(TrSeq.randomize());
    
    //foreach (TrSeq.transactionArray[i]) begin
    //  $display(i);
    //  TrSeq.transactionArray[i].display();
    //end 
    //$display("------------------------------------PACKAGE: %0d----------------------------------------",i);
    TrPorts = new();
    `SV_RAND_CHECK(TrPorts.randomize());
     
     // foreach (TrPorts.transactionPorts[i]) begin
     //   foreach (TrPorts.transactionPorts[i].transactionArray[j]) begin
     //       $display(i);
     //      TrPorts.transactionPorts[i].transactionArray[j].display()       
     //   end
     // $display("**********************************************");
     // end
    $display("------------------------------------PACKAGE: 1----------------------------------------");
    TrPorts.display();
   
    TrPortsCopy = TrPorts.copy();
    $display("------------------------------------COPIED----------------------------------------");
  
    $display("------------------------------------PACKAGE: 2----------------------------------------");
    TrPortsCopy.display();
    
    $stop;
  
end 

endprogram