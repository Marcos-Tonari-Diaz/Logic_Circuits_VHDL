LIBRARY ieee ;
USE ieee.std_logic_1164.all;

entity fsm_table is
    port (
      clock : in  std_logic;
      reset : in  std_logic;
      w     : in  std_logic;
      z     : out std_logic
    );
end fsm_table;

architecture structural of fsm_table is
	type states is (A, B, C, D);
	signal current : states;
	signal zTemp : std_logic;
begin
	process (reset, clock)
	begin
		if (clock'event and clock='1') then
			--expressao reduzida de z
			--zTemp <= (not w and not (current=C) and not (current=D))
			--+ (w and not (current=B) and not (current=C));
			if reset = '1' then
				current <= A;
				if w = '0' then 
					zTemp <= '1';
				else
					zTemp <= '1';
				end if;
			else
				case current is
					when A =>
						if w = '0' then 
							current<= C;
							zTemp <= '1';
						else
							current<= B;
							zTemp <= '1';
						end if;
					when B =>
						if w = '0' then 
							current<= D;
							zTemp <= '1';
						else
							current<= C;
							zTemp <= '0';
						end if;
					when C =>
						if w = '0' then 
							current<= B;
							zTemp <= '0';
						else
							current<= C;
							zTemp <= '0';
						end if;
					when D =>
						if w = '0' then 
							current<= A;
							zTemp <= '0';
						else
							current<= C;
							zTemp <= '1';
						end if;
				end case;
			end if;
		end if;
	end process;
	z <= zTemp;
end structural;