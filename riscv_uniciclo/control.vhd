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
		ALUOp : out std_logic_vector(1 downto 0);
		ALUSrc : out std_logic
	);
END ENTITY;

ARCHITECTURE rtl of control is
	signal contr_Bula, mem2reg, RegWrit, MemRea, MemWrit, Branc: std_logic;
	signal controUla: std_logic_vector(1 downto 0);
BEGIN
	ALUOp <= controUla; AluSrc <= contr_Bula; MemtoReg <= mem2reg ; RegWrite <= RegWrit ; MEMWrite <= MemWrit; Branch <= Branc;
	PROCESS(opcode, controUla, contr_Bula, mem2reg, RegWrit, MemRea, MemWrit, Branc)
	BEGIN		
		case opcode is
			when R_type =>       controUla <= "10"; contr_Bula <= '0'; mem2reg <= '0'; RegWrit <= '1'; MemWrit <= '0'; Branc <= '0'; 
			when I_type_LOADS => controUla <= "00"; contr_Bula <= '1'; mem2reg <= '1'; RegWrit <= '1'; MemWrit <= '0'; Branc <= '0'; 
			when S_type =>       controUla <= "00"; contr_Bula <= '1'; mem2reg <= 'X'; RegWrit <= '0'; MemWrit <= '1'; Branc <= '0'; 
			when SB_type =>      controUla <= "01"; contr_Bula <= '0'; mem2reg <= 'X'; RegWrit <= '0'; MemWrit <= '0'; Branc <= '1'; 
			when U_type_AUIPC => controUla <= "00"; contr_Bula <= '1'; mem2reg <= '0'; RegWrit <= '1'; MemWrit <= '0'; Branc <= '0'; 
			when U_type_LUI =>   controUla <= "00"; contr_Bula <= '1'; mem2reg <= '0'; RegWrit <= '1'; MemWrit <= '0'; Branc <= '0'; 
			--problema addi e srai(shamt)
			when I_type_OPERAC =>controUla <= "10"; contr_Bula <= '1'; mem2reg <= '0'; RegWrit <= '1'; MemRea <= '0'; MemWrit <= '0'; Branc <= '0';
		--	when I_type_JALR =>  controUla <= "00";  contr_Bula <= '0'; mem2reg <= '0'; RegWrit <= '1'; MemRea <= '0'; MemWrit <= '0'; Branc <= '0';
		--	when UJ_type =>      controUla <= "00";  contr_Bula <= '0'; mem2reg <= '0'; RegWrit <= '1'; MemRea <= '0'; MemWrit <= '0'; Branc <= '0';
			when others => controUla <= (others	=>	'X'); contr_Bula <= 'X'; mem2reg <= 'X'; RegWrit <= 'X'; MemRea <= 'X'; MemWrit <= 'X'; Branc <= 'X';
	
		end case;
	END PROCESS;

END ARCHITECTURE;