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
	
	li $v0, 5  #read the first number 
	syscall
	
	move $t0, $v0 #$t0 = Selector
	
	li $t1, 1 #$t1 = filter
	
	jumpers: 
	
	beq  $t0, $t1, soma		#t0 = 1
	addi $t1, $t1, 1
	beq $t0, $t1, subtracao		#t0 = 2
	addi $t1, $t1, 1
	beq $t0, $t1, multiplicacao	#t0 = 3
	addi $t1, $t1, 1
	beq $t0, $t1, divisao		#t0 = 4
	addi $t1, $t1, 1
	beq $t0, $t1, potencia		#t0 = 5
	addi $t1, $t1, 1
	beq $t0, $t1, raiz		#t0 = 6
	addi $t1, $t1, 1
	beq $t0, $t1, tabuada		#t0 = 7
	addi $t1, $t1, 1
	beq $t0, $t1, IMC		#t0 = 8
	addi $t1, $t1, 1
	beq $t0, $t1, fatorial		#t0 = 9
	addi $t1, $t1, 1
	beq $t0, $t1, fibonacci		#t0 = 10
	addi $t1, $t1, 1
	beq $t0, $t1, end		#t0 = 11
	
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
	
	multiplicacao: #Com high e low? (responde erro caso overload)
	
	
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
	
	divisao: #divisao mostrara o valor do quociente e do resto;
	
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
	
	j title
	
	
	 
	#*****RAIZ*****#  
	
	raiz: #Argumentos de entrada = $a0, saida = $t0 com a raiz aproximada em inteiro, $t2 = o numero que veio em $a0
	
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
	j title
	
	#*****IMC*****#  
	
	IMC:
	
	j title
	
	
	#*****FATORIAL*****#  
	
	fatorial:
	
	j title
	
	#*****FIBONACCI*****#  
	
	fibonacci:	
	
	j title
	
	#*****FIM*****#  
	
	end:
	
	li $v0, 10
	syscall


	sqrt: #Essa funcao faz a raiz quadrada de um numero dado aproximada em inteiro
	
	li $t0, 0
	li $t1, 0
	add $t2, $zero, $a0
	
	
	loop_sqrt:
		bgt $t1, $t2, end_sqrt	#se $t0 X $t0 > $t2, entao o numero que queremos era o anterior ao atual
		addi $t0, $t0, 1	#checamos o proximo numero
		mul $t1, $t0, $t0	#colocamos em $t1 o valor desse numero ao quadrado
		j loop_sqrt
	end_sqrt:			#agora que sabemos que numero que é o desejado, podemos fazer $t0 -1, tendo as respostas que quermos
	
	addi $t0, $t0, -1
	jr $ra
		
		
		
	
	
