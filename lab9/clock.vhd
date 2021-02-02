library ieee;
use ieee.std_logic_1164.all;

entity clock is
  port (
    clk : in std_logic;
    decimal : in std_logic_vector(3 downto 0);
    unity : in std_logic_vector(3 downto 0);
    set_hour : in std_logic;
    set_minute : in std_logic;
    set_second : in std_logic;
    hour_dec, hour_un : out std_logic_vector(6 downto 0);
    min_dec, min_un : out std_logic_vector(6 downto 0);
    sec_dec, sec_un : out std_logic_vector(6 downto 0)
  );
end clock;

architecture rtl of clock is
  component clk_div is
    port (
      clk : in std_logic;
      clk_hz : out std_logic
    );
  end component;
  
 component bcd_counter is
  port (
    global_clk : in std_logic;
    time_clk : in std_logic;
	 load : in std_logic;
	 decimal : in std_logic_vector(3 downto 0);
    unity : in std_logic_vector(3 downto 0);
	 clk_const : in std_logic_vector(32 downto 0);
	 decMAX : in std_logic_vector(3 downto 0);
    uniMAX : in std_logic_vector(3 downto 0);
	 clk_out: out std_logic;
	 BCD1: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
	 BCD0 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
  );
end component;

component bin2dec is
	port (
		bin: in std_logic_vector(3 downto 0);
		dec: out std_logic_vector(6 downto 0)
);
end component;

signal clk_hz : std_logic;
signal carry_min : std_logic;
signal carry_hour : std_logic;
signal s_display0 :std_logic_vector(3 downto 0):="0000";
signal s_display1 :std_logic_vector(3 downto 0):="0000";
signal m_display0 :std_logic_vector(3 downto 0):="0000";
signal m_display1 :std_logic_vector(3 downto 0):="0000";
signal h_display0 :std_logic_vector(3 downto 0):="0000";
signal h_display1 :std_logic_vector(3 downto 0):="0000";

-- inputs maximos
CONSTANT MAXsec0: STD_LOGIC_VECTOR (3 DOWNTO 0) := "1001"; --9
CONSTANT MAXsec1: STD_LOGIC_VECTOR (3 DOWNTO 0) := "0101"; --5
CONSTANT MAXmin0: STD_LOGIC_VECTOR (3 DOWNTO 0) := "1001"; --9
CONSTANT MAXmin1: STD_LOGIC_VECTOR (3 DOWNTO 0) := "0101"; --5
CONSTANT MAXhou0: STD_LOGIC_VECTOR (3 DOWNTO 0) := "1001"; --9
CONSTANT MAXhou1: STD_LOGIC_VECTOR (3 DOWNTO 0) := "0010"; --2

begin
	clock_divider : clk_div port map (clk, clk_hz);
	-- segundos "000000010111110101111000010000000"
	seconds : bcd_counter port map (clk, clk_hz, set_second, decimal, unity, "000000010111110101111000010000000", MAXsec1, MAXsec0, carry_min, s_display1, s_display0);
	seconds_display0 : bin2dec port map (s_display0, sec_un);
	seconds_display1 : bin2dec port map (s_display1, sec_dec);
	--minutos "000010001111000011010001100000000"
	minutes : bcd_counter port map (clk, carry_min, set_minute, decimal, unity, "000010001111000011010001100000000", MAXmin1, MAXmin0, carry_hour, m_display1, m_display0);
	minutes_display0 : bin2dec port map (m_display0, min_un);
	minutes_display1 : bin2dec port map (m_display1, min_dec);
	--horas
   hours : bcd_counter port map (clk, carry_hour, set_hour, decimal, unity, "000010001111000011010001100000000", MAXhou1, MAXhou0, open, h_display1, h_display0);
	hours_display0 : bin2dec port map (h_display0, hour_un);
	hours_display1 : bin2dec port map (h_display1, hour_dec);

end rtl;