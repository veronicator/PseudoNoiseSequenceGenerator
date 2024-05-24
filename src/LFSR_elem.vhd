library IEEE;
use IEEE.std_logic_1164.all;

-- single block element of an Linear Feedback Shift Register
-- composed by a mutex and a dff in cascade

entity LFSR_elem is

	port (
	  clk	: in std_logic;		-- clock signal
	  rst_n	: in std_logic;		-- active low reset
	  init	: in std_logic;		-- control signal for mutex to insert the initial value
	  in_0	: in std_logic;		-- input bit (previous stage result)
	  in_1	: in std_logic;		-- input bit (seed)
	  q		: out std_logic		-- output bit
	);
	
end LFSR_elem;

architecture struct of LFSR_elem is
	
	signal z_d : std_logic;	-- internal signal to connect mux output to dff input 
	
	component MUX is
		port (
		  sel	: in std_logic;		
		  x_0	: in std_logic;		
		  x_1	: in std_logic;		
		  z		: out std_logic		
		);
	component MUX;	
	
	component DFF
		port (
			clk		: in std_logic;
			rst_n	: in std_logic;
			d 		: in std_logic;
			q		: out std_logic
		);
	end component DFF;

begin

	mux_i: MUX
	port map (
		sel => init,
		x_0 => in_0,
		x_1 => in_1,
		z => z_d
	);
	
	dff_i: DFF
	port map (
		clk => clk,
		rst_n => rst_n,
		d => z_d,
		q => q
	);

end struct;
