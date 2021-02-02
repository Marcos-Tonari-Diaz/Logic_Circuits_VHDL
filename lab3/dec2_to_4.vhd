library ieee;
use ieee.std_logic_1164.all;

entity dec2_to_4 is
  port(en, w1, w0: in std_logic;
       y3, y2, y1, y0: out std_logic);
end dec2_to_4;

architecture rtl of dec2_to_4 is
	signal Enw : std_logic_vector(2 downto 0);
	signal y : std_logic_vector(3 downto 0);
begin
  Enw <= en & w1 &w0;
  with Enw select 
	y <= "1000" WHEN "100",
		  "0100" WHEN "101",
		  "0010" WHEN "110",
		  "0001" WHEN "111",
		  "0000" WHEN OTHERS ;
	y0 <= y(3);
	y1 <= y(2);
	y2 <= y(1);
	y3 <= y(0);
end rtl;

