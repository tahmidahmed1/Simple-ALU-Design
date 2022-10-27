-- ECE 124, LAB Session #206, Team Number #9, Tahmid Ahmed & Vidhi Patel
library ieee;
use ieee.std_logic_1164.all;


-- Adder generates two outputs based on input logic levels

entity full_adder_4bit is
port(

	BUS0_b	: in std_logic_vector(3 downto 0); -- 1-bit input
	BUS1_b 	: in std_logic_vector(3 downto 0); -- 1-bit input
	CARRY_IN : in std_logic; -- this is our carry-in from lower adder carry-out
	SUM_b 	: out std_logic_vector(3 downto 0); -- full adder sum output 
	CARRY_OUTPUT: out std_logic -- full adder carry output
	
);
end full_adder_4bit;

architecture full_bit_adder_4bit_logic of full_adder_4bit is 

	component full_adder_1bit port(
	
	-- gets information from 1-bit full adder
	
		INPUT_A, INPUT_B	: in std_logic; -- 1-bit inputs
		CARRY_IN				: in std_logic; -- carry-out from lower adder
		CARRY_OUTPUT, SUM_OUTPUT : out std_logic -- output for the full adder (SUM_OUTPUT & CARRY_OUTPUT)
	
	);
	
	end component;
	
	-- defining our logic variables:
	
	signal Carry_Out0 :std_logic;
	signal Carry_Out1 :std_logic;
	signal Carry_Out2 :std_logic;
	
	
begin 

	INST1: full_adder_1bit port map(BUS1_b(0), BUS0_b(0), CARRY_IN, Carry_Out0, SUM_b(0)); -- does the addition of first bit
	INST2: full_adder_1bit port map(BUS1_b(1), BUS0_b(1), Carry_Out0, Carry_Out1, SUM_b(1)); -- does the additon of the second bit with the carry_over if any from pervious bit.
	INST3: full_adder_1bit port map(BUS1_b(2), BUS0_b(2), Carry_Out1, Carry_Out2, SUM_b(2)); -- does the additon of the third bit with the carry_over if any from pervious bit.
	INST4: full_adder_1bit port map(BUS1_b(3), BUS0_b(3), Carry_Out2, CARRY_OUTPUT, SUM_b(3)); -- does the additon of the third bit with the carry_over if any from pervious bit.
	
end full_bit_adder_4bit_logic;
