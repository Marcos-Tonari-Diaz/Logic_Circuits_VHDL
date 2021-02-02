LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

ENTITY original IS
	PORT ( A, B, C, D, E: IN STD_LOGIC ;
		    F : OUT STD_LOGIC ) ;
END original;

ARCHITECTURE originalFunction OF original IS
BEGIN
	F	 <= ((NOT A) AND (NOT B) AND (NOT C) AND (NOT D) AND (NOT E)) 
	OR ((NOT A) AND (NOT B) AND (NOT C) AND D AND (NOT E)) 
	OR ((NOT A) AND (NOT B) AND C AND (NOT D) AND E) 
	OR ((NOT A) AND B AND (NOT C) AND (NOT D) AND (NOT E)) 
	OR ((NOT A) AND B AND C AND (NOT D) AND E) 
	OR ((NOT A) AND B AND C AND D AND E) 
	OR (A AND (NOT B) AND (NOT C) AND D AND (NOT E)) 
	OR (A AND (NOT B) AND C AND (NOT D) AND E) 
	OR (A AND B AND (NOT C) AND (NOT D) AND (NOT E)) 
	OR (A AND B AND C AND (NOT D) AND E) 
	OR (A AND B AND C AND D AND E);
END originalFunction;