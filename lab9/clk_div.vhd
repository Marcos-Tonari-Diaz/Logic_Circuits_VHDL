library ieee;
use ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

entity clk_div is
  port (
    clk : in std_logic;
    clk_hz : out std_logic
  );
end clk_div;

architecture behavioral of clk_div is
   --n: minimo 26
	--50e6(b) = 0010 1111 1010 1111 0000 1000 0000
	
	--UTILIZANDO 5hz
	CONSTANT T: STD_LOGIC_VECTOR (3 DOWNTO 0) := "0101";
	signal count : STD_LOGIC_VECTOR (3 DOWNTO 0) := "0000";
begin
	process(clk)
		begin
			if (clk'EVENT and clk = '1') then
				if count = T-1 then
					clk_hz <= '1';
					count <= (others =>'0'); 
				else
					clk_hz <= '0';
					count <= count + 1;
				end if;
			end if;
		end process;
end behavioral;
