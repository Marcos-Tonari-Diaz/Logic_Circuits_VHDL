library ieee;
use ieee.std_logic_1164.all;

entity alu is
  port (
    a, b : in std_logic_vector(3 downto 0);
    F : out std_logic_vector(3 downto 0);
    s0, s1 : in std_logic;
    Z, C, V, N : out std_logic
  );
end alu;

architecture behavioral of alu is

	signal sub : std_logic;
	signal cout : std_logic;
	signal overflow : std_logic;
	signal S : std_logic_vector(1 downto 0);
	signal bAddSub : std_logic_vector (3 downto 0);
	signal sum : std_logic_vector (3 downto 0);
	signal final: std_logic_vector (3 downto 0);
	
	component ripple_carry 
		  generic (N : integer := 4);
		  port (
			 x,y : in std_logic_vector(N-1 downto 0);
			 r : out std_logic_vector(N-1 downto 0);
			 cin : in std_logic;
			 cout : out std_logic;
			 overflow : out std_logic
		  );
	end component;
	
	begin
		-- Somador/Subtrator
		-- concatenar sinais de controle
		S <= s1 & s0;
		with S select
			sub <= '0' when "00",
					 '1' when others;
			
		bAddSub <= (b(3) xor sub)&(b(2) xor sub)&(b(1) xor sub)&(b(0) xor sub);
		
		ripple_carry_alu: ripple_carry
			port map (a, bAddSub, sum, sub, cout, overflow);

		--	saida
		with S select
			final<= a and b when "10",
				 a or b when "11",
				 sum when others;
				 
		with S select
			C<= cout when "00",
				 cout when "01",
				 '0' when others;
				 
		with S select		 
			V<= overflow when "00",
				 overflow when "01",
				 '0' when others;
				  
		with S select
			N<= sum(3) when "00",
				 sum(3) when "01",
				 '0' when others;
		
		with final select 
			Z <= '1' when "0000",
				  '0' when others;
		F <= final;
		
		
end behavioral;
