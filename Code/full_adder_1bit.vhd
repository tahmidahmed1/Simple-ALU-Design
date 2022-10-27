-- ECE 124, LAB Session #206, Team Number #9, Tahmid Ahmed & Vidhi Patel
library ieee;
use ieee.std_logic_1164.all;

entity full_adder_1bit is 
port(

	INPUT_A, INPUT_B	: in std_logic; -- 1-bit inputs
	CARRY_IN				: in std_logic; -- carry-out from lower adder
	SUM_OUTPUT, CARRY_OUTPUT: out std_logic -- output for the full adder (SUM_OUTPUT & CARRY_OUTPUT)
	
);

end full_adder_1bit;

architecture full_adder_1bit_logic of full_adder_1bit is
-- defineing logic below to do operations:

	signal HALF_ADDER_CARRY_OUTPUT		: std_logic;
	signal HALF_ADDER_SUM_OUTPUT			: std_logic;
	
	
begin

HALF_ADDER_CARRY_OUTPUT <= (INPUT_A AND INPUT_B); -- this stores the HALF_ADDER_CARRY_OUTPUT which is the AND of INPUT_A & INPUT_B.
HALF_ADDER_SUM_OUTPUT <= (INPUT_A XOR INPUT_B); -- this stores the HALF_ADDER_SUM_OUTPUT which is the XOR of INPUT_A & INPUT_B.
CARRY_OUTPUT <= ((CARRY_IN AND HALF_ADDER_SUM_OUTPUT) OR HALF_ADDER_CARRY_OUTPUT); -- the CARRY_OUTPUT for full adder is the AND of CARRY_IN & HALF_ADDER_SUM_OUTPUT then doing OR of the result with HALF_ADDER_CARRY_OUTPUT.
SUM_OUTPUT <= (CARRY_IN XOR HALF_ADDER_SUM_OUTPUT); -- the SUM_OUTPUT for full adder is the XOR of CARRY_IN & HALF_ADDER_SUM_OUTPUT.

end full_adder_1bit_logic;
