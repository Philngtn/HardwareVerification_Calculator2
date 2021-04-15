class Scoreboard;
  
  parameter COMMAND_WIDTH = 4;
  parameter TAG_WIDTH = 2;
  parameter DATA_WIDTH = 32;
  parameter RESPONSE_WIDTH = 2;
  
  // Inputs
  rand bit [0: COMMAND_WIDTH - 1] 	cmd;
  rand bit [0: DATA_WIDTH - 1 ]    dataActual [2], dataExpect[2];
  bit      [0: TAG_WIDTH - 1] 	    tagIn, tagOut;
  
endclass
