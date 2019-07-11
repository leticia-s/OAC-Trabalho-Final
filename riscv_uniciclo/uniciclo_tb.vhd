-- *  @autores: Letícia de Souza Soares
-- * 				 Fernanda Macedo de Sousa
--    @Matriculas: 15/0015178 - 17/0010058
-- * @disciplina: Organização e Arquitetura de Computadores
-- 
-- * Trabalho Projeto Risc-V Uniciclo
-- * Trabalho Final -  testbench  */
LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY uniciclo_tb IS
END uniciclo_tb;

ARCHITECTURE uniciclo_arch OF uniciclo_tb IS                                                
SIGNAL clk, reset, clk_mem : STD_LOGIC := '1';
SIGNAL pc_out, prox_ins, instrucao, outULA, memDados :std_logic_vector(31	downto	0);

COMPONENT uniciclo
	PORT (
		clk, reset, clk_mem : IN STD_LOGIC := '1';
		instrucao	 :out	std_logic_vector(31	downto	0);
		pc_out: out	std_logic_vector(31	downto	0);
		prox_ins: out	std_logic_vector(31	downto	0);
		 outULA, memDados :out	std_logic_vector(31	downto	0)
		
	);
END COMPONENT;
BEGIN
	i1 : uniciclo
	PORT MAP (
		clk => clk,
		reset => reset,
		clk_mem => clk_mem,
		instrucao => instrucao,
		pc_out => pc_out,
		prox_ins => prox_ins,
		outULA => outULA,
		memDados => memDados
	);
	
clockp: process
begin
	
	    clk <= not clk;
		 reset <= '0';
	    wait for 200 ps;
		 	
end process clockp;

memclock: process
begin
	
	    clk_mem <= not clk_mem;
	    wait for 10 ps; -- clock rapido

end process memclock;
 
                                     
END uniciclo_arch;
