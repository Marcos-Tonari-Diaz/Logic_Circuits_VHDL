LIBRARY ieee ;
USE ieee.std_logic_1164.all;


entity fsm_seq is
    port (
      clock : in  std_logic;
      reset : in  std_logic;
      w     : in  std_logic;
      z     : out std_logic
    );
end fsm_seq;

architecture structural of fsm_seq is
	type states is (n, p0, p1, s0, s1);
	signal current : states;
begin
	process (reset, clock)
	begin
		if (clock'event and clock='1') then
			if reset = '1' then
				current <= n;
			else
				case current is
					when n =>
						if w = '0' then 
							current<= p0;
						end if;
					when p0 =>
						if w = '1' then 
							current<= p1;
						end if;
					when p1 =>
						if w = '0' then 
							current<= s0;
						else
							current<= n;
						end if;
					when s0 =>
						if w = '0' then 
							current<= p0;
						else
							current<= s1;
						end if;
					when s1 =>
						if w = '0' then 
							current<= s0;
						else
							current<= n;
						end if;
				end case;
			end if;
		end if;
	end process;
	z <= '1' when current = s1 else '0';
end structural;