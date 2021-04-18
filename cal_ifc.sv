
/**********************************************************************
 * Definition of an custom calculator
 *
 * Author: Phuc nguyen
 * Revision: 1.0
 * Last modified: Apr-11-2021
 *
 *********************************************************************/

interface cal_ifc(input bit clk);
  
  // Reset
  bit reset;
  
  // Inputs
  logic [0:3] 	 req1_cmd_in, req2_cmd_in, req3_cmd_in, req4_cmd_in;
  logic [0:1] 	 req1_tag_in, req2_tag_in, req3_tag_in, req4_tag_in;
  logic [0:31]  req1_data_in, req2_data_in, req3_data_in, req4_data_in; 
  
  // Outputs
  logic [0:31] out_data1, out_data2, out_data3, out_data4;
  logic [0:1]  out_resp1, out_resp2, out_resp3, out_resp4, out_tag1, out_tag2, out_tag3, out_tag4;
  
  clocking cb @(posedge clk);
    // default input #1skew output #0;
    input out_data1, out_data2, out_data3, out_data4;
    input out_resp1, out_resp2, out_resp3, out_resp4, out_tag1, out_tag2, out_tag3, out_tag4;
    
    output reset;
    output req1_cmd_in, req2_cmd_in, req3_cmd_in, req4_cmd_in;
    output req1_tag_in, req2_tag_in, req3_tag_in, req4_tag_in;
    output req1_data_in, req2_data_in, req3_data_in, req4_data_in; 
  endclocking
 
  clocking monitor_cb @(posedge clk);
    // default input #1skew output #0;
    input out_data1, out_data2, out_data3, out_data4;
    input out_resp1, out_resp2, out_resp3, out_resp4;
    input out_tag1, out_tag2, out_tag3, out_tag4;
  endclocking
 
  // Interface for Test
  modport TEST (clocking cb);
  
  // Interface for DUT 
  modport DUT (input req1_cmd_in, req2_cmd_in, req3_cmd_in, req4_cmd_in,
               input req1_data_in, req2_data_in, req3_data_in, req4_data_in,
               input req1_tag_in, req2_tag_in, req3_tag_in, req4_tag_in,
               input reset,
               output out_resp1, out_resp2, out_resp3, out_resp4,out_data1, out_data2, out_data3, out_data4, out_tag1, out_tag2, out_tag3, out_tag4);
  
  modport MONITOR (clocking monitor_cb);
  
endinterface: cal_ifc
