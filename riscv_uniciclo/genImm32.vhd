library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use work.types_components.all;
--entidade: definir conexões
entity genImm32 is  port (   
	instr : in std_logic_vector(31 downto 0);
	imm32 : out signed(31 downto 0)); 
end genImm32;
-- arquitetura
architecture behavioral of genImm32 is
	signal opcode : std_logic_vector(6 downto 0);
	signal saida : signed(31 downto 0) ;
	signal imm12_i : std_logic_vector(11 downto 0);
	signal imm12_s : std_logic_vector(11 downto 0); 
	signal imm13 : std_logic_vector(12 downto 0);
	signal imm20_u : std_logic_vector(19 downto 0) ;
	signal imm21 : std_logic_vector(20 downto 0);
	signal shamt : std_logic_vector(4 downto 0);
	signal instrs_shamt : std_logic_vector(2 downto 0);
begin
    opcode <= instr(6 downto 0);
    imm32 <= saida;
	 imm12_i <= instr(31 downto 20);
	 imm12_s <= instr(31 downto 25) & instr(11 downto 7);
	 imm13 <= instr(31) & instr(7) & instr(30 downto 25) & instr(11 downto 8) & '0';
	 imm20_u <= instr(31 downto 12);
	 imm21 <= instr(31) & instr(19 downto 12) & instr(20) & instr(30 downto 21) & '0';
	 shamt <= instr(24 downto 20); 
	 instrs_shamt <= instr(14 downto 12);
	 -- obs: lista sensitv do proces tem que ter TUDOOO que pode mudar de valor
    proc_imm: process (instr, saida, opcode, imm12_i, imm12_s, imm13, imm20_u, imm21, shamt, instrs_shamt) is
    begin
        case opcode is -- resize faz as extensoes de sinais
            when  R_type =>
                saida <= (others => '0'); 
            when  I_type_LOADS | I_type_JALR =>
                saida <= resize(signed(imm12_i), saida'length);
				when I_type_OPERAC =>
				    -- se for slli ou srli ou sra
					 case instrs_shamt is
						when "001" => saida <= resize(signed(shamt), saida'length);
						when "101" => saida <= resize(signed(shamt), saida'length);
						when others  =>
							saida <= resize(signed(imm12_i), saida'length);
					 end case;
            when  U_type_LUI | U_type_AUIPC =>
                saida <= shift_left(resize(signed(imm20_u), saida'length),12);  
            when  S_type =>
                saida <= resize(signed(imm12_s), saida'length); 
            when  SB_type =>
                saida <= resize(signed(imm13), saida'length);  
            when  UJ_type => 
                saida <= resize(signed(imm21), saida'length);  
            when others  =>
                saida <= (others => '0');
        end case;
    end process;
end architecture behavioral;