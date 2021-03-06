package dataModel;

class Transaction;
  
  parameter COMMAND_WIDTH = 4;
  parameter TAG_WIDTH = 2;
  parameter DATA_WIDTH = 32;
 
  parameter RESPONSE_WIDTH = 2;
 
  
  static int count; // Number of instance created
  int id;           // Unique transaction id
  
  function new();
    id = count++;
  endfunction
  
  // Random Inputs
  rand bit [0: COMMAND_WIDTH - 1] 	cmd;
  rand bit [0: DATA_WIDTH - 1 ]    data [2];
  
  // Tag
  bit      [0: TAG_WIDTH - 1] 	    tagIn;
  
  // Expected Reponses
  bit      [0: DATA_WIDTH - 1 ]    expectedValue;
  bit      [0: RESPONSE_WIDTH - 1] expectedResp;
  
  // Set command
  bit [0:3] vals [] = '{1,2,5,6};
  
  constraint cmd_range {
    cmd inside {vals};
  }
  
  constraint shiftedLimit {
    (cmd == 6) ->  (data[1] < 36);
    (cmd == 5) ->  (data[1] < 36);
  }
  
  function void display();
      // LAB: Display the time, command, data, and tag
      $display("Time: %0t, Command = 4'b%4b, DataIn1 = 32'h%0h, DataIn2= 32'h%0h, TagIn=2'b%0b", $time, cmd, data[0], data[1], tagIn);
  endfunction: display
  
  function Transaction copy();
    copy = new();
    copy.cmd = cmd;
    copy.data = data;
    copy.tagIn = tagIn;
  endfunction: copy
    
endclass  
//-------------------------------------------------------------------------------------------------------------------------
// Create a sequence of transaction (Simulate the random number of transactions per port) 
class Transaction_seq;
  
  rand Transaction transactionArray [];
  int maxTransaction = 4;
  
  constraint transactionArrayRandLength {transactionArray.size() inside {[2:maxTransaction]}; }
  
  function new();
    transactionArray = new[maxTransaction];
    foreach (transactionArray[i]) begin
      transactionArray[i] = new();
      
      // Add tag to each transaction
      transactionArray[i].tagIn = i + 1;
    end;
  endfunction
  
endclass: Transaction_seq

//-------------------------------------------------------------------------------------------------------------------------
// Create a package of data for 4 ports at a same time 
class Transaction_ports;
  
  rand Transaction_seq transactionPorts [4];
  int package_cnt;
  
  
  function new();
    foreach (transactionPorts[i]) begin
      transactionPorts[i] = new();
    end
  endfunction
  
  function void display();
   foreach (transactionPorts[i]) begin
        $display("********************* PACKAGE: %0d *************************",i + 1);
        foreach (transactionPorts[i].transactionArray[j]) begin
            transactionPorts[i].transactionArray[j].display();     
        end;
        $display("---------------------------------------------");
     end;
  endfunction: display
  
  function Transaction_ports copy();
    copy = new();
    foreach(copy.transactionPorts[i]) begin
      foreach (copy.transactionPorts[i].transactionArray[j]) begin
        copy.transactionPorts[i].transactionArray[j].cmd   = transactionPorts[i].transactionArray[j].cmd;
        copy.transactionPorts[i].transactionArray[j].data  = transactionPorts[i].transactionArray[j].data;
        copy.transactionPorts[i].transactionArray[j].tagIn = transactionPorts[i].transactionArray[j].tagIn;
        //$display("COPIED", copy.transactionPorts[i].transactionArray[j].cmd);
      end
    end
    
  endfunction: copy
  
endclass: Transaction_ports


class Check_transactions;
  
  parameter TAG_WIDTH = 2;
  parameter DATA_WIDTH = 32;
  parameter RESP_WIDTH = 2;
  
  bit [0: DATA_WIDTH - 1]   data;
  bit [0: RESP_WIDTH - 1]   resp;
  bit [0: TAG_WIDTH - 1] 	   tag;
  
  function void display();
     begin
        $display("Time: %0t, Result = 32'h%h, Response = 2'b%0b, TagOut= 2'b%0b", $time, data, resp, tag);
     end;
  endfunction: display
  
  
endclass: Check_transactions

endpackage

