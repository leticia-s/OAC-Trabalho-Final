library	ieee;
use	ieee.std_logic_1164.all;
use	ieee.numeric_std.all;
use work.types_components.all;

ENTITY pc is
	generic	(	WSIZE	:	natural	:=	32);
	port(
		clk, reset : in std_logic;
		address_in : in std_logic_vector ((WSIZE - 1) downto 0); -- entrada do PC

		address_out : out std_logic_vector ((WSIZE - 1) downto 0) -- saída do PC
	);
END ENTITY;

ARCHITECTURE rtl of pc is

BEGIN
	PROCESS(clk, reset)
	BEGIN
		if (reset = '1') then address_out <= X"00000000"; -- para o caso de zerar o PC
		else
			if(rising_edge(clk)) then -- na subida do clock escreve a instrução (de 0 pra 1)
				address_out <= address_in;
			end if;
		end if;
	END PROCESS;

END ARCHITECTURE;