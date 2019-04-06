	.data
menu: .asciiz "1. Soma\n2.Subtraçao\n3.Multiplicação\n4.Divisão\n5.Potência\n6.Raiz Quadrada\n7.Tabuada de X\n8.IMC\n9.Fatorial\n10.Fibonacci\n11.Encerrar\n"
marker: .asciiz "\n X \n" 

barra_n: .asciiz "\n"
insiradois_msg: .asciiz "Insira dois números: \n"
insiraum_msg: .asciiz "Insira um número: \n"
resultado_msg: .asciiz "Resultado: "
erro_msg: .asciiz "Erro, numero muito grande\n"
divisor1_msg: .asciiz "Insira o numero a ser dividido:\n"
divisor2_msg: .asciiz "Insira o divisor:\n"
potencia_msg: .asciiz "Insira a base e o expoente, respectivamente:\n"
overflow_msg: .asciiz "O resultado obtido ultrapassa o limite. Utilize numeros menores\n"

massa_msg: .asciiz "Insira a massa:\n"
altura_msg: .asciiz "Insira a altura:\n"
imc_msg: .asciiz "IMC: "

quociente_msg: .asciiz "Quociente: "
resto_msg: .asciiz "Resto: "

tabnum_msg: .asciiz "\nNúmero: "
tab2_msg: .asciiz "A tabuada do "
tab3_msg: .asciiz " é: "
taberro_msg: .asciiz "Erro: Número não está entre 1 e 10."
tab5_msg: .asciiz ", "
tab6_msg: .asciiz ".\n"

	.text
title:
	li $v0, 4
	la $a0, menu
	syscall

	li $v0, 5  # Lê a opção do usuário	 
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

# Soma dois números de entrada
soma:
	li $v0, 4
	la $a0, insiradois_msg
	syscall

	li $v0, 5	# Lê o primeiro número que o usuário quer somar
	syscall
	move $t2, $v0

	li $v0, 5	# Lê o segundo número que o usuário quer somar
	syscall

	move $t3, $v0
	add $t2, $t2, $t3	# Soma os dois números

	li $v0, 4
	la $a0, resultado_msg
	syscall

	li $v0, 1		# Printa o resultado
	add $a0, $t2, $zero
	syscall

	li $v0, 4
	la $a0, barra_n
	syscall

	j title			# Volta pro menu


	#*****SUBTRACAO*****#  

# Subtrai dois números de entrada
subtracao:

	li $v0, 4
	la $a0, insiradois_msg
	syscall

	li $v0, 5		# Lê o primeiro número que o usuário quer somar
	syscall
	move $t2, $v0

	li $v0, 5		# Lê o segundo número que o usuário quer somar
	syscall
	move $t3, $v0
	sub $t2, $t2,$t3	# Subtrai os dois números

	li $v0, 4
	la $a0, resultado_msg
	syscall

	li $v0, 1		# Printa o resultado
	add $a0, $t2, $zero
	syscall

	li $v0, 4
	la $a0, barra_n
	syscall

	j title			# Volta pro menu

 
	#*****MULTIPLICACAO*****#  
# Multiplica dois números de entrada
multiplicacao:
	li $v0, 5		# Lê o primeiro número
	syscall
	move $t2, $v0

	li $v0, 5		# Lê o segundo número
	syscall
	move $t3, $v0

	mult $t3,$t2		# Multiplica os dois

	mflo $t4		# Move o resultado do Lo para $t4

	mfhi $t5		# # Move o resultado do Hi para $t5

	bgt $t5, $zero, error_mp	# Se houver overflow, pula para erro

	li $v0,1
	addi $a0, $t4, 0	# Resultado
	syscall

	j title

	error_mp:	# Printa a mensagem de erro e volta para o menu

	li $v0, 4
	la $v0, erro_msg
	syscall
	j title		# Volta pro menu


	#*****DIVISAO*****#  

# Faz a divisão dos dois números de input
divisao:
	li $v0, 4
	la $a0, divisor1_msg
	syscall

	li $v0, 5		# Lê o primeiro número
	syscall
	move $t0, $v0

	li $v0, 4
	la $a0, divisor2_msg
	syscall

	li $v0, 5		# Lê o segundo número
	syscall
	move $t1, $v0

	div $t0, $t1		# Faz a divisão entre os dois inputs

	mflo $t2		# Move do Lo para $t2
		
	mfhi $t3		# Move do Hi para $t3

	li $v0, 4
	la $a0, quociente_msg	
	syscall

	li $v0, 1
	addi $a0, $t2, 0	# Printa o quociente da divisão
	syscall

	li $v0, 4
	la $a0, barra_n
	syscall

	li $v0, 4
	la $a0, resto_msg	
	syscall

	li $v0, 1
	addi $a0, $t3, 0	# Printa o resto da divisão
	syscall

	li $v0, 4
	la $a0, barra_n
	syscall

	j title		# Volta pro menu


	#*****POTENCIA*****#  

# Calcula uma potência, dado como primeiro input a base desta e como segundo seu expoente
potencia:

	li $v0, 4
	la $a0, potencia_msg
	syscall

	li $v0, 6			# Lê a base
	syscall
	mov.s $f1, $f0 			# $f1 = base

	li $v0, 5			# Lê o expoente
	syscall
	move $s0, $v0 			# $s0 = expoente
	
	mov.s $f2, $f1 			# $f2 = base ($f2 = valor acumulado)
	li $s1, 1 			# $s1 = contador

potencia_loop:

	beq $s1, $s0, potencia_fim 		# Até contador = expoente
	mov.s $f3, $f2				# $t1 = $s2 (salva o valor para detecção de erro)
	mul.s $f2, $f2, $f1 			# Valor acumulado *= base
	addi $s1, $s1, 1 			# Contador++

	li $t0, 0x7f800000 	# + infinito
	mtc1 $t0, $f4 		# Carrega o valor
	c.eq.s $f2, $f4 	# Compara com o resultado obtido
	bc1t overflow 		# Em caso de overflow, pula para a mensagem de erro
	
	j potencia_loop 	# Repete

potencia_fim:	# Printa as mensagens e o resultado da potência
	
	li $v0, 4
	la $a0, resultado_msg
	syscall

	li $v0, 2		# Printa o resultado da potência
	mov.s $f12, $f2
	syscall
	
	li $v0, 4
	la $a0, barra_n
	syscall
	
	j title		# Volta pro menu

 
	#*****RAIZ*****#  

# Calcula a raiz quadrada aproximada de um número de entrada
raiz:
	li $v0, 4
	la $a0, insiraum_msg
	syscall

	li $v0, 5		# Lê o número que será feita a raiz
	syscall
	move $a0, $v0

	jal sqrt		# Jump para a função que calcula a raiz quadrada

	li $v0, 1		# Printa o resultado
	move $a0, $t0
	syscall

	li $v0, 4
	la $a0, barra_n
	syscall

	j title			# Volta para o menu


	#*****TABUADA*****#  

# Exibe a tabuada de um número de entrada
tabuada:
	li $v0, 4
	la $a0, tabnum_msg
	syscall

	li $v0, 5 		# Lê o número que será mostrada tabuada 
	syscall
	move $t0, $v0

	addi $t1, $zero, 1 		# Erros, pula para tabuada_error caso o input < 1 ou input > 10
	blt $t0, $t1, tabuada_error
	addi $t1, $zero, 10
	bgt $t0, $t1, tabuada_error

	li $v0, 4 			#  Printa a mensagem antes do resultado (tab2_msg)
	la $a0, tab2_msg
	syscall

	li $v0, 1			# Printa o número escolhido
	move $a0, $t0
	syscall

	li $v0, 4			#  Printa a mensagem antes do resultado (tab3_msg)
	la $a0, tab3_msg
	syscall

	add $t1, $zero, $zero		# Serão usados na função abaixo,
	addi $t3, $zero, 10		# a tabuada_loop

tabuada_loop:
	addi $t1, $t1, 1 		# Faz valor($t1)++
	mul $t2, $t0, $t1 		# Multiplica pelo input 

	li $v0, 1			# Printa o resultado
	move $a0, $t2
	syscall

	bne $t1, $t3, tabuada_loopy	# Pula para a função tabuada_loopy, para printar corretamente

	li $v0, 4			
	la $a0, tab6_msg
	syscall

	j title 			# Volta pro menu

tabuada_loopy:
	li $v0, 4
	la $a0, tab5_msg
	syscall

	j tabuada_loop			# Depois de manter o padrão de print da tabuada, volta pra tabuada_loop

tabuada_error: 
	li $v0, 4			# Mensagem de erro, caso houver um
	la $a0, taberro_msg
	syscall

	j title 			# Volta pro menu
	
	#*****IMC*****#  
	
#Recebe como parâmetros a massa da pessoa e sua altura, retornando o seu IMC
imc:
	li $v0, 4
	la $a0, massa_msg
	syscall
	
	li $v0, 6		# Lê o número escolhido para a massa da pessoa
	syscall
	mov.s $f1, $f0
	
	li $v0, 4
	la $a0, altura_msg	
	syscall
	
	li $v0, 6		# Lê o número escolhido para a altura da pessoa
	syscall
	mov.s $f2, $f0
	
	mul.s $f3, $f2, $f2	# Calcula o quadrado a altura escolhida
	
	div.s $f4, $f1, $f3	# Divide a massa pela altura²
	
	li $v0, 4
	la $a0, imc_msg	
	syscall
	
	li $v0, 2		# Printa o resultado, seu IMC
	mov.s $f12, $f4
	syscall
	
	li $v0, 4
	la $a0, barra_n
	syscall
		
	j title			# Volta para o menu

	#*****FATORIAL*****#  
	
# Calcula o fatorial de um número de entrada
fatorial:

	li $v0, 4	
	la $a0, insiraum_msg
	syscall

	li $v0, 5		# Lê o número de input, que irá ser calculado o fatorial
	syscall

	bge $v0, 13, overflow		# Verifica se ocorrerá overflow (>= 13)

	move $a0, $v0			# Pula para a função que calcula o fatorial do número
	jal fat			

	move $t0, $v0			# Salva o valor retornado

	li $v0, 4
	la $a0, resultado_msg
	syscall

	li $v0, 1			# Printa o resultado do fatorial
	move $a0, $t0
	syscall

	li $v0, 4
	la $a0, barra_n
	syscall

	j title				# Volta para o menu

# Caso ocorra overflow
overflow:
	
	li $v0, 4
	la $a0, overflow_msg		# Imprime mensagem de erro (overflow)
	syscall
	j title				# Volta para o menu

	#*****FIBONACCI*****#  

fibonacci:
	# código
	j title
	
	#*****FIM*****#  
	
end:
	li $v0, 10
	syscall


#Essa função faz a raiz quadrada de um número dado aproximada em inteiro
sqrt:
	li $t0, 0
	li $t1, 0
	add $t2, $zero, $a0

loop_sqrt:
	bgt $t1, $t2, end_sqrt 		# Se $t0 X $t0 > $t2, entao o numero que queremos era o anterior ao atual
	addi $t0, $t0, 1 		# Checamos o proximo numero
	mul $t1, $t0, $t0 		# Colocamos em $t1 o valor desse numero ao quadrado
	j loop_sqrt

end_sqrt: 		# Agora que sabemos que numero que é o desejado, podemos fazer $t0 -1, tendo as respostas que quermos
	addi $t0, $t0, -1
	jr $ra


#  Calcula (de forma recursiva) o valor do fatorial do inteiro em $a0 e retorna em $v0
fat:
	addi $sp, $sp, -8 	# Move o ponteiro da pilha
	sw $a0, 0($sp) 		# Guarda o conteúdo de $a0
	sw $ra, 4($sp) 		# Guarda o conteúdo de $ra

	beqz $a0, fat_retorna_1 	# Verifica condição de parada
	addi $a0, $a0, -1 		# Carrega em $a0 o elemento anterior
	jal fat 			# Chamada recursiva
	addi $a0, $a0, 1 		# Retorna o valor original
	mul $v0, $v0, $a0 		# Realiza a multiplicação
	j fat_fim 			# Pula para o fim (ignora fat_retorna_1)

fat_retorna_1:
	li $v0, 1 		# Retorna 1 - condição de parada

fat_fim:
	lw $ra, 4($sp) 		# Restaura o valor de $ra
	lw $a0, 0($sp) 		# Restauro o valor de $a0
	addi $sp, $sp, 8 	# Move de volta o ponteiro da pilha
	jr $ra 			# Retorna