-- ECE 124, LAB Session #206, Team Number #9, Tahmid Ahmed & Vidhi Patel
library ieee;
use ieee.std_logic_1164.all;

entity logicProcessorVHDL is 
port ( 
	logic_in0, logic_in1							: in std_logic_vector(3 downto 0); -- two 4-bit inputs
	mux_select										: in std_logic_vector(1 downto 0); -- 2-bit port for selecting one of the 4 logic operations
	hex_out											: out std_logic_vector(3 downto 0) -- The logic output
);

end logicProcessorVHDL;

architecture mux_logic of logicProcessorVHDL is 

begin 

	-- for the multiplexing of four logic input busses 
	with mux_select(1 downto 0) select
	hex_out <= (logic_in0 AND logic_in1) when "00", -- when input from mux_select is "00" it will do the AND logic to the two 4-bit inputs.
				  (logic_in0 OR logic_in1) when "01", -- when input from mux_select is "01" it will do the OR logic to the two 4-bit inputs.
				  (logic_in0 XOR logic_in1) when "10", -- when input from mux_select is "10" it will do the XOR logic to the two 4-bit inputs.
				  (logic_in0 XNOR logic_in1) when "11"; -- when input from mux_select is "11" it will do the XNOR logic to the two 4-bit inputs.
				  
end mux_logic;

