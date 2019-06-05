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
	signal tmp : std_logic_vector(31 downto 0);
	signal saida : std_logic_vector(31 downto 0);
begin
    tmp <= A - B;
    ulaout <= saida;
    proc_ula: process (A, B, opCula, saida, tmp) is
    begin
        if (saida = X"00000000") then zero <= '1'; else zero <= '0'; end if;
        case opCula is -- não há overflow em risc-V
            when  AND_OP =>
                saida <= A and B; 
            when  OR_OP =>
                saida <= A or B; 
            when  ADD_OP =>
                saida <= A + B;
            when  SUB_OP =>
                saida <= tmp;  
            when  SLT_OP =>
                saida <= (0 => tmp(31), others => '0'); 
            when  SLTU_OP =>
                if (unsigned(A) < unsigned(B))
                    then saida <= X"00000001";
                    else saida <= X"00000000";
                end if;
            --when  SGE_OP 
				--when  SGEU_OP
				--when  SEQ_OP 
				--when  SNE_OP 
            when  XOR_OP =>
                saida <= A xor B; 
            when  SLL_OP =>
                saida <= std_logic_vector(shift_left(unsigned(B), to_integer(unsigned(A)))); 
            when  SRL_OP =>
                saida <= std_logic_vector(shift_right(unsigned(B), to_integer(unsigned(A)))); 
            when  SRA_OP =>
                saida <= std_logic_vector(shift_right(signed(B), to_integer(unsigned(A)))); 

            when others  =>
                saida <= (others => '0');
        end case;
    end process;
end	architecture	behavioral;