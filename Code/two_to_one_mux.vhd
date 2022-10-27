-- ECE 124, LAB Session #206, Team Number #9, Tahmid Ahmed & Vidhi Patel
library ieee;
use ieee.std_logic_1164.all;

entity two_to_one_mux is 
port ( 
	hex_A								: in std_logic_vector(3 downto 0); -- 4-bit input
	hex_B								: in std_logic_vector(3 downto 0); -- 4-bit input
	mux_select						: in std_logic; -- 1-bit selector
	hex_out							: out std_logic_vector(3 downto 0) -- 4-bit output
);

end two_to_one_mux;

architecture mux_logic of two_to_one_mux is 

begin 

	-- for the multiplexing of four hex input busses 
	with mux_select select
	hex_out <= hex_A when '0', -- when input from mux_select is '0' hex_A will be selected.
				  hex_B when '1'; -- when input from mux_select is '1' hex_B will be selected.
				  
end mux_logic;
