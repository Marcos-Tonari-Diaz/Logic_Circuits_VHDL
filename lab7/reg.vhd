library ieee;
use ieee.std_logic_1164.all;

entity reg is
  generic (
    N : integer := 4
  );
  port (
    clk : in std_logic;
    data_in : in std_logic_vector(N-1 downto 0);
    data_out : out std_logic_vector(N-1 downto 0);
    load : in std_logic; -- Write enable
    clear : in std_logic
  );
end reg;

architecture rtl of reg is
begin
	process
		begin
			wait until clk'event and clk = '1';
			if clear = '1' then
				for i in N-1 downto 0 loop
					data_out(i) <= '0';
				end loop;
			elsif load = '1' then
				data_out <= data_in;
			end if;
		end process;
end rtl;
