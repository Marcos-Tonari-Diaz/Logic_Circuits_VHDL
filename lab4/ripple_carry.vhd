library ieee;
use ieee.std_logic_1164.all;

entity ripple_carry is
  generic (
    N : integer := 4
  );
  port (
    x,y : in std_logic_vector(N-1 downto 0);
    r : out std_logic_vector(N-1 downto 0);
    cin : in std_logic;
    cout : out std_logic;
    overflow : out std_logic
  );
end ripple_carry;

architecture rtl of ripple_carry is
	-- vetor de carries intermediarios
	signal cint : std_logic_vector(N-1 downto 1);
	-- cout temporario
	signal coutTemp : std_logic;
	component full_adder 
		port (
			 x, y : in std_logic;
			 r : out std_logic;
			 cin : in std_logic;
			 cout : out std_logic
	  );
	end component;
begin
	first: full_adder port map
			(x(0), y(0), r(0), cin, cint(1));
	-- instancia N-2 full adders
	g: for i in 1 to N-2 generate
		adders: full_adder port map
			(x(i), y(i), r(i), cint(i), cint(i+1));
	end generate;
	last: full_adder port map
			(x(N-1), y(N-1), r(N-1), cint(N-1), coutTemp);
		
	overflow <= coutTemp xor cint(N-1);
	cout <= coutTEMP;
end rtl;
