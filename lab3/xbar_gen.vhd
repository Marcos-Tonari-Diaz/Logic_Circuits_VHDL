library ieee;
use ieee.std_logic_1164.all;

entity xbar_gen is
  generic (N: integer:=5);
  port(s: in std_logic_vector (N-1 downto 0);
       y1, y2: out std_logic);
end xbar_gen;

architecture rtl of xbar_gen is
	-- transicoes entre xbars
	signal c : std_logic_vector (2*(N-1)-1 downto 0);
	signal vcc : std_logic;
	signal gnd : std_logic;
	component xbar_v1
		port(x1, x2, s: in std_logic;
       y1, y2: out std_logic); 
	end component;
	begin
		gnd <= '0';
		vcc <= '1';
		first: xbar_v1 port map 
				(vcc, gnd ,s(0), c(0), c(1));
		stages: for i in 1 to N-2 generate
			bars: xbar_v1 port map 
				(c(2*i-2),c(2*i-1),s(i),c(2*i),c(2*i+1));
		end generate;
		last: xbar_v1 port map 
				(c(2*(N-1)-2), c(2*(N-1)-1) ,s(N-1), y1, y2);
end rtl;

