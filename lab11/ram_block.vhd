library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ram_block is
  port (
    Clock : in std_logic;
    Address : in std_logic_vector(6 downto 0);
    Data : in std_logic_vector(7 downto 0);
    Q : out std_logic_vector(7 downto 0);
    WrEn : in std_logic
  );
end ram_block;

architecture direct of ram_block is
	type mem_type is array (127 downto 0) of std_logic_vector(7 downto 0);
	signal mem: mem_type;
	signal read_a:  std_logic_vector(6 downto 0);
begin
	process(CLock)
		begin
			if Clock'event and Clock = '1' then
				if WrEn='1' then
					mem(to_integer(unsigned(Address))) <= Data;
				end if;
				read_a <= Address;
			end if;
		end process;
		Q <= mem(to_integer(unsigned(read_a)));
end direct;