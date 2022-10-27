-- ECE 124, LAB Session #206, Team Number #9, Tahmid Ahmed & Vidhi Patel
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity LogicalStep_Lab2_top is port (
   clkin_50			: in	std_logic;
	pb_n				: in	std_logic_vector(3 downto 0); -- Push button inputs.
 	sw   				: in  std_logic_vector(7 downto 0); -- The switch inputs
   leds				: out std_logic_vector(7 downto 0); -- for displaying the switch content
   seg7_data 		: out std_logic_vector(6 downto 0); -- 7-bit outputs to a 7-segment
	seg7_char1  	: out	std_logic;				    		-- seg7 digit1 selector
	seg7_char2  	: out	std_logic				    		-- seg7 digit2 selector
	
); 
end LogicalStep_Lab2_top;

architecture SimpleCircuit of LogicalStep_Lab2_top is
--
-- Components Used ---
------------------------------------------------------------------- 
  component SevenSegment port (
   hex   		:  in  std_logic_vector(3 downto 0);   -- The 4 bit data to be displayed
   sevenseg 	:  out std_logic_vector(6 downto 0)    -- 7-bit outputs to a 7-segment
   ); 
   end component;
	
	component segment7_mux port (
          clk        : in  std_logic := '0';
			 DIN2 		: in  std_logic_vector(6 downto 0);	
			 DIN1 		: in  std_logic_vector(6 downto 0);
			 DOUT			: out	std_logic_vector(6 downto 0);
			 DIG2			: out	std_logic;
			 DIG1			: out	std_logic
	); 
   end component;
	
	component logicProcessorVHDL port (
          logic_in0, logic_in1				: in std_logic_vector(3 downto 0); -- hex_A & hex_B inputs respectively
			 mux_select								: in std_logic_vector(1 downto 0); -- pbs(1 to 0) as input
			 hex_out									: out std_logic_vector(3 downto 0) -- output which will be as a result of our input pbs
	); 
   end component;
	
	component PB_Inverters port (
          pb_n : IN std_logic_vector(3 downto 0); -- takes in input from the four pbs.
			 pb : OUT std_logic_vector(3 downto 0) -- outputs the inversion.
	); 
   end component;
	
	component full_adder_4bit port(
			BUS0_b	: in std_logic_vector(3 downto 0); -- 1-bit input
			BUS1_b 	: in std_logic_vector(3 downto 0); -- 1-bit input
			CARRY_IN : in std_logic := '0'; -- this is our carry-in from lower adder carry-out
			SUM_b 	: out std_logic_vector(3 downto 0); -- full adder sum output 
			CARRY_OUTPUT: out std_logic -- full adder carry output
	);
	end component;
	
	
	component two_to_one_mux port ( 
			hex_A								: in std_logic_vector(3 downto 0); -- 4-bit input
			hex_B								: in std_logic_vector(3 downto 0); -- 4-bit input	
			mux_select						: in std_logic; -- 1-bit selector
			hex_out							: out std_logic_vector(3 downto 0) -- 4-bit output
	);
	end component;

	
	
-- Create any signals, or temporary variables to be used
--
--  std_logic_vector is a signal which can be used for logic operations such as OR, AND, NOT, XOR
--	

-- Defining logic vectors below:
	
	signal hex_A		: std_logic_vector(3 downto 0);
	signal hex_B		: std_logic_vector(3 downto 0);
	
	signal seg7_A		: std_logic_vector(6 downto 0);
	signal seg7_B		: std_logic_vector(6 downto 0);
	
	signal pb_out		: std_logic_vector(3 downto 0);
	
	signal SUM_OUTPUT		: std_logic_vector(3 downto 0);
	signal CARRY_OUTPUT	: std_logic;
	
	signal signal_C 	:std_logic_vector(3 downto 0);
	
	signal output_1 	:std_logic_vector(3 downto 0);
	signal output_2 	:std_logic_vector(3 downto 0);
	
	
	
	
-- Here the circuit begins

begin


	hex_A <= Sw(3 downto 0); -- input from switch 0 to3.
	hex_B <= Sw(7 downto 4); -- input from swtich 4 to 7.
	
	signal_C <= ("000" & CARRY_OUTPUT);	-- concatenation 

	
	
--COMPONENT HOOKUP
--
-- generate the seven segment coding

		INST1: full_adder_4bit port map(hex_A, hex_B, '0', SUM_OUTPUT, CARRY_OUTPUT); -- calling our 4-bit full adder, this adds our two hex numbers.
		INST2: segment7_mux port map(clkin_50, seg7_A, seg7_B, seg7_data, seg7_char2, seg7_char1); -- calling our segment7_mux.
		INST3: PB_Inverters port map(pb_n, pb_out); -- calling our pb inverters because the board is active low. 
		INST4: logicProcessorVHDL port map(hex_A, hex_B, pb_out(1 downto 0), leds( 3 downto 0)); -- calling our logic processor to output whether it is a AND, OR, XOR, XNOR.
		INST5: two_to_one_mux port map(hex_B, signal_C, pb_out(2), output_2); -- calling our two-to-one mux for one of the two options.
		INST6: two_to_one_mux port map(hex_A, SUM_OUTPUT,  pb_out(2), output_1); -- calling our two-to-one mux for the other option.
		INST7: SevenSegment port map(output_1, seg7_A); -- calling our sevensegment to output results onto board.
		INST8: SevenSegment port map(output_2, seg7_B); -- calling our sevensegment to output results onto board.
		
		

		
		
end SimpleCircuit;


