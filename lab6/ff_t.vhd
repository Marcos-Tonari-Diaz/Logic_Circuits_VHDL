library ieee;
use ieee.std_logic_1164.all;

entity ff_t is
  port (
    Clk : in std_logic;
    T : in std_logic;
    Q : out std_logic;
    Q_n : out std_logic;
    Preset : in std_logic;
    Clear : in std_logic
  );
end ff_t;

architecture rtl of ff_t is
	signal aux_and1: std_logic;
	signal aux_and2: std_logic;
	signal aux_or: std_logic;
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
		aux_and1 <= aux_q and (not T);
		aux_and2 <= aux_q_n and  T;
		aux_or <= aux_and1 or aux_and2;
		
		flip_flop: ff_d port map (Clk, aux_or, aux_q, aux_q_n, Preset, Clear);
		Q <= aux_q;
		Q_n <= aux_q_n;

end rtl;
