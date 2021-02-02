library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity ram is
  port (
    Clock : in std_logic;
    Address : in std_logic_vector(9 downto 0);
    DataIn : in std_logic_vector(31 downto 0);
    DataOut : out std_logic_vector(31 downto 0);
    WrEn : in std_logic
  );
end ram;

architecture rtl of ram is

component ram_block is
  port (
    Clock : in std_logic;
    Address : in std_logic_vector(6 downto 0);
    Data : in std_logic_vector(7 downto 0);
    Q : out std_logic_vector(7 downto 0);
    WrEn : in std_logic
  );
end component;

signal FirstRowEn: std_logic := '0';
signal SecondRowEn: std_logic := '0';
signal DataOutSignalRow1: std_logic_vector(31 downto 0);
signal DataOutSignalRow2: std_logic_vector(31 downto 0);
signal AddrLocator: std_logic_vector(2 downto 0);

begin
	-- 1.1 a 1.4
	ram1_1: ram_block port map(Clock, Address(6 downto 0), DataIn(7 downto 0), DataOutSignalRow1(7 downto 0), FirstRowEn);
	ram1_2: ram_block port map(Clock, Address(6 downto 0), DataIn(15 downto 8), DataOutSignalRow1(15 downto 8), FirstRowEn);
	ram1_3: ram_block port map(Clock, Address(6 downto 0), DataIn(23 downto 16), DataOutSignalRow1(23 downto 16), FirstRowEn);
	ram1_4: ram_block port map(Clock, Address(6 downto 0), DataIn(31 downto 24), DataOutSignalRow1(31 downto 24), FirstRowEn);
	-- 2.1 a 2.4
	ram2_1: ram_block port map(Clock, Address(6 downto 0), DataIn(7 downto 0), DataOutSignalRow2(7 downto 0), SecondRowEn);
	ram2_2: ram_block port map(Clock, Address(6 downto 0), DataIn(15 downto 8), DataOutSignalRow2(15 downto 8), SecondRowEn);
	ram2_3: ram_block port map(Clock, Address(6 downto 0), DataIn(23 downto 16), DataOutSignalRow2(23 downto 16), SecondRowEn);
	ram2_4: ram_block port map(Clock, Address(6 downto 0), DataIn(31 downto 24), DataOutSignalRow2(31 downto 24), SecondRowEn);
	
	AddrLocator <= Address(9)&Address(8)&Address(7);
	
	--leitura
	with AddrLocator select
		DataOut<= DataOutSignalRow1 when "000",
					 DataOutSignalRow2 when "001",
					 (others=>'Z') when others;
	--escrita
	with AddrLocator select
		FirstRowEn<= WrEn when "000", '0' when others;
	with AddrLocator select
		SecondRowEn<= WrEn when "001", '0' when others;
	
end rtl;