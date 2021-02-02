-- brief : lab05 - question 2

library ieee;
use ieee.std_logic_1164.all;

entity cla_4bits is
  port(
    x    : in  std_logic_vector(3 downto 0);
    y    : in  std_logic_vector(3 downto 0);
    cin  : in  std_logic;
    sum  : out std_logic_vector(3 downto 0);
    cout : out std_logic
  );
end cla_4bits;

architecture rtl of cla_4bits is
	signal carries : std_logic_vector(3 downto 1);
begin
	--CLA
	carries(1)<= (x(0) and y(0)) or ((x(0) or y(0)) and cin);
	carries(2)<= (x(1) and y(1)) or ((x(1) or y(1)) and (x(0) and y(0))) or ((x(1) or y(1)) and (x(0) or y(0)) and cin);
	carries(3)<= (x(2) and y(2)) or ((x(2) or y(2)) and (x(1) and y(1))) or ((x(2) or y(2)) and (x(1) or y(1)) and (x(0) and y(0))) or ((x(2) or y(2)) and (x(1) or y(1)) and (x(0) or y(0)) and cin);
	cout<= (x(3) and y(3)) or ((x(3) or y(3)) and (x(2) and y(2))) or ((x(3) or y(3)) and (x(2) or y(2)) and (x(1) and y(1))) or ((x(3) or y(3)) and (x(2) or y(2)) and (x(1) or y(1)) and (x(0) and y(0))) or ((x(3) or y(3)) and (x(2) or y(2)) and (x(1) or y(1)) and (x(0) or y(0)) and cin);
	--FA 1
	sum(0)<=x(0) xor y(0) xor cin;
	--FA 2
	sum(1)<=x(1) xor y(1) xor carries(1);
	--FA 3
	sum(2)<=x(2) xor y(2) xor carries(2);
	--FA 4
	sum(3)<=x(3) xor y(3) xor carries(3);
	
end rtl;

