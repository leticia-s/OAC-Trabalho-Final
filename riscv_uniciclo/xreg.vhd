-- *    @file: XREG.vhd
--*     @author: Letícia de Souza Soares
--*  @Matricula: 15/0015178 
--* @disciplina: Organização e Arquitetura de Computadores
--*
--* Trabalho Projeto do Banco de Registradores do RISC-V 
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
-- entidade
entity xreg is  	
		generic (WSIZE : natural := 32);  	
		port ( 
 	 	clk, wren, rst 	 	: in std_logic;
 	 	rs1, rs2, rd 	: in std_logic_vector(4 downto 0); 
 	 	data  	 	 	: in std_logic_vector(WSIZE-1 downto 0); 
 	 	ro1, ro2 	: out std_logic_vector(WSIZE-1 downto 0));  	 
end xreg; 	
-- arquiteturaXREG
architecture behavioral of xreg is
-- array de 32 registradores com 32 bits cada
	type regs is array(WSIZE-1 downto 0) of std_logic_vector(WSIZE-1 downto 0);
-- todos reg iniciando em 0
	signal um_Reg : regs := ((others => (others => '0'))); -- inicializa o banco de registradores com tudo zero
begin   -- dois barramentos de leitura: ro1 = registrador[rs1] e ro2 = registrador[rs2];
        --um barramento de escrita: registrador[rd] = data;
	-- leitura:
	proc_breg: process(rs1, rs2, clk, um_Reg, rst) is 
	begin
		ro1 <= um_Reg(to_integer(unsigned(rs1)));
		ro2 <= um_Reg(to_integer(unsigned(rs2)));
	-- escrita: somente na transição positiva (0 para 1) do clock
		if(rising_edge(clk)) then
		-- /= diferente de 0,pois não escreve no registrador 0
			if ((wren = '1') and (to_integer(unsigned(rd)) /= 0)) then
				um_Reg(to_integer(unsigned(rd))) <= data;
			end if;		
		end if;
		if (rst = '1') then
				for cont in 1 to 31 loop
				um_Reg(to_integer(to_unsigned(cont, 5))) <= X"00000000";
				end loop;
		end if;
	end process;
end architecture behavioral;