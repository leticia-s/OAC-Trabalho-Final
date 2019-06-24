library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
-- entidade
entity breg is  	
		generic (WSIZE : natural := 32);  	
		port ( 
 	 	clk, wren, rst 	 	: in std_logic;
 	 	radd1, radd2, wadd 	: in std_logic_vector(4 downto 0);
 	 	wdata  	 	 	: in std_logic_vector(WSIZE-1 downto 0); 
 	 	r1, r2 	: out std_logic_vector(WSIZE-1 downto 0));  	 
end breg; 	
-- arquitetura
architecture behavioral of breg is
-- array de 32 registradores com 32 bits cada
	type regs is array(WSIZE-1 downto 0) of std_logic_vector(WSIZE-1 downto 0);
-- todos reg iniciando em 0
	signal um_Reg : regs := ((others => (others => '0'))); -- inicializa o banco de registradores com tudo zero
begin   -- dois barramentos de leitura: r1 = registrador[radd1] e r2 = registrador[radd2];
        --um barramento de escrita: registrador[wadd] = wdata;
	-- leitura:
	proc_breg: process(radd1, radd2, clk, um_Reg, rst) is 
	begin
		r1 <= um_Reg(to_integer(unsigned(radd1)));  -- pega endereco do registrdor e retorna o dado que esta naquele endereco
		r2 <= um_Reg(to_integer(unsigned(radd2)));
	-- escrita: somente na transição positiva (0 para 1) do clock
		if(rising_edge(clk)) then
		-- /= diferente de 0,pois não escreve no registrador 0
			if ((wren = '1') and (to_integer(unsigned(wadd)) /= 0)) then -- quando a escrita estiver habilitada com 1
				um_Reg(to_integer(unsigned(wadd))) <= wdata; -- escreve dado que veio da memoria no registrador de destino
			end if;		
		end if;
		if (rst = '1') then
				for cont in 1 to 31 loop
				um_Reg(to_integer(to_unsigned(cont, 5))) <= X"00000000";
				end loop;
		end if;
	end process;
end architecture behavioral;