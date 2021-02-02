library ieee;
use ieee.std_logic_1164.all;

entity xbar_v1 is
  port(x1, x2, s: in std_logic;
       y1, y2: out std_logic);
end xbar_v1;

architecture rtl of xbar_v1 is
BEGIN
  WITH s SELECT
		y1 <= x1 WHEN'0',
				x2 WHEN OTHERS;
  WITH s SELECT
		y2 <= x2 WHEN '0',
				x1 WHEN OTHERS;
end rtl;

