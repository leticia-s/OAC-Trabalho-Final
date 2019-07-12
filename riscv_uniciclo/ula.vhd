library	ieee;
use	ieee.std_logic_1164.all;	
use ieee.std_logic_unsigned.all;
use	ieee.numeric_std.all;
use work.types_components.all;

entity ula is
port	(	
	opCula :	in std_logic_vector(3	downto	0);
	A,	B :	in	std_logic_vector(31	downto	0);
	ulaout:	out	std_logic_vector(31	downto	0);	
	zero :	out	std_logic);
end ula;

architecture behavioral of	ula is
	signal sub : std_logic_vector(31 downto 0);
	signal subu : std_logic_vector(31 downto 0);
	signal saida : std_logic_vector(31 downto 0);
begin
    sub <= A - B;
	 subu <= std_logic_vector(unsigned(A) - unsigned(B));
	 
    ulaout <= saida;
    proc_ula: process (A, B, opCula, saida, sub, subu) is
    begin
        case opCula is -- não há overflow em risc-V
            when  AND_OP =>
                saida <= A and B; 
            when  OR_OP =>
                saida <= A or B; 
            when  ADD_OP =>
                saida <= A + B;
            when  SUB_OP =>
                saida <= sub;  
            when  SLT_OP =>
                saida <= (0 => sub(31), others => '0'); -- bit 31 da sub
            when  SLTU_OP => 
					 saida <= (0 => subu(31), others => '0'); -- bit 31 da sub sem sinal 
				when  SGE_OP =>
					 saida <= (0 => not(sub(31)), others => '0'); -- bit 31 da sub: 1 se for maior ou igual, 0 se falso
				when  SGEU_OP =>
					 saida <= (0 => not(subu(31)), others => '0'); --bit 31 da sub sem sinal negado
				when  SEQ_OP =>
					 saida <= sub; -- igual, entao coloca zero ativo para BEQ
				when  SNE_OP =>
					 if (sub = X"00000000") then saida <= x"00000001"; else saida <= x"00000000"; end if; -- diferente, entao coloca zero inativo para BNE
            when  XOR_OP =>
                saida <= A xor B; 
            when  SLL_OP =>
                saida <= std_logic_vector(shift_left(unsigned(A), to_integer(unsigned(B)))); 
            when  SRL_OP =>
                saida <= std_logic_vector(shift_right(unsigned(A), to_integer(unsigned(B)))); 
            when  SRA_OP =>
                saida <= std_logic_vector(shift_right(signed(A), to_integer(unsigned(B)))); 
            when others  =>
                saida <= (others => '0');
        end case;
		  if (saida = X"00000000") then zero <= '1'; else zero <= '0'; end if;
    end process;
end	architecture	behavioral;