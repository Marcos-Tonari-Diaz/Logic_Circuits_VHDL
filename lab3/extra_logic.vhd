library ieee;
use ieee.std_logic_1164.all;

entity extra_logic is
  port(w3, w2, w1, w0 : in std_logic;
       y3, y2, y1, y0 : in std_logic;
       f : out std_logic);
end extra_logic;

architecture rtl of extra_logic is
begin
	f <= (y0 and w0) or
		  (y1 and w1) or
		  (y2 and w2) or
		  (y3 and w3);	
end rtl;

