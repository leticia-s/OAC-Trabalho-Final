library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

package	types_components	is
	-- Declaracao	de	componentes
	COMPONENT ula
		port	(	
			opCula :	in	std_logic_vector(3	downto	0);
			A,	B :	in	std_logic_vector(31	downto	0);	
			ulaout:	out	std_logic_vector(31	downto	0);	
			zero :	out	std_logic	
			);
	END COMPONENT;
	
	COMPONENT genImm32
    PORT (
    instr : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    imm32 : OUT signed(31 DOWNTO 0)
	 );
	END COMPONENT;
	
	component	c_ula 
		port(
		bit5funct7 : in std_logic;
		funct3 : in std_logic_vector(2 downto 0);
		ulaOp  : in std_logic_vector(2 downto 0);
		ctr_ula : out std_logic_vector(3	downto	0);
		sel_shamt :out std_logic
		);
	end	component;
	
	COMPONENT xreg
		port ( 
 	 	clk, wren, rst 	 	: in std_logic;
 	 	rs1, rs2, rd 	: in std_logic_vector(4 downto 0); 
 	 	data  	 	 	: in std_logic_vector(31 downto 0); 
 	 	ro1, ro2 	: out std_logic_vector(31 downto 0)); 
	END COMPONENT;
	
	component somador is 
		generic	(	WSIZE	:	natural	:=	32);
		port(
			A, B : in std_logic_vector ((WSIZE - 1) downto 0);

			result : out std_logic_vector ((WSIZE - 1) downto 0)
		);
	end component;
	
	component pc is
		generic	(	WSIZE	:	natural	:=	32);
		port(
			clk, reset : in std_logic;
			address_in : in std_logic_vector ((WSIZE - 1) downto 0);

			address_out : out std_logic_vector ((WSIZE - 1) downto 0)
		);
	end component;
	
	component multiplexador_32_bits is
		port(
			selector : in std_logic;
			opt0, opt1 : in std_logic_vector (31 downto 0);
			result : out std_logic_vector (31 downto 0)
		);
	end component;

	component memory_instruction is
		port(
			address	: in std_logic_vector(7 downto 0);
			clock		: in std_logic;
			q		   : out std_logic_vector(31 downto 0)
		);
	end component;

	component control is
		port(
			opcode : in std_logic_vector(6 downto 0);
			Branch : out std_logic;
			MemtoReg : out std_logic;
			MemWrite : out std_logic;
			RegWrite : out std_logic;
			ALUOp : out std_logic_vector(2 downto 0);
			ALUSrc : out std_logic;
			jalr: out std_logic;
			jump: out std_logic
		);
	end component;
	
	component data_memory is
		port(
			address	: in std_logic_vector(7 downto 0);
			clock		: in std_logic;
			data		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			wren		: IN STD_LOGIC ;
			q		   : out std_logic_vector(31 downto 0)
		);
	end component;
	
	-- Controle	ULA
 	constant ADD_OP :	std_logic_vector(3	downto	0)	:=	"0000";	-- 0
   constant SUB_OP :	std_logic_vector(3	downto	0)	:=	"0001";	-- 1
   constant AND_OP :	std_logic_vector(3	downto	0)	:=	"0010";	-- 2
   constant OR_OP :	std_logic_vector(3	downto	0)	:=	"0011";	-- 3
   constant XOR_OP :	std_logic_vector(3	downto	0)	:=	"0100";	-- 4
   constant SLL_OP :	std_logic_vector(3	downto	0)	:=	"0101";	-- 5
	constant SRL_OP :	std_logic_vector(3	downto	0)	:=	"0110";	-- 6
	constant SRA_OP :	std_logic_vector(3	downto	0)	:=	"0111";	-- 7
   constant SLT_OP :	std_logic_vector(3	downto	0)	:=	"1000";	-- 8
   constant SLTU_OP:	std_logic_vector(3	downto	0)	:=	"1001";	-- 9 
   constant SGE_OP :	std_logic_vector(3	downto	0)	:=	"1010";  -- 10
   constant SGEU_OP:	std_logic_vector(3	downto	0)	:=	"1011";  -- 11
   constant SEQ_OP :	std_logic_vector(3	downto	0)	:=	"1100";  -- 12
   constant SNE_OP :	std_logic_vector(3	downto	0)	:=	"1101";  -- 13 */

	constant R_type	    :	std_logic_vector(6	downto	0):=	"0110011";
	constant I_type_LOADS :	std_logic_vector(6	downto	0):=	"0000011";
	constant I_type_OPERAC:	std_logic_vector(6	downto	0):=	"0010011";
	constant I_type_JALR  :	std_logic_vector(6	downto	0):=	"1100111";
	constant U_type_LUI   :	std_logic_vector(6	downto	0):=	"0110111";
	constant U_type_AUIPC :	std_logic_vector(6	downto	0):=	"0010111";
	constant S_type       :	std_logic_vector(6	downto	0):=	"0100011";
	constant SB_type      :	std_logic_vector(6	downto	0):=	"1100011";
	constant UJ_type      :	std_logic_vector(6	downto	0):=	"1101111";

end types_components;