LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

ENTITY minimizado IS
	PORT ( A, B, C, D, E: IN STD_LOGIC ;
		    F : OUT STD_LOGIC ) ;
END minimizado;

ARCHITECTURE minFunction OF minimizado IS
BEGIN
	F <= (B AND C AND E) OR (C AND NOT D AND E) 
	OR (NOT A AND NOT B AND NOT C AND NOT E) 
	OR (NOT B AND NOT C AND D AND NOT E) 
	OR (B AND NOT C AND NOT D AND NOT E);
END minFunction;