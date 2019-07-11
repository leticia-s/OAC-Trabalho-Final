library	ieee;
use	ieee.std_logic_1164.all;
use	ieee.numeric_std.all;
use work.types_components.all;

ENTITY control is
	port(
		opcode : in std_logic_vector(6 downto 0);
		Branch : out std_logic;
		MemtoReg : out std_logic;
		MemWrite : out std_logic;
		RegWrite : out std_logic;
		ALUOp : out std_logic_vector(2 downto 0);
		ALUSrc : out std_logic;
		jalr: out std_logic;
		jump: out std_logic;
		lui: out std_logic
	);
END ENTITY;

ARCHITECTURE rtl of control is
	signal contr_Bula, mem2reg, RegWrit, MemWrit, Branc, pula_jalr, pula_j, u_lui: std_logic;
	signal controUla: std_logic_vector(2 downto 0);
BEGIN
	ALUOp <= controUla; AluSrc <= contr_Bula; MemtoReg <= mem2reg ; RegWrite <= RegWrit ; MEMWrite <= MemWrit;  
	Branch <= Branc; jump <= pula_j; jalr <= pula_jalr; lui <= u_lui;
	PROCESS(opcode, controUla, contr_Bula, mem2reg, RegWrit, MemWrit, Branc, pula_j, pula_jalr, u_lui)
	BEGIN		
		Branc <= '0'; pula_j <= '0'; pula_jalr <= '0'; u_lui <= '0';
		case opcode is
			when R_type =>       controUla <= "010"; contr_Bula <= '0'; mem2reg <= '0'; RegWrit <= '1'; MemWrit <= '0'; 
			when I_type_LOADS => controUla <= "000"; contr_Bula <= '1'; mem2reg <= '1'; RegWrit <= '1'; MemWrit <= '0';  
			when S_type =>       controUla <= "000"; contr_Bula <= '1'; mem2reg <= 'X'; RegWrit <= '0'; MemWrit <= '1';  
			when SB_type =>      controUla <= "001"; contr_Bula <= '0'; mem2reg <= 'X'; RegWrit <= '0'; MemWrit <= '0'; Branc <= '1'; 
			when U_type_AUIPC => controUla <= "000"; contr_Bula <= '1'; mem2reg <= '0'; RegWrit <= '1'; MemWrit <= '0';  
			when U_type_LUI =>   controUla <= "000"; contr_Bula <= '1'; mem2reg <= '0'; RegWrit <= '1'; MemWrit <= '0'; u_lui <= '1';  
			when I_type_OPERAC =>controUla <= "011"; contr_Bula <= '1'; mem2reg <= '0'; RegWrit <= '1'; MemWrit <= '0'; 
			when I_type_JALR =>  controUla <= "000";  contr_Bula <= '0'; mem2reg <= '0'; RegWrit <= '1'; MemWrit <= '0'; pula_jalr <= '1';
			when UJ_type =>      controUla <= "000";  contr_Bula <= '0'; mem2reg <= '0'; RegWrit <= '1'; MemWrit <= '0'; pula_j <= '1';
			when others => controUla <= (others	=>	'X'); contr_Bula <= 'X'; mem2reg <= 'X'; RegWrit <= 'X'; MemWrit <= 'X'; Branc <= 'X';
	
		end case;
	END PROCESS;

END ARCHITECTURE;