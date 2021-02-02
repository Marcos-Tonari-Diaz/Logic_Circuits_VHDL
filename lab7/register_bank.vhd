library ieee;
use ieee.std_logic_1164.all;

entity register_bank is
  port (
    clk : in std_logic;
    data_in : in std_logic_vector(3 downto 0);
    data_out : out std_logic_vector(3 downto 0);
    reg_rd : in std_logic_vector(2 downto 0);
    reg_wr : in std_logic_vector(2 downto 0);
    we : in std_logic;
    clear : in std_logic
  );
end register_bank;

architecture structural of register_bank is
	signal d2r : std_logic_vector(0 to 7);
	signal r2d : std_logic_vector(0 to 7);
	-- 4 para cada reg
	signal d_out : std_logic_vector(31 downto 0);
	
component reg is
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
end component;

component dec3to8 IS
	PORT (w : IN STD_LOGIC_VECTOR(2 DOWNTO 0) ;
	y : OUT STD_LOGIC_VECTOR(0 TO 7) ) ;
END component;

component zbuffer is
	PORT ( X : in std_logic_vector(3 downto 0);
			 E : in std_logic;
			 F : out std_logic_vector(3 downto 0) );
END component;

begin

	wr_decoder: dec3to8
		port map (reg_wr, d2r);
	
	regs: for i in 0 to 7 generate
		registers: reg
			generic map (N=>4)
			port map
			(clk, data_in, d_out((4*i+3) downto (4*i)), d2r(i), clear);
	end generate;
	
	rd_decoder: dec3to8
		port map (reg_rd, r2d);
		
	buffers: for i in 0 to 7 generate
		buf: zbuffer
			port map (d_out((4*i+3) downto (4*i)), r2d(i), data_out);
	end generate;

end structural;
