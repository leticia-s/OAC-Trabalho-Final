-- *  @autores: Letícia de Souza Soares
-- * 				 Fernanda Macedo de Sousa
--    @Matriculas: 15/0015178 - 17/0010058
-- * @disciplina: Organização e Arquitetura de Computadores
-- 
-- * Trabalho Projeto Risc-V Uniciclo

-- os valores ao lado sao tomados da saida dos modulos:
-- PC - saida do PC
-- MI - saida do modulo de memoria (e nao de IF/ID)
-- ULA - saida direta da ULA
-- MD - saida direta da memoria de dados

-- * Trabalho Final -  uniciclo  */
library	ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use work.types_components.all;

entity uniciclo is
	port(
		reset : in std_logic := '1';
		clk : in std_logic := '1';
		clk_mem : in std_logic := '1';								-- clock da memoria
		instrucao	 :out	std_logic_vector(31	downto	0);
		outULA, memDados :out	std_logic_vector(31	downto	0);
		prox_ins: out	std_logic_vector(31	downto	0)
	);

end entity;

architecture rtl of uniciclo is
	SIGNAL res_somapc4, res_somaImmpc, result_mux_branch, readMemoryData : std_logic_vector(31 downto 0);
	SIGNAL address_out_pc, mem_ins_out: std_logic_vector(31 downto 0);
	SIGNAL readData1, wdata, readData2 : std_logic_vector(31 downto 0);
	SIGNAL imm32 : signed(31 DOWNTO 0);
	-- bazu_or_banzu = branch_and_zero_ula OR BNE_and_not_zero_ula
	SIGNAL branch_and_zero_ula, BNE_and_not_zero_ula, bazu_or_banzu : std_logic;
	-- saida controle ula
	SIGNAL out_c_ula : std_logic_vector(3	downto	0);
   -- ula
	SIGNAL zero : std_logic;
   SIGNAL res_mux_inB_ula ,out_ula : std_logic_vector(31 downto 0);	
	-- control signals
	SIGNAL ALUSrc, RegWrite, Branch, MemtoReg, MemWrite : std_logic;
	SIGNAL ALUOp : std_logic_vector(1 downto 0);
	
begin
	imm : genImm32 PORT MAP ( instr => mem_ins_out , imm32 => imm32 ); -- instancia um gerador de imediatos, a entrada está conectada com a saida da memoria de instrucao
	
   contr_ula: c_ula PORT MAP ( bit5funct7 => mem_ins_out(30), -- controlador da ULA
					funct3 => mem_ins_out(14 downto 12), -- o bit 5 do funct 7 (unico que difere nesse campo) é o bit 30 da instrucao que sai da memória 
					ulaOp  => ALUOp,
					ctr_ula => out_c_ula);
	
	alu : ula PORT MAP ( opCula => out_c_ula, A => readData1, 
	B => res_mux_inB_ula, ulaout => out_ula, zero => zero );
	
	mux_inB_ula : multiplexador_32_bits port map( -- multiplexador que define qual a entrada b da ULA (se imediato ou registrador)
		opt0 => readData2,
		opt1 => std_logic_vector(imm32),
		selector => AluSrc,
		result => res_mux_inB_ula);
	
	b_regis: xreg port MAP (clk => clk, -- Banco de Registradores
				--escrita
				wren => RegWrite, -- habilita escrita
				rd => mem_ins_out(11 downto 7), --endereço do reg para escrita
				data => wdata, --valor para escrever no rd
				--leitura
				rs1 => mem_ins_out(19 downto 15), --  endereço do reg a ser lido em ro1
	         rs2 => mem_ins_out(24 downto 20), -- endereço do reg a ser lido em ro2
				ro1 => readData1, -- saída ler reg endereçado por rs1
				ro2 => readData2,-- saída ler reg endereçado por rs2
				--reset
				rst => reset); -- sinal de reset, zera todos regs
	
	PC_P : pc port map( -- instancia do PC
		clk => clk,
		reset => reset,
		address_in => result_mux_branch,
		address_out => address_out_pc
	);
	
	sum_pc_4: somador port map ( -- instancia do somador para o PC
		A => address_out_pc,
		B => X"00000004",
		result => res_somapc4
	);
	
	mi : memory_instruction port map( -- instancia da memoria de instrucoes
    	address		 => address_out_pc(9 downto 2), -- 7 bits 
		q           => mem_ins_out, 
		clock       => clk_mem
	);
	
	ctrl : control port map ( -- nao tem mem MemRead porque a memoria vai sempre ler com clk_mem 
		opcode => mem_ins_out(6 downto 0),
		Branch => Branch,
		MemtoReg => MemtoReg,
		MemWrite => MemWrite,
		ALUOp => ALUOp,
		RegWrite => RegWrite,
		ALUSrc => ALUSrc
	);
	
	mux_md_breg : multiplexador_32_bits port map(
		opt0 => out_ula,
		opt1 => readMemoryData,
		selector => MemtoReg,
		result => wdata 
	);

	sum_imm_pc: somador port map ( -- instancia do somador para a soma do imediato com o PC
		A => address_out_pc,
		B => std_logic_vector(imm32), --não tem shift 1 
		result => res_somaImmpc
	);
	
	md : data_memory port map(
		address    => out_ula(9 downto 2),
	   q          => readMemoryData,                      
	   clock      => clk_mem,  -- nao tem mem MemRead porque a memoria vai sempre ler com clk_mem, dito clock rapido 
	   data       => readData2,
	   wren       => MemWrite
	);

	mux_branch : multiplexador_32_bits port map(
		opt0 => res_somapc4,
		opt1 => res_somaImmpc,
		selector => BAZu_or_banzu,
		result => result_mux_branch
	);
	
	branch_and_zero_ula <= Branch and zero; -- beq
	BNE_and_not_zero_ula <= Branch and not(zero); --bne
	BAZu_or_banzu <= branch_and_zero_ula or BNE_and_not_zero_ula;
	
	instrucao <= mem_ins_out;
	prox_ins <= result_mux_branch;
	memDados <= readMemoryData;
	outULA <= out_ula;

end architecture;


