library ieee;
use ieee.std_logic_1164.all;

entity ff_jk is
  port (
    Clk : in std_logic;
    J : in std_logic;
    K : in std_logic;
    Q : out std_logic;
    Q_n : out std_logic;
    Preset : in std_logic;
    Clear : in std_logic
  );
end ff_jk;

architecture rtl of ff_jk is
	signal aux_D: std_logic;
	signal aux_q: std_logic;
	signal aux_q_n:std_logic;
	
	component ff_d is
	  port (
		 Clk : in std_logic;
		 D : in std_logic;
		 Q : out std_logic;
		 Q_n : out std_logic;
		 Preset : in std_logic;
		 Clear : in std_logic
	  );
	end component;
	
	begin
		aux_D <= (J and aux_q_n) or ((not K) and aux_q);
		
		flip_flop: ff_d port map (Clk, aux_D, aux_q, aux_q_n, Preset, Clear);
		Q <= aux_q;
		Q_n <= aux_q_n;
end rtl;
