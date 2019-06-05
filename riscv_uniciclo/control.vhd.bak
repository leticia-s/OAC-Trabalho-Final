library	ieee;
use	ieee.std_logic_1164.all;
use	ieee.numeric_std.all;
use work.mips_pkg.all;

ENTITY control is
	port(
		opcode : in std_logic_vector(5 downto 0),

		RegDst : out std_logic;
		Jump : out std_logic;
		Brench : out std_logic;
		MemRead : out std_logic;
		MemtoReg : out std_logic;
		MemWrite : out std_logic;
		ALUOp : out std_logic_vector(1 downto 0);
		ALUSrc : out std_logic
	);
END ENTITY;

ARCHITECTURE rtl of control is
BEGIN
	PROCESS(opcode)
	BEGIN
		-- MUDAR OS "000000"s para os devidos opcodes

		RegDst <= '1' when opcode = "000000" else '0';
		Jump <= '1' when opcode = "000000" else '0';
		Brench <= '1' when opcode = "000000" else '0';
		MemRead <= '1' when opcode = "000000" else '0';
		MemtoReg <= '1' when opcode = "000000" else '0';
		MemWrite <= '1' when opcode = "000000" else '0';
		ALUSrc <= '1' when opcode = "000000" else '0';

		case opcode is
			when "000000" => ALUOp <= "00";
			when "000000" => ALUOp <= "01";
			when "000000" => ALUOp <= "10";
			others => ALUOp <= (others	=>	'X');	
		end case;
		-- ALUOp <= 
	END PROCESS;

END ARCHITECTURE;