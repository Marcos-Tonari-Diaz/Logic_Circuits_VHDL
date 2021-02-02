LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

ENTITY zbuffer is
	PORT ( X : in std_logic_vector(3 downto 0);
			 E : in std_logic;
			 F : out std_logic_vector(3 downto 0) );
END zbuffer ;

ARCHITECTURE Behavior OF zbuffer IS
BEGIN
	F <= (OTHERS => 'Z') WHEN E = '0' ELSE X ;
END Behavior ;