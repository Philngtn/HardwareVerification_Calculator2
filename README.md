## Hardware Verification with Randomization.

# Objective: Build a verification environment as shown in the figure below. The environment should be class-based with randomization and functional coverage

![Verification](https://user-images.githubusercontent.com/60360984/121116633-d7af6880-c7e4-11eb-9444-ce4b0d225a67.png)

# Design Inputs/Outputs of the Calculator:
c_clk: c_clk is the main clock.
reset: Needs to be held high for three cycles at the start of the testcase. Must remain low during
functional testing. Similarly, all input ports need to be driven low (‘0’b, not “X” or “U”) from the start of simulation.
reqX_cmd_in(0:3): Same definitions as first design. Add (‘0001’b), Subtract (‘0010’b), Shift left (‘0101’b), and Shift right (‘0110’b).
reqX_data_in(0:31): Same definition as first design. The operand data is sent one cycle after another. Operand1 data accompanies command, and operand2 data follows.
reqX_tag_in(0:1): Two bit identifier for each command from the port. Can be reused as soon as the calculator responds to the command.
out_respX(0:1): Same definition as first design. Good response (‘01’b), invalid command or overflow/underflow (‘10’b), and internal error (‘11’b; never happens). ‘00’b on the response line indicates there’s no response from that port on that cycle.
out_dataX(0:31): Same definition as first design. This is the data that accompanies a good response.
out_tagX(0:1): Corresponds to the command tag sent by the requester. Used to identify which command the response if for.

![image](https://user-images.githubusercontent.com/60360984/121116900-442a6780-c7e5-11eb-9624-72ce687cfef7.png)

# Result:

Command testing cases:
![image](https://user-images.githubusercontent.com/60360984/121117016-776cf680-c7e5-11eb-8ce2-5b47bbb8a8da.png)

Functional Coverage:
![image](https://user-images.githubusercontent.com/60360984/121117051-85bb1280-c7e5-11eb-9219-c57f7e166614.png)
