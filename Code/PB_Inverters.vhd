-- ECE 124, LAB Session #206, Team Number #9, Tahmid Ahmed & Vidhi Patel
LIBRARY ieee;
USE ieee.std_logic_1164.all;

-- Convert signal inputs to Active_HIGH
ENTITY PB_Inverters IS 
	PORT 
	( 
		pb_n : IN std_logic_vector(3 downto 0); -- pb inputs
		pb : OUT std_logic_vector(3 downto 0)  -- pb inverted outputs
	);

END PB_Inverters;

ARCHITECTURE gates OF PB_Inverters IS 

BEGIN 

pb <= not(pb_n); -- process to invert the inputs
				  
END gates;
