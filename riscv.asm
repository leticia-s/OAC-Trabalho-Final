.data
vetx: .word 15 63
# observacao: os botoes da DE2 estao ativos ('1') quando soltos. Quando pressionados
# passam para zero. Para alterar esse comportamento, o clock poderia ser utilizado
# negado. Assim, ao soltar o botao, teriamos a transicao de descida, que carrega
# os registradores internos das memorias
# os valores ao lado sao tomados da saida dos modulos:
# PC - saida do PC
# MI - saida do módulo de memoria (e nao de IF/ID)
# ULA - saida direta da ULA
# MD - saida direta da memoria de dados
.text                 # PC MI ULA MD

la s5, vetx 
lw t1, 0(s5) # 00000008 8c092000 00002000 0000000f ate 2047 limit max risc
lw t2, 4(s5) # 0000000c 8c0a2004 00002004 0000003f
add t0, t1, t2 # 00000010 012a5820 0000004e 00000000
sw t0, 8(s5) # 00000014 ac0b2008 00002008 0000004e
lw a0, 8(s5) # 00000018 8c042008 00002008 0000004e
ori t0, zero, 0xFF # 00000000 340800ff 000000ff 00000000
andi t0, t0, 0xF0 # 00000004 310800f0 000000f0 00000000
beq a0, a2, lww 
add t3, t1, t2 # 00000010 012a5820 0000004e 00000000
lww:
lw t1, 0(s5) # 00000008 8c092000 00002000 0000000f ate 2047 limit max risc
lw t2, 4(s5) # 0000000c 8c0a2004 00002004 0000003f
sw t3, 0(s5) # 00000014 ac0b2008 00002008 0000004e
lw a0, 0(s5) # 00000018 8c042008 00002008 0000004e
addi t4, zero, 2047 # 0000001c 200c70f0 000007ff 00000000
addi t5, zero, 0x00FF # 00000020 200d00ff 000000ff 00000000
and t6, t5, t4 # 00000024 01ac7024 000000f0 00000000
or a3, t5, t4 # 00000028 01ac7825 000070ff 00000000
xor a4, t5, t4 # 0000002c 01acc026 0000700f 00000000
slli t1, t5, 4 # 00000034 000d4900 00000ff0 00000000
lui t2, 0xFF00 # 00000038 3c0aff00 ff000000 00000000
srli t3, t2, 4 # 0000003c 000a5902 0ff00000 00000000
srai t4, t2, 4 # 00000040 000a6103 fff00000 00000000
slt s0, t0, t1 # 0000004c 0109802a 00000001 00000000
slt s1, t1, t0 # 00000050 0128882a 00000000 00000000
sltu s3, zero, t0 # 00000054 0008982b 00000001 00000000
sltu s4, t0, zero # 00000058 0100a02b 00000000 00000000
jal testasub # 0000005c 0c000019 00000000 00000000 => 64
jal next # 00000060 0800001c 00000000 00000000 => 70
testasub:
sub t3, t0, t1 # 00000064 01095822 fffffffe 00000000
jalr x1,ra,0 # 0000006c 03e00008 00000000 00000000 => 60
next:
addi t0, zero, -2 # 00000070 2108fffe fffffffe 00000000
beqsim:
addi t0, t0, 2 # 00000074 21080001 0000000* 00000000 * t0 = 0,2
beq t0, zero, beqsim # 00000078 1100fffe 00000000 00000000 => 74,78
bnesim:
addi t0, t0, -1 # 0000007c 2108ffff 0000000* 00000000 * t0 = 1, 0
bne t0, zero, bnesim # 00000080 1500fffe 00000000 00000000 => 7c,84
# Exceptions
lui s0, 0x8000 # 00000084 3c108000 80000000 00000000
lui s1, 0x8000 # 00000088 3c118000 80000000 00000000
# Overflow exception
add s4, s0, s1 # 00000090 0211a020 00000000 00000000 => 0x4180
.ktext 0x4180
exit: li a7, 10
ecall