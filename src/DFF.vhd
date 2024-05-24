library IEEE;
use IEEE.std_logic_1164.all;

-- d flip-flop -> positive edge triggered ff - asynchronous reset -> to store value

entity DFF is
	port (
	  clk	: in std_logic;		-- clock signal
	  rst_n	: in std_logic;		-- active low reset
	  d		: in std_logic;		-- input bit
	  q		: out std_logic		-- output bit
	);
end DFF;

architecture rtl of DFF is

begin
  dff_p: process(rst_n, clk)	-- sensitivity list: (resetn, clk)
  begin
    if rst_n='0' then
	  q <= '0';
	elsif (clk'event and clk='1') then
	  q <= d;
	end if;
  end process dff_p;
  
end rtl;
