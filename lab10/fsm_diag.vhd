LIBRARY ieee ;
USE ieee.std_logic_1164.all;

entity fsm_diag is
    port (
      clock : in  std_logic;
      reset : in  std_logic;
      w     : in  std_logic;
      z     : out std_logic
    );
end fsm_diag;

architecture structural of fsm_diag is
	type states is (A, B, C, D);
	signal current : states;
begin
	process (reset, clock)
	begin
		if (clock'event and clock='1') then
			if reset = '1' then
				current <= A;
			else
				case current is
					when A =>
						if w = '1' then 
							current<= B;
						end if;
					when B =>
						if w = '0' then 
							current<= C;
						end if;
					when C =>
						if w = '1' then 
							current<= B;
						end if;
					when D =>
						if w = '0' then 
							current<= A;
						end if;
				end case;
			end if;
		end if;
	end process;
	z <= '1' when current = B else '0';
end structural;