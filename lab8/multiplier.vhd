library ieee;
use ieee.std_logic_1164.all;

entity multiplier is
	generic(
	N:integer:=4
	);
	port(
		a,b : in std_logic_vector (N-1 downto 0);
	-- Operandos (multiplicador e multiplicando)
		r : out std_logic_vector (2*N-1 downto 0);
	-- Resultado (produto)
		clk : in std_logic;
	-- Clock
		set : in std_logic
	-- Operandos foram alterados
	);
end multiplier;

architecture rtl of multiplier is

component ripple_carry is
  generic (
    N : integer := 4
  );
  port (
    x,y : in std_logic_vector(N-1 downto 0);
    r : out std_logic_vector(N-1 downto 0);
    cin : in std_logic;
    cout : out std_logic;
    overflow : out std_logic
  );
end component;

component shift_register is
	generic (N : integer := 6);
	port(
    clk     : in  std_logic;
    mode    : in  std_logic_vector(1 downto 0);
    ser_in  : in  std_logic;
    par_in  : in  std_logic_vector(N-1 downto 0);
    par_out : out std_logic_vector(N-1 downto 0)
	);
end component;

signal multiplier_mode :std_logic_vector(1 downto 0);
signal multiplicand_mode: std_logic_vector(1 downto 0);
signal product_mode: std_logic_vector(1 downto 0);

signal multiplicand_in: std_logic_vector(2*N-1 downto 0);
signal padding: std_logic_vector(N-1 downto 0);


signal multiplier_out: std_logic_vector(N-1 downto 0);
signal add_multiplicand: std_logic_vector(2*N-1 downto 0);
signal add_product: std_logic_vector(2*N-1 downto 0);
signal adder_out: std_logic_vector(2*N-1 downto 0);
signal product_in: std_logic_vector(2*N-1 downto 0);


signal cout: std_logic;
signal overflow: std_logic;

begin

multiplier: shift_register
	generic map (N=>N)
	port map (clk, multiplier_mode, '0', a, multiplier_out);

multiplicand: shift_register
	generic map (N=>2*N)
	port map (clk, multiplicand_mode, '0', multiplicand_in, add_multiplicand);

product: shift_register
	generic map (N=>2*N)
	port map (clk, product_mode, '0', product_in, add_product);

adder: ripple_carry
	generic map (N=>2*N)
	port map (add_multiplicand, add_product, adder_out, '0', cout, overflow);

padding <= (others =>'0');
multiplicand_in <= padding & b;

process(set, clk)
		variable COUNT : integer;
		begin
		--inicializacao
			if set = '1' then 
				COUNT := 0;
				--inicializa produto com 0s
				product_in <= (others =>'0');
				-- load
				multiplier_mode <= "11";
				multiplicand_mode <= "11";
				product_mode <= "11";
			else
				--multiplicacao
					product_in <= adder_out;
					--termina a multiplicacao
					--(primeiro ciclo de multiplicacao tem count=1)
					if COUNT = N then
						-- registradores parados
						multiplier_mode <= "00";
						multiplicand_mode <= "00";
						product_mode <= "00";
					--um ciclo de multiplicacao
					else
						if multiplier_out(0)='1' then
							-- coloque a soma em produto
							product_mode <= "11";
						else
							-- mantenha o valor de produto
							product_mode <= "00";
						end if;
						--shift right
						multiplier_mode <= "10";
						--shift left
						multiplicand_mode <= "01";
					end if;
					if clk'event and clk = '1' then
						COUNT := COUNT +1;
					end if;
			end if;
		end process;
		--atribui a saida
		r <= add_product;
end rtl;
	