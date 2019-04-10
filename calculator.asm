	.data

# Valor "infinito" para verificação de overflow em float
infinito:         .word  0x7f800000

# Mensagens do menu do usuário
menu_msg:        .asciiz "\n 1. Soma\n 2. Subtração\n 3. Multiplicação\n 4. Divisão\n 5. Potência\n 6. Raiz quadrada\n 7. Tabuada de X\n 8. IMC\n 9. Fatorial\n10. Fibonacci\n11. Encerrar programa\n"
op_invalida_msg: .asciiz "\nOpção inválida\n"

# Mensagens de uso geral
barra_n:         .asciiz "\n"
ins_um_msg:      .asciiz "\nInsira um número: "
ins_dois_msg:    .asciiz "\nInsira dois números:\n"
resultado_msg:   .asciiz "\nResultado: "

# Mensagens de erro de uso geral
overflow_msg:    .asciiz "\nErro: o resultado obtido ultrapassa o limite. Utilize números menores\n"
negativo_msg:    .asciiz "\nErro: essa operação não admite parâmetro(s) negativo(s)\n"
nulo_msg:        .asciiz "\nErro: essa operação não admite parâmetro(s) nulo(s)\n"

# Mensagens da operação de divisão
dividendo_msg:   .asciiz "\nInsira o dividendo: "
divisor_msg:     .asciiz "Insira o divisor: "
quociente_msg:   .asciiz "\nQuociente: "
resto_msg:       .asciiz "Resto: "
div_por_0_msg:   .asciiz "\nNão há definição para divisão por zero. Utilize valores válidos\n"

# Mensagens da operação de potência
potencia_msg:    .asciiz "\nInsira a base e o expoente, respectivamente:\n"
exp_neg_msg:     .asciiz "\nErro: essa calculadora não suporta valores negativos para o expoente\n"
exp_nulo_msg:    .asciiz "\nErro: essa calculadora não suporta valor nulo para o expoente\n"

# Mensagens da operação de IMC
massa_msg:       .asciiz "\nInsira a massa em quilogramas: "
altura_msg:      .asciiz "Insira a altura metros: "
imc_msg:         .asciiz "\nIMC: "

# Mensagens da operação de tabuada
tab_ins_msg:     .asciiz "\nInsira um número entre 1 e 10: "
tab_num_msg:     .asciiz "\nA tabuada do "
tab_eh_msg:      .asciiz " é: "
tab_vir_msg:     .asciiz ", "
tab_erro_msg:    .asciiz "\nErro: o parâmetro não se encontra no intervalo entre 1 e 10\n"

# Mensagens da operação de Fibonacci
fibonacci_msg:   .asciiz "\nInsira o intervalo em que deseja calcular a sequência:"
intervalo_msg:   .asciiz "\nErro: o intervalo definido é inválido. O final do intervalo deve ser maior que o início\n"

	.text

##### Menu #####################################################################

# Menu de opções do usuário
menu:
	# Imprime a mensagem de opções do menu
	li $v0, 4
	la $a0, menu_msg
	syscall

	# Lê a opção escolhida pelo usuário
	li $v0, 5
	syscall

	# Salva a opção lida
	move $t0, $v0

# Filtra as opções do menu e realiza o jump para a operação selecionada
opcoes:
	# $t0 = opção do usuário
	# $t1 = filtro
	li $t1, 1
	beq $t0, $t1, soma          #t0 = 1
	li $t1, 2
	beq $t0, $t1, subtracao     #t0 = 2
	li $t1, 3
	beq $t0, $t1, multiplicacao #t0 = 3
	li $t1, 4
	beq $t0, $t1, divisao       #t0 = 4
	li $t1, 5
	beq $t0, $t1, potencia      #t0 = 5
	li $t1, 6
	beq $t0, $t1, raiz          #t0 = 6
	li $t1, 7
	beq $t0, $t1, tabuada       #t0 = 7
	li $t1, 8
	beq $t0, $t1, imc           #t0 = 8
	li $t1, 9
	beq $t0, $t1, fatorial      #t0 = 9
	li $t1, 10
	beq $t0, $t1, fibonacci     #t0 = 10
	li $t1, 11
	beq $t0, $t1, encerrar      #t0 = 11

	# Caso o usuário digite uma opção inválida
	li $v0, 4
	la $a0, op_invalida_msg
	syscall

	j menu


##### Operações ################################################################


#***** Soma ********************************************************************
#
#  Lê e soma dois números inteiros e, em seguida, imprime o resultado
#

soma:
	# Imprime a mensagem de entrada de dois parâmetros
	li $v0, 4
	la $a0, ins_dois_msg
	syscall

	# Lê o primeiro parâmetro
	li $v0, 5
	syscall

	# Salva o primeiro valor lido
	move $t0, $v0

	# Lê o segundo parâmetro
	li $v0, 5
	syscall

	# Salva o segundo valor lido
	move $t1, $v0

	# Realiza a soma ($t0 = $t0 + $t1)
	add $t0, $t0, $t1

	# Imprime as mensagens de resultado
	li $v0, 4
	la $a0, resultado_msg
	syscall

	li $v0, 1
	move $a0, $t0
	syscall

	li $v0, 4
	la $a0, barra_n
	syscall

	# Retorna ao menu
	j menu


#***** Subtração ***************************************************************
#
#  Lê e subtrai dois números inteiros e, em seguida, imprime o resultado
#

subtracao:
	# Imprime a mensagem de entrada de dois parâmetros
	li $v0, 4
	la $a0, ins_dois_msg
	syscall

	# Lê o primeiro parâmetro
	li $v0, 5
	syscall

	# Salva o primeiro valor lido
	move $t0, $v0

	# Lê o segundo parâmetro
	li $v0, 5
	syscall

	# Salva o segundo valor lido
	move $t1, $v0

	# Realiza a subtração ($t0 = $t0 - $t1)
	sub $t0, $t0, $t1

	# Imprime as mensagens de resultado
	li $v0, 4
	la $a0, resultado_msg
	syscall

	li $v0, 1
	move $a0, $t0
	syscall

	li $v0, 4
	la $a0, barra_n
	syscall

	# Retorna ao menu
	j menu


#***** Multiplicação ***********************************************************
#
#  Lê e multiplica dois números inteiros e, em seguida, imprime o resultado
#  (Verifica overflow)
#

multiplicacao:
	# Imprime a mensagem de entrada de dois parâmetros
	li $v0, 4
	la $a0, ins_dois_msg
	syscall

	# Lê o primeiro parâmetro
	li $v0, 5
	syscall

	# Salva o primeiro valor lido
	move $t0, $v0

	# Lê o segundo parâmetro
	li $v0, 5
	syscall

	# Salva o segundo valor lido
	move $t1, $v0

	# Realiza a multiplicação ($t0 * $t1)
	mult $t0, $t1

	# Salva o conteúdo dos registradores 'lo' e 'hi'
	mflo $t2
	mfhi $t3

	# Verfica overflow
	bgt $t3, $zero, erro_overflow

	# Imprime as mensagens de resultado
	li $v0, 4
	la $a0, resultado_msg
	syscall

	li $v0, 1
	move $a0, $t2
	syscall

	li $v0, 4
	la $a0, barra_n
	syscall

	# Retorna ao menu
	j menu


#***** Divisão *****************************************************************
#
#  Lê e divide dois números inteiros (dividendo e divisor) e, em seguida,
#  imprime o resultado. (Verifica divisão por zero)
#

divisao:
	# Imprime a mensagem de entrada do dividendo
	li $v0, 4
	la $a0, dividendo_msg
	syscall

	# Lê o primeiro parâmetro (dividendo)
	li $v0, 5
	syscall

	# Salva o primeiro valor lido
	move $t0, $v0

	# Imprime a mensagem de entrada do divisor
	li $v0, 4
	la $a0, divisor_msg
	syscall

	# Lê o segundo parâmetro (divisor)
	li $v0, 5
	syscall

	# Salva o segundo valor lido
	move $t1, $v0

	# Verifica divisão por zero
	beqz $t1, erro_div_por_0

	# Realiza a divisão ($t0 / $t1)
	div $t0, $t1

	# Salva os valores do quociente e do resto ('lo' e 'hi')
	mflo $t2
	mfhi $t3

	# Imprime o resultado do quociente
	li $v0, 4
	la $a0, quociente_msg
	syscall

	li $v0, 1
	move $a0, $t2
	syscall

	li $v0, 4
	la $a0, barra_n
	syscall

	# Imprime o resultado do resto
	li $v0, 4
	la $a0, resto_msg
	syscall

	li $v0, 1
	move $a0, $t3
	syscall

	li $v0, 4
	la $a0, barra_n
	syscall

	# Retorna ao menu
	j menu


#***** Potência ****************************************************************
#
#  Lê e realiza a operação de exponenciação entre dois números (base e expoente)
#  e, em seguida, imprime o resultado.
#  O primeiro parâmtro lido, a base, é um float e admite valores positivos e
#  negativos, enquanto que o segundo, o expoente, deve ser um inteiro positivo
#  (Verifica overflow e entrada de parâmetro negativo ou nulo - expoente)
#

potencia:
	# Imprime a mensagem de entrada de parâmetros (base e expoente)
	li $v0, 4
	la $a0, potencia_msg
	syscall

	# Lê o primeiro parâmetro (base)
	li $v0, 6
	syscall

	# Salva o valor lido
	mov.s $f1, $f0

	# Para verificar overflow
	lw $t2, infinito # Infinito (overflow)
	mtc1 $t2, $f3       # Carrega o valor

	# Verifica overflow no primeiro parâmetro
	c.eq.s $f1, $f3
	bc1t erro_overflow

	# Lê o segundo parâmetro (expoente)
	li $v0, 5
	syscall

	# Verifica o segundo parâmetro é válido (> 0)
	bltz $v0, erro_expoente_negativo
	beqz $v0, erro_expoente_nulo

	# Salva o valor lido
	move $t0, $v0

	# Carrega os valores ($f2 = valor acumulado, $t1 = contador)
	mov.s $f2, $f1
	li $t1, 1

potencia_loop:
	beq $t1, $t0, potencia_fim  # Até contador = expoente
	mul.s $f2, $f2, $f1         # Valor acumulado *= base
	addi $t1, $t1, 1            # Contador++

	c.eq.s $f2, $f3             # Compara com o resultado obtido
	bc1t erro_overflow          # Caso ocorra overflow

	j potencia_loop             # Repete

potencia_fim:
	# Imprime as mensagens de resultado
	li $v0, 4
	la $a0, resultado_msg
	syscall

	li $v0, 2
	mov.s $f12, $f2
	syscall

	li $v0, 4
	la $a0, barra_n
	syscall

	# Retorna ao menu
	j menu


#***** Raiz quadrada ***********************************************************
#
#  Lê um número inteiro positivo e extrai sua raiz quadrada, imprimindo logo em
#  seguida o resultado aproximado para inteiro.
#  (Verifica overflow e entrada de parâmetro negativo)
#

raiz:
	# Imprime a mensagem de entrada de um parâmetro
	li $v0, 4
	la $a0, ins_um_msg
	syscall

	# Lê o parâmetro
	li $v0, 5
	syscall

	# Verifica se o parâmetro é válido (>= 0)
	bltz $v0, erro_negativo

	# Salva o valor lido
	move $t0, $v0

	li $t1, 0  # Contador
	li $t2, 0  # Auxiliar

raiz_loop:
	bgt $t2, $t0, raiz_fim  # Se $t1^2 > $t0, então já alcançou o resultado
	addi $t1, $t1, 1        # Contador++
	mul $t2, $t1, $t1       # $t2 = $t1^2
	j raiz_loop             # Repete

raiz_fim:
	subi $t1, $t1, 1  # t1-- (valor anterior)

	# Imprime as mensagens de resultado
	li $v0, 4
	la $a0, resultado_msg
	syscall

	li $v0, 1
	move $a0, $t1
	syscall

	li $v0, 4
	la $a0, barra_n
	syscall

	# Retorna ao menu
	j menu


#***** Tabuada *****************************************************************
#
#  Lê um número inteiro entre 1 e 10 e imprime sua tabuada. (Verifica intervalo)
#

tabuada:
	# Imprime a mensagem de entrada de parâmetro
	li $v0, 4
	la $a0, tab_ins_msg
	syscall

	# Lê o parâmtro
	li $v0, 5
	syscall

	# Salva o valor lido
	move $t0, $v0

	# Verifica se o parâmetro está contido no intervalo entre 1 e 10
	li $t1, 1
	blt $t0, $t1, erro_tabuada
	li $t1, 10
	bgt $t0, $t1, erro_tabuada

	# Imprime as primeiras mensagens de resultado
	li $v0, 4
	la $a0, tab_num_msg
	syscall

	li $v0, 1
	move $a0, $t0
	syscall

	li $v0, 4
	la $a0, tab_eh_msg
	syscall

	# Carrega os valores ($t1 = contador, $t10 = condição de parada)
	li $t1, 1
	li $t3, 10

tabuada_loop:
	bgt $t1, $t3, tabuada_fim  # Verifica se chegou ao fim da tabuada (10)
	mul $t2, $t0, $t1          # Multiplica o valor de entrada pelo contador

	li $v0, 1                  # Imprime o resultado da multiplicação
	move $a0, $t2
	syscall

	beq $t1, $t3, tabuada_fim  # Verifica se é o último
	li $v0, 4                  # Se não for, imprime a vírgula
	la $a0, tab_vir_msg
	syscall

	addi $t1, $t1, 1           # Contador++
	j tabuada_loop             # Repete

tabuada_fim:
	# Imprime fim de linha
	li $v0, 4
	la $a0, barra_n
	syscall

	# Retorna ao menu
	j menu


#***** IMC *********************************************************************
#
#  Lê massa e altura e calcula o indíce de massa corporal e, em seguida, imprime
#  o resultado. Os parâmetros e o resultado são valores de ponto flutuante.
#  (Verifica overflow e entrada de parâmetros negativos e nulos)
#

imc:
	# Imprime a mensagem de entrada da massa
	li $v0, 4
	la $a0, massa_msg
	syscall

	# Lê o primeiro parâmetro (massa)
	li $v0, 6
	syscall

	# Verifica se a massa é válida (>= 0)
	mtc1 $zero, $f4
	c.lt.s $f0, $f4
	bc1t erro_negativo  # massa < 0
	c.eq.s $f0, $f4
	bc1t erro_nulo  # massa = 0

	# Salva o valor lido
	mov.s $f1, $f0

	# Para verificar overflow
	lw $t0, infinito    # Infinito (overflow)
	mtc1 $t0, $f4       # Carrega o valor

	# Verifica overflow no primeiro parâmetro
	c.eq.s $f1, $f4
	bc1t erro_overflow

	# Imprime a mensagem de entrada da altura
	li $v0, 4
	la $a0, altura_msg
	syscall

	# Lê o segundo parâmetro (altura)
	li $v0, 6
	syscall

	# Verifica se a altura é válida (>= 0)
	mtc1 $zero, $f4
	c.lt.s $f0, $f4
	bc1t erro_negativo  # altura < 0
	c.eq.s $f0, $f4
	bc1t erro_nulo  # altura = 0

	# Salva o valor lido
	mov.s $f2, $f0

	# altura^2
	mul.s $f2, $f2, $f2

	# Verifica overflow no quadrado do segundo parâmetro
	c.eq.s $f2, $f4
	bc1t erro_overflow

	# imc = massa / altura^2
	div.s $f3, $f1, $f2

	# Verifica overflow no resultado
	c.eq.s $f3, $f4
	bc1t erro_overflow

	# Imprime as mensagens de resultado
	li $v0, 4
	la $a0, imc_msg
	syscall

	li $v0, 2
	mov.s $f12, $f3
	syscall

	li $v0, 4
	la $a0, barra_n
	syscall

	# Retorna ao menu
	j menu


#***** Fatorial ****************************************************************
#
#  Lê um número inteiro positivo, calcula seu fatorial e, em seguida, imprime
#  o resultado. (Verifica overflow e entrada de parâmetro negativo)
#

fatorial:
	# Imprime a mensagem de entrada de um parâmetro
	li $v0, 4
	la $a0, ins_um_msg
	syscall

	# Lê o parâmetro
	li $v0, 5
	syscall

	# Verifica se o parâmetro é válido (>= 0)
	bltz $v0, erro_negativo

	# Verifica se ocorrerá overflow (>= 13)
	bge $v0, 13, erro_overflow

	# Carrega o parâmetro e chama a função que calcula o fatorial
	move $a0, $v0
	jal fat

	# Salva o valor retornado
	move $t0, $v0

	# Imprime as mensagens de resultado

	li $v0, 4
	la $a0, resultado_msg
	syscall

	li $v0, 1
	move $a0, $t0
	syscall

	li $v0, 4
	la $a0, barra_n
	syscall

	# Retorna ao menu
	j menu


#***** Fibonacci ***************************************************************
#
#  Lê dois números inteiros positivos que representam um intervalo e imprime a
#  sequência de Fibonacci calculada neste.
#  (Verifica intervalo e entrada de parâmetros negativos e nulos)
#

fibonacci:
	# Imprime a mensagem de entrada de parâmetros
	li $v0, 4
	la $a0, fibonacci_msg
	syscall

	# Lê o primeiro parâmetro (início do intervalo)
	li $v0, 5
	syscall

	# Verifica se o primeiro parâmetro é válido (> 0)
	bltz $v0, erro_negativo
	beqz $v0, erro_nulo

	# Salva o valor lido e carrega
	move $t0, $v0
	
	# Lê o segundo parâmetro (fim do intervalo)
	li $v0, 5
	syscall
	
	# Verifica se o segundo parâmetro é válido (> 0 > início)
	bltz $v0, erro_negativo
	beqz $v0, erro_nulo
	ble $v0, $t0, erro_intervalo
	
	# Salva o valor lido
	move $t1, $v0
	
	# Imprime a mensagem de resultado
	li $v0, 4
	la $a0, resultado_msg
	syscall

	# Carrega os parâmetros e chama a função que calcula/imprime a sequência
	move $a0, $t0
	move $a1, $t1
	jal fibo

	# Imprime fim de linha
	li $v0, 4
	la $a0, barra_n
	syscall

	# Retorna ao menu
	j menu


#***** Encerrar ****************************************************************
#
#  Encerra o programa
#

encerrar:
	li $v0, 10
	syscall


#***** Impressão de mensagens de erro ******************************************
#
#  Imprime a respectiva mensagem de erro e retorna ao menu
#

# Caso a operação não admita parâmetros(s) negativo(s)
erro_negativo:
	li $v0, 4
	la $a0, negativo_msg
	syscall
	j menu

# Caso a operação não admita parâmetros(s) nulo(s)
erro_nulo:
	li $v0, 4
	la $a0, nulo_msg
	syscall
	j menu

# Caso ocorra overflow
erro_overflow:
	li $v0, 4
	la $a0, overflow_msg
	syscall
	j menu

# (Divisão) Caso ocorra divisão por zero
erro_div_por_0:
	li $v0, 4
	la $a0, div_por_0_msg
	syscall
	j menu

# (Potência) Caso o expoente seja negativo
erro_expoente_negativo:
	li $v0, 4
	la $a0, exp_neg_msg
	syscall
	j menu

# (Potência) Caso o expoente seja nulo
erro_expoente_nulo:
	li $v0, 4
	la $a0, exp_nulo_msg
	syscall
	j menu

# (Fibonacci) Caso o intervalo seja inválido (início > fim)
erro_intervalo:
	li $v0, 4
	la $a0, intervalo_msg
	syscall
	j menu

# (Tabuada) Caso a entrada não esteja no intervalo [1, 10]
erro_tabuada:
	li $v0, 4
	la $a0, tab_erro_msg
	syscall
	j menu


##### Procedimentos ############################################################


#**** fat **********************************************************************
#
#  Calcula (de forma recursiva) o valor do fatorial do inteiro em $a0 e retorna
#  em $v0
#
#  Parâmetros:
#    $a0: número cujo fatorial deseja-se calcular
#
#  Retorno:
#    $v0: fatorial calculado
#

fat:
	addi $sp, $sp, -8   # Move o ponteiro da pilha
	sw $a0, 0($sp)      # Guarda o conteúdo de $a0
	sw $ra, 4($sp)      # Guarda o conteúdo de $ra

	beqz $a0, fat_retorna_1  # Verifica condição de parada
	addi $a0, $a0, -1        # Carrega em $a0 o elemento anterior
	jal fat                  # Chamada recursiva
	addi $a0, $a0, 1         # Restaura o valor original
	mul $v0, $v0, $a0        # Realiza a multiplicação
	j fat_fim                # Pula para o fim (ignora fat_retorna_1)

fat_retorna_1:
	li $v0, 1  # Retorna 1 na condição de parada

fat_fim:
	lw $ra, 4($sp)    # Restaura o valor de $ra
	lw $a0, 0($sp)    # Restauro o valor de $a0
	addi $sp, $sp, 8  # Move de volta o ponteiro da pilha
	jr $ra            # Retorna


#**** fibo *********************************************************************
#
#  Calcula (de forma recursiva) a sequência de Fibonacci no intervalo fechado
#  definido em $a0 e $a1 e imprime o resultado
#
#  Parâmetros:
#    $a0: início do intervalo (fechado)
#    $a1: final do intervalo (fechado)
#

fibo:
	addi $sp, $sp, -12  # Move o ponteiro da pilha
	sw $a0, 0($sp)      # Guarda o conteúdo de $a0
	sw $a1, 4($sp)      # Guarda o conteúdo de $a1
	sw $ra, 8($sp)      # Guarda o conteúdo de $ra

fibo_fim:
	lw $ra, 8($sp)     # Restaura o valor de $ra
	lw $a1, 4($sp)     # Restaura o valor de $a1
	lw $a0, 0($sp)     # Restaura o valor de $a0
	addi $sp, $sp, 12  # Move de volta o ponteiro da pilha
	jr $ra             # Retorna
