library IEEE;
use IEEE.std_logic_1164.all;

-- Pseudo Noise Sequence Generator -> N = 15 stages generator
-- Feedback polynomial: x^15 + x^13 + x^9 + x^8 + x^7 + x^5 + 1
-- -> taps: [ 13 9 8 7 5 ]

entity PNSG is
	
	generic (
		N_stage : positive := 15
		);
	
	port (
		clk	 		: in std_logic;		-- clock signal
		rst_n		: in std_logic;		-- reset signal, active low
		load_seed	: in std_logic;		-- control signal to load the initial seed in the registers
		seed		: in std_logic_vector(1 to N_stage);	-- initial seed of the generator
		PN_code		: out std_logic_vector(1 to N_stage)	-- generated output sequence
	);
	
end PNSG;

architecture beh of PNSG is

	signal q_out	: std_logic_vector (1 to N_stage);		-- output bits from each stage
	signal feedback_bit	: std_logic;

	component LFSR_elem is
		port (
			clk		: in std_logic;
			rst_n	: in std_logic;
			init	: in std_logic;
			in_0	: in std_logic;
			in_1	: in std_logic;
			q		: out std_logic
		);
	end component LFSR_elem;
	
begin
	
	GEN: for i in 1 to N_stage generate
		-- first stage element
		FIRST: if i = 1 generate
			LFSR_elem_1: LFSR_elem
			port map (
				clk		=> clk,
				rst_n	=> rst_n,
				init	=> load_seed,
				in_0	=> feedback_bit,
				in_1	=> seed(i),
				q		=> q_out(i)
			);
		end generate FIRST;
		
		-- all other internal stages, including the last one
		INTERNAL: if i > 1 and i < N_stage+1 generate
			LFSR_elem_i: LFSR_elem
			port map (
				clk		=> clk,
				rst_n	=> rst_n,
				init	=> load_seed,
				in_0	=> q_out(i-1),
				in_1	=> seed(i),
				q		=> q_out(i)			
			);
		end generate INTERNAL;
	end generate GEN;
	
	-- combinational logic
	-- the feedback bit is generated through the xor operations of the taps
	feedback_bit <= ((((( q_out(15) xor q_out(13) ) 
										xor q_out(9) ) 
											xor q_out(8) ) 
												xor q_out(7) ) 
													xor q_out(5) );
	PN_code <= q_out;
	
end beh;










