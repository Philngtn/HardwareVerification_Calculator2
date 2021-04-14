
module top;
  parameter simulation_cycle = 100;
  
  bit clk;
  always #(simulation_cycle/2) 
    clk = ~clk;

  cal_ifc     ifc (clk);        // Cal2 interafce
  testDrive   t1  (ifc.TEST);   // Testbench program
  
  calc2_top   cal2(.req1_cmd_in(ifc.req1_cmd_in), .req2_cmd_in(ifc.req2_cmd_in),       // Command links
                   .req3_cmd_in(ifc.req3_cmd_in), .req4_cmd_in(ifc.req4_cmd_in),
                   
                   .req1_data_in(ifc.req1_data_in), .req2_data_in(ifc.req2_data_in),   // Data input links
                   .req3_data_in(ifc.req3_data_in), .req4_data_in(ifc.req4_data_in),
                   
                   .req1_tag_in(ifc.req1_tag_in), .req2_tag_in(ifc.req2_tag_in),
                   .req3_tag_in(ifc.req3_tag_in), .req4_tag_in(ifc.req4_tag_in),
                       
                   .reset(ifc.reset), .c_clk(ifc.clk),
                      
                   .out_resp1(ifc.out_resp1), .out_resp2(ifc.out_resp2),              // Response links
                   .out_resp3(ifc.out_resp3), .out_resp4(ifc.out_resp4),    
                                    
                   .out_data1(ifc.out_data1), .out_data2(ifc.out_data2),              // Output of cal
                   .out_data3(ifc.out_data3), .out_data4(ifc.out_data4),
                   
                   .out_tag1(ifc.out_tag1), .out_tag2(ifc.out_tag2),
                   .out_tag3(ifc.out_tag3), .out_tag4(ifc.out_tag4));           // Memory device

endmodule  
