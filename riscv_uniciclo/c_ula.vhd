library	ieee;
use	ieee.std_logic_1164.all;
use	ieee.numeric_std.all;
use work.types_components.all;

entity c_ula is -- Controlador da ULA (pega os campos functs pra definir qual instrucao a ULA vai fazer)
	port(
	  bit5funct7 : in std_logic;
	  funct3 : in std_logic_vector(2 downto 0);
	  ulaOp  : in std_logic_vector(2 downto 0);
	  ctr_ula : out std_logic_vector(3	downto	0);
	  sel_shamt :out std_logic
	  );
end c_ula;

architecture rtl of c_ula is
signal saida : std_logic_vector(3	downto	0);

begin
ctr_ula <= saida;

process (bit5funct7, funct3, ulaOp, saida)
begin
  sel_shamt <= '0';
  
  case ulaOp is
	when "000" => -- acesso à memória (lw, sw) [usa somador para endereco (reg + imm)] 
		saida <= ADD_OP;
	when "001" => -- branchs
		case funct3 is
			when "000" => saida <= SEQ_OP; --beq
			when "001" => saida <= SNE_OP; --bne
			when "100" => saida <= SGE_OP; --blt -> sge, e nao slt pois branch verifica zero da ula
			when "101" => saida <= SLT_OP; --bge -> slt
			when "110" => saida <= SGEU_OP; --bltu 
			when "111" => saida <= SLTU_OP; --bgeu
			when others  =>
                saida <= (others => 'X');
		end case;
	when "010" => -- lógico-aritméticas ([add, sub, and, or, slt])
		case funct3 is
			when "000" => if (bit5funct7 ='0') -- verifica unico bit do funct 7 que difere (5)
							then saida <= ADD_OP;
							else saida <= SUB_OP;
							end if;
			when "001" => saida <= SLL_OP;
			when "010" => saida <= SLT_OP;
			when "011" => saida <= SLTU_OP;
			when "100" => saida <= XOR_OP;
			when "101" =>  if (bit5funct7 ='0')
							then saida <= SRL_OP;
							else saida <= SRA_OP;
							end if;
		   
			when "110" => saida <= OR_OP;
			when "111" => saida <= AND_OP;
			when others  =>
                saida <= (others => 'X');
		end case;
	when "011" => --  TIPO I => lógico-aritméticas ([add, sub, and, or, slt])
		case funct3 is
			when "000" => saida <= ADD_OP;
			when "001" => saida <= SLL_OP; sel_shamt <= '1';
			when "010" => saida <= SLT_OP;
			when "011" => saida <= SLTU_OP;
			when "100" => saida <= XOR_OP;
			when "101" =>  if (bit5funct7 ='0')
							then saida <= SRL_OP; sel_shamt <= '1';
							else saida <= SRA_OP; sel_shamt <= '1';
							end if;
			when "110" => saida <= OR_OP;
			when "111" => saida <= AND_OP;
			when others  =>
                saida <= (others => 'X');
		end case;
	when others  =>
      saida <= (others => 'X');
	end case;
end process;
end rtl;