library ieee;
use ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

entity bcd_counter is
  port (
    global_clk : in std_logic;
    time_clk : in std_logic;
	 load : in std_logic;
	 decimal : in std_logic_vector(3 downto 0);
    unity : in std_logic_vector(3 downto 0);
	 -- constantes
	 clk_const : in std_logic_vector(32 downto 0);
	 decMAX : in std_logic_vector(3 downto 0);
    uniMAX : in std_logic_vector(3 downto 0);
	 clk_out: out std_logic;
	 BCD1: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
	 BCD0 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
  );
end bcd_counter;

architecture behavioral of bcd_counter is
	signal clk_out_s: std_logic :='0';
	signal sBCD0 :  STD_LOGIC_VECTOR(3 DOWNTO 0);
	signal sBCD1 :  STD_LOGIC_VECTOR(3 DOWNTO 0);
begin
	process(global_clk)
		variable load_now: integer:=0;
		variable clk_counter: std_logic_vector(32 downto 0):= "000000000000000000000000000000001";
		
		begin
			if (global_clk'EVENT and global_clk = '1') then
				--prepara o proximo nivel
				if sBCD0 = uniMAX and sBCD1 = decMAX then                                                                                              
					if clk_counter = clk_const - '1' then
						clk_out_s <= '1';
						clk_counter:=clk_counter+'1';
					elsif clk_counter = clk_const then
						clk_out_s <= '0';
						clk_counter:="000000000000000000000000000000001";
					else
						clk_counter:=clk_counter+1;
						clk_out_s <= '0';
					end if;
				end if;
				
				--carrega
				if load_now=1 then
					--verifica se os valores sao validos
					if (unity<=uniMAX and decimal <=decMAX) then
						sBCD0<=unity;
						sBCD1<=decimal;
					end if;
					load_now := 0;
				elsif (load='1') then
					load_now := 1;
				end if;
				
				--conta o tempo
				if (time_clk = '1') then
					IF sBCD0 = uniMAX THEN
						sBCD0 <= "0000";
						IF sBCD1 = decMAX THEN
							sBCD1 <= "0000";
						ELSE
							sBCD1 <= sBCD1 + '1' ;
						END IF ;
					--caso especial de hora (24h)
					ELSIF decMAX="0010" and sBCD0="0011" then 
						sBCD0 <= "0000";
						sBCD1 <= "0000";
					ELSE
						sBCD0 <= sBCD0 + '1' ;
					END IF;
				end if;
			end if;
		end process;
		BCD0<=sBCD0;
		BCD1<=sBCD1;
		clk_out<=clk_out_s;
end behavioral;