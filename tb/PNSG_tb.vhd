library IEEE;
use IEEE.std_logic_1164.all;

entity PNGS_tb is
end PNGS_tb;

architecture beh of PNGS_tb is

	-- constants
	constant T_CLK:	time := 20 ns;		-- clock period
	constant T_RST: time := 10 ns;		-- period before the reset deassertion 
	constant N_STAGE: positive := 15;	-- number of PNSG stages
	
	-- signals & variables
	signal clk_tb: std_logic := '0';	-- clock signal, initialized to '0'
	signal rst_n_tb: std_logic := '0';	-- reset signal, active low
	signal load_tb:	std_logic := '1';	-- initialization signal, active high, to load the seed
	signal seed: std_logic_vector(1 to N_STAGE) := "100000000000001";	-- initial seed for testing
	signal PN_code_tb: std_logic_vector(1 to N_STAGE);	-- output signal vector
	signal testing: boolean := true;
	
	variable clk_counter: integer := '0';
	
	-- dut
	component PNSG is
	
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
		
	end component;
	
begin
	
	clk_tb <= not clk_tb after T_CLK/2 when testing else '0';
	rst_n_tb <= '1' after T_RST;
	
	
end beh;











