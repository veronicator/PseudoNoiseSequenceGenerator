library IEEE;
use IEEE.std_logic_1164.all;

-- multiplexer 2-to-1 -> to select the initial seed or the feedback bit

entity MUX is
	port (
	  sel	: in std_logic;		-- control signal to select the correct input, active high
	  x_0	: in std_logic;		-- input if sel = 0 -> previous stage output bit
	  x_1	: in std_logic;		-- input if sel = 1 -> in this particular case, the seed bit
	  z		: out std_logic		-- output bit
	);
end MUX;

architecture beh of MUX is

begin
  mux_p: process(sel, x_0, x_1)
  begin
    if sel = '0' then
		z <= x_0;		-- previous stage bit in output
	else
		z <= x_1;		-- bit of the seed in output
	end if;
  end process mux_p;
  
end beh;
