library ieee;
use ieee.std_logic_1164.all;

entity mux16_to_1 is
  port(data : in std_logic_vector(15 downto 0);
       sel : in std_logic_vector(3 downto 0);
       output : out std_logic);
end mux16_to_1;

architecture rtl of mux16_to_1 is
	signal inter: std_logic_vector(3 downto 0);
	signal sel_first: std_logic_vector(1 downto 0);
	signal sel_second: std_logic_vector(1 downto 0);
	component mux4_to_1
	  port(d3, d2, d1, d0 : in std_logic;
			 sel : in std_logic_vector(1 downto 0);
			 output : out std_logic);
	end component;
	begin
		sel_first <= sel(1) & sel(0); 
		gen: for i in 0 to 3 generate
			muxes: mux4_to_1 
				port map(data(4*i+3), data(4*i+2), data(4*i+1), data(4*i),
					sel_first,
					inter(i));
		end generate;
		sel_second <= sel(3) & sel(2);
		lastMux: mux4_to_1
			port map (inter(3), inter(2), inter(1), inter(0),
						sel_second,
						output);
end rtl;

