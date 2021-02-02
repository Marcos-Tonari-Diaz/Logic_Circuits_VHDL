library ieee;
use ieee.std_logic_1164.all;

entity ff_d is
  port (
    Clk : in std_logic;
    D : in std_logic;
    Q : out std_logic;
    Q_n : out std_logic;
    Preset : in std_logic;
    Clear : in std_logic
  );
end ff_d;

architecture rtl of ff_d is
	begin
		process
			variable temp: std_logic;
		begin
			temp := '0';
			wait until Clk'event and Clk = '1';
				if Clear= '1' then
					temp := '0';
				elsif Preset = '1' then
					temp := '1';
				else
					temp := D;
				end if;
		Q <= temp;
		Q_n <= not temp;		
		end process;
end rtl;
