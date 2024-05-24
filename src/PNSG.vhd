library IEEE;
use IEEE.std_logic_1164.all;

-- Pseudo Noise Sequence Generator -> N = 15 stages generator
-- Feedback polynomial: x^15 + x^13 + x^9 + x^8 + x^7 + x^5 + 1

entity PNSG is
	
	generic (N : positive := 15);

	port (
		clk		: in std_logic;		-- clock signal
		rst_n	: in std_logic;		-- reset signal, active low
		load	: in std_logic;		-- control signal to load the initial seed in the registers
		seed	: in std_logic_vector(1 to N);	-- initial seed of the generator
		PN_code	: out std_logic_vector(1 to N)	-- generated output sequence
	);
	