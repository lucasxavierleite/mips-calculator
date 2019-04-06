	.data
menu: .asciiz "1. Soma\n2.Subtracao\n3.Multiplicacao\n4.Divisao\n5.Potencia\n6.Raiz Quadrada\n7.Tabuada de X\n8.IMC\n9.Fatorial\n10.Fibonacci\n11.Encerrar\n"
marker: .asciiz "\n X \n" 

barra_n: .asciiz "\n"
soma_intr: .asciiz "Insira dois numeros:\n"
one_insert: .asciiz "Insira um numero:\n"
result_msg: .asciiz "Resultado: "
erro_mp: .asciiz "Erro, numero muito grande\n"
divisor_1: .asciiz "Insira o numero a ser dividido:\n"
divisor_2: .asciiz "Insira o divisor:\n"
potencia_msg: .asciiz "Insira a base e o expoente, respectivamente:\n"
overflow_msg: .asciiz "O resultado obtido ultrapassa o limite. Utilize numeros menores\n"

massa_msg: .asciiz "Insira a massa:\n"
altura_msg: .asciiz "Insira a altura:\n"
imc_msg: .asciiz "IMC: "

quociente: .asciiz "Quociente:"
resto: .asciiz "Resto:"

tab1: .asciiz "\nNumero: "
tab2: .asciiz "A tabuada do "
tab3: .asciiz " e: "
tab4: .asciiz "Erro: Numero nao esta entre 1 e 10."
tab5: .asciiz ", "
tab6: .asciiz ".\n"

	.text
title:
	li $v0, 4
	la $a0, menu
	syscall

	li $v0, 5  # read the first number 
	syscall

	move $t0, $v0 # $t0 = Selector

	# t1 = Filter

jumpers: 
	li $t1, 1
	beq  $t0, $t1, soma #t0 = 1
	li $t1, 2
	beq $t0, $t1, subtracao #t0 = 2
	li $t1, 3
	beq $t0, $t1, multiplicacao #t0 = 3
	li $t1, 4
	beq $t0, $t1, divisao #t0 = 4
	li $t1, 5
	beq $t0, $t1, potencia #t0 = 5
	li $t1, 6
	beq $t0, $t1, raiz #t0 = 6
	li $t1, 7
	beq $t0, $t1, tabuada #t0 = 7
	li $t1, 8
	beq $t0, $t1, imc #t0 = 8
	li $t1, 9
	beq $t0, $t1, fatorial #t0 = 9
	li $t1, 10
	beq $t0, $t1, fibonacci #t0 = 10
	li $t1, 11
	beq $t0, $t1, end #t0 = 11

	j title

 
	#*****SOMA*****#  

soma:
	li $v0, 4
	la $a0, soma_intr
	syscall

	li $v0, 5
	syscall
	move $t2, $v0

	li $v0, 5
	syscall

	move $t3, $v0
	add $t2, $t2, $t3

	li $v0, 4
	la $a0, result_msg
	syscall

	li $v0, 1
	add $a0, $t2, $zero
	syscall

	li $v0, 4
	la $a0, barra_n
	syscall

	j title


	#*****SUBTRACAO*****#  

subtracao:

	li $v0, 4
	la $a0, soma_intr
	syscall

	li $v0, 5
	syscall
	move $t2, $v0

	li $v0, 5
	syscall
	move $t3, $v0
	sub $t2, $t2,$t3

	li $v0, 4
	la $a0, result_msg
	syscall

	li $v0, 1
	add $a0, $t2, $zero
	syscall

	li $v0, 4
	la $a0, barra_n
	syscall

	j title

 
	#*****MULTIPLICACAO*****#  

#Com high e low? (responde erro caso overload)
multiplicacao:
	li $v0, 5
	syscall
	move $t2, $v0

	li $v0, 5
	syscall
	move $t3, $v0

	mult $t3,$t2

	mflo $t4

	mfhi $t5

	bgt $t5, $zero, error_mp

	li $v0,1
	addi $a0, $t4, 0
	syscall

	j title

	error_mp:

	li $v0, 4
	la $v0, erro_mp
	syscall
	j title


	#*****DIVISAO*****#  

#divisao mostrara o valor do quociente e do resto;
divisao:
	li $v0, 4
	la $a0, divisor_1
	syscall

	li $v0, 5
	syscall
	move $t0, $v0

	li $v0, 4
	la $a0, divisor_2
	syscall

	li $v0, 5
	syscall
	move $t1, $v0

	div $t0, $t1

	mflo $t2

	mfhi $t3

	li $v0, 4
	la $a0, quociente
	syscall

	li $v0, 1
	addi $a0, $t2, 0
	syscall

	li $v0, 4
	la $a0, barra_n
	syscall

	li $v0, 4
	la $a0, resto
	syscall

	li $v0, 1
	addi $a0, $t3, 0
	syscall

	li $v0, 4
	la $a0, barra_n
	syscall

	j title


	#*****POTENCIA*****#  

potencia:
	# mensagem de entrada de parâmetros
	li $v0, 4
	la $a0, potencia_msg
	syscall

	# lê o primeiro parâmetro
	li $v0, 6
	syscall
	mov.s $f1, $f0 # $f1 = base

	# lê o segundo parâmetro
	li $v0, 5
	syscall
	move $s0, $v0 # $s0 = expoente
	
	mov.s $f2, $f1 # $f2 = base ($f2 = valor acumulado)
	li $s1, 1 # $s1 = contador

potencia_loop:
	beq $s1, $s0, potencia_fim # até contador = expoente
	mov.s $f3, $f2 # $t1 = $s2 (salva o valor para detecção de erro)
	mul.s $f2, $f2, $f1 # valor acumulado *= base
	addi $s1, $s1, 1 # contador++

	# verifica overflow
	li $t0, 0x7f800000 # + infinito
	mtc1 $t0, $f4 # carrega o valor
	c.eq.s $f2, $f4 # compara com o resultado obtido
	bc1t overflow # em caso de overflow, pula para a mensagem de erro
	
	j potencia_loop # repete

potencia_fim:
	# mensagem de resultado
	li $v0, 4
	la $a0, result_msg
	syscall

	# resultado
	li $v0, 2
	mov.s $f12, $f2
	syscall

	# \n
	li $v0, 4
	la $a0, barra_n
	syscall

	# retorna ao menu
	j title

 
	#*****RAIZ*****#  

#Argumentos de entrada = $a0, saida = $t0 com a raiz aproximada em inteiro, $t2 = o numero que veio em $a0
raiz:
	li $v0, 4
	la $a0, one_insert
	syscall

	li $v0, 5
	syscall
	move $a0, $v0

	jal sqrt

	li $v0, 1
	move $a0, $t0
	syscall

	li $v0, 4
	la $a0, barra_n
	syscall

	j title


	#*****TABUADA*****#  

tabuada:
	li $v0, 4 # Prints output to request input
	la $a0, tab1
	syscall

	li $v0, 5 # Reads integer input
	syscall
	move $t0, $v0 # Copies $v0 to $t0 - in this case makes $t0 become the int that was just read

	addi $t1, $zero, 1 # Error handling: Branches if input is more than 10 or less than 1
	blt $t0, $t1, tabuada_error
	addi $t1, $zero, 10
	bgt $t0, $t1, tabuada_error

	li $v0, 4 # Prints first bit of output (tab2, input, tab3)
	la $a0, tab2
	syscall

	li $v0, 1
	move $a0, $t0
	syscall

	li $v0, 4
	la $a0, tab3
	syscall

	add $t1, $zero, $zero
	addi $t3, $zero, 10

tabuada_loop:
	addi $t1, $t1, 1 # Adds 1 before multiplying and printing
	mul $t2, $t0, $t1 # Multiplies

	li $v0, 1
	move $a0, $t2
	syscall

	bne $t1, $t3, tabuada_loopy

	li $v0, 4
	la $a0, tab6
	syscall

	j title # Returns to menu

tabuada_loopy: # For maintaining output syntax
	li $v0, 4
	la $a0, tab5
	syscall

	j tabuada_loop

tabuada_error: # Error function
	li $v0, 4
	la $a0, tab4
	syscall

	j title # Returns to menu
	
	#*****IMC*****#  
	
#Recebe como parâmetros a massa da pessoa e sua altura, retornando o seu IMC
imc:
	li $v0, 4
	la $a0, massa_msg
	syscall
	
	li $v0, 6
	syscall
	mov.s $f1, $f0
	
	li $v0, 4
	la $a0, altura_msg
	syscall
	
	li $v0, 6
	syscall
	mov.s $f2, $f0
	
	mul.s $f3, $f2, $f2
	
	div.s $f4, $f1, $f3
	
	li $v0, 4
	la $a0, imc_msg
	syscall
	
	li $v0, 2
	mov.s $f12, $f4
	syscall
	
	li $v0, 4
	la $a0, barra_n
	syscall
	
	j title

	#*****FATORIAL*****#  

fatorial:
	# mensagem de entrada de parâmetro
	li $v0, 4
	la $a0, one_insert
	syscall

	# leitura do inteiro
	li $v0, 5
	syscall

	# verifica se ocorrerá overflow (>= 13)
	bge $v0, 13, overflow

	# chama a função que calcula o fatorial
	move $a0, $v0
	jal fat

	# salva o valor retornado
	move $t0, $v0

	# mensagem de resultado
	li $v0, 4
	la $a0, result_msg
	syscall

	# resultado
	li $v0, 1
	move $a0, $t0
	syscall

	# \n
	li $v0, 4
	la $a0, barra_n
	syscall

	j title

# caso ocorra overflow
overflow:
	# imprime mensagem de erro (overflow) e retorna ao menu
	li $v0, 4
	la $a0, overflow_msg
	syscall
	j title

	#*****FIBONACCI*****#  

fibonacci:
	# código
	j title
	
	#*****FIM*****#  
	
end:
	li $v0, 10
	syscall


#Essa funcao faz a raiz quadrada de um numero dado aproximada em inteiro
sqrt:
	li $t0, 0
	li $t1, 0
	add $t2, $zero, $a0

loop_sqrt:
	bgt $t1, $t2, end_sqrt #se $t0 X $t0 > $t2, entao o numero que queremos era o anterior ao atual
	addi $t0, $t0, 1 #checamos o proximo numero
	mul $t1, $t0, $t0 #colocamos em $t1 o valor desse numero ao quadrado
	j loop_sqrt

end_sqrt: #agora que sabemos que numero que é o desejado, podemos fazer $t0 -1, tendo as respostas que quermos
	addi $t0, $t0, -1
	jr $ra

#*** fat ***********************************************************************
#
#  Calcula (de forma recursiva) o valor do fatorial do inteiro em $a0 e retorna
#  em $v0
#
#  Parâmetros:
#     $a0 : número cujo fatorial deseja-se calcular
#
#  Retorno:
#     $v0 : fatorial do valor em $a0
#

fat:
	addi $sp, $sp, -8 # move o ponteiro da pilha
	sw $a0, 0($sp) # guarda o conteúdo de $a0
	sw $ra, 4($sp) # guarda o conteúdo de $ra

	beqz $a0, fat_retorna_1 # verifica condição de parada
	addi $a0, $a0, -1 # carrega em $a0 o elemento anterior
	jal fat # chamada recursiva
	addi $a0, $a0, 1 # retorna o valor original
	mul $v0, $v0, $a0 # realiza a multiplicação
	j fat_fim # pula para o fim (ignora fat_retorna_1)

fat_retorna_1:
	li $v0, 1 # retorna 1 - condição de parada

fat_fim:
	lw $ra, 4($sp) # restaura o valor de $ra
	lw $a0, 0($sp) # restauro o valor de $a0
	addi $sp, $sp, 8 # move de volta o ponteiro da pilha
	jr $ra # retorna

#*******************************************************************************
