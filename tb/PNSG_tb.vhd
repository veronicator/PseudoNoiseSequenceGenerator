library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;
use STD.textio.all;

entity PNGS_tb is
end PNGS_tb;

architecture beh of PNGS_tb is

	-- file for output sequence
	file PN_CODE_OUT_FILE: text is out "PN_code_out_file2.txt";

	-- constants
	constant T_CLK:	time := 10 ns;		-- clock period
	constant T_RST: time := 5 ns;		-- period before the reset deassertion 
	constant N_STAGE: positive := 15;	-- number of PNSG stages
	constant MAX_PERIOD: positive := 32767;	-- ma period before the pn_code repeats: 2^15 - 1
	
	-- signals
	signal clk_tb: std_logic := '0';	-- clock signal, initialized to '0'
	signal rst_n_tb: std_logic := '0';	-- reset signal, active low
	signal load_tb:	std_logic := '1';	-- initialization signal, active high, to load the seed
	signal seed_tb: std_logic_vector(1 to N_STAGE) := "101010101010101";	-- initial seed for testing
	signal PN_code_tb: std_logic_vector(1 to N_STAGE);	-- output signal vector
	signal testing: boolean := true;
	signal t: integer := 0;
	
	
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
		
	end component PNSG;
	
begin
	
	clk_tb <= not clk_tb after T_CLK/2 when testing else '0';
	rst_n_tb <= '1' after T_RST;	-- deasserting the reset after T_RST ns
	
	PNSG_dut: PNSG
	
	generic map (
		N_stage => N_STAGE
	)
	
	port map (
		clk => clk_tb,
		rst_n => rst_n_tb,
		load_seed => load_tb,
		seed => seed_tb,
		PN_code => PN_code_tb
	);
	
	stimuli: process (clk_tb, rst_n_tb)
	
		-- variable used to count the number of clock cycles after the reset, 
		-- to check when the pn_code starts to repeat
		variable clk_counter: integer := 0;
		
		variable out_bit_code: line;
		variable out_stream_code: std_logic_vector(1 to N_STAGE);
	
	begin
		
		--file_open(PN_CODE_OUT_FILE, "PN_code_out_file2.txt", write_mode);
		
		if (rst_n_tb = '0') then
			clk_counter := 0;		-- reset the clock counter
			seed_tb <= "101010101010101";
			load_tb <= '1';		-- to set the initial value of the seed
		elsif (rising_edge(clk_tb)) then
			load_tb <= '0';
			--clk_counter := clk_counter + 1;
			t <= clk_counter;
			
			if (PN_code_tb = seed_tb and clk_counter > 1) then
			-- if (clk_counter >= MAX_PERIOD) then
				testing <= false;
			elsif (clk_counter >= 1) then
				WRITE(out_bit_code, PN_code_tb, right, N_STAGE);
				WRITELINE(PN_CODE_OUT_FILE, out_bit_code);
			--else null
			
			end if;
			
			-- update the clk_counter
			clk_counter := clk_counter + 1;
			
		end if;
		
	end process;	
	
end beh;











