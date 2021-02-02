library ieee;
use ieee.std_logic_1164.all;

entity shift_register is
generic (N : integer := 6);
port(
    clk     : in  std_logic;
    mode    : in  std_logic_vector(1 downto 0);
    ser_in  : in  std_logic;
    par_in  : in  std_logic_vector((N - 1) downto 0);
    par_out : out std_logic_vector((N - 1) downto 0)
  );
end shift_register;

architecture rtl of shift_register is
	signal ffs: std_logic_vector((N - 1) downto 0);
begin
	process(clk)
		begin
			if clk'event and clk = '1' then
				-- shift left
				if mode = "01" then
					for i in (N-1) downto 1 loop
						ffs(i) <= ffs(i-1);
					end loop;
					ffs(0) <= ser_in;
					
				-- shift right	
				elsif mode = "10" then
					for i in (N-2) downto 0 loop
						ffs(i) <= ffs(i+1);
					end loop;
					ffs(N-1) <= ser_in;
					
				-- parallel load
				elsif mode = "11" then
					for i in (N-1) downto 0 loop
						ffs(i) <= par_in(i);
					end loop;
					
				-- keep state
				else
					null;
				end if;
			end if;
		end process;
		par_out <= ffs;
end rtl;
