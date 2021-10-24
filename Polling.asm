.data
	.align 2
temp: .space 100
			
message1: .asciiz "Welcome to The aMAZEing Game!\n"
message2: .asciiz "----------------------Menu------------------------\n"
message3: .asciiz "Your moves are:\n"
message4: .asciiz "  W to go up. \n"
message5: .asciiz "  S to go down. \n"
message6: .asciiz "  A to go left. \n"
message7: .asciiz "  D to go right. \n"
message8: .asciiz "  E to have the best route. \n"
message9: .asciiz "\nHere is your Labyrinth:\n"
message10: .asciiz "\nPlease enter your move:\t"
message11: .asciiz "\nNot possible move.\n"	
theend: .asciiz "\nWinner Winner Chicken Dinner!\n"

map: 		.ascii  "I.IIIIIIIIIIIIIIIIIII"
                .ascii  "I....I....I.......I.I"
                .ascii  "III.IIIII.I.I.III.I.I"
                .ascii  "I.I.....I..I..I.....I"
                .ascii  "I.I.III.II...II.I.III"
                .ascii  "I...I...III.I...I...I"
                .ascii  "IIIII.IIIII.III.III.I"
                .ascii  "I.............I.I...I"
                .ascii  "IIIIIIIIIIIIIII.I.III"
                .ascii  "@...............I..II"	
                .asciiz "IIIIIIIIIIIIIIIIIIIII"

newline: .asciiz "\n"

.globl main
.text

main:

	#usermove = $s0
	addi $s1, $0, 21 #W wiidth
	addi $s2, $0, 11 #H height
	addi $s3, $0, 1 #playerPos
	addi $s5, $0, 0 #step
	
	la $s4, map  #load address se ena saved thn dieythynsh toy pinaka
	
	addi $v0, $0, 4
	la $a0, message1
	syscall
	la $a0, message2
	syscall
	la $a0, message3
	syscall
	la $a0, message4
	syscall
	la $a0, message5
	syscall
	la $a0, message6
	syscall
	la $a0, message7
	syscall
	la $a0, message8
	syscall
	
	move $a3, $s3
	jal printLabyrinth

	while_loop:
		beq $s0, 'E', caseE
		
	#	addi $v0,$0 ,4    #entolh gia na valei thn kinhsh o paikths
	#	la $a0, message10
	#	syscall	
		
		jal read_ch	

		move $s0, $v0
		
		caseW:
			bne $s0, 'W', caseS
			
			addi $t0, $0, -1
			mul $s5, $s1, $t0  #kanoyme pollaplasiasmo gia na apokthsoyme to $s1 = - $s1 (w=-w) kai
					   # to vazoyme sto step
					
			add $t1, $s3, $s5  #$t1 = playerPos + step
			
			la $s4, map
			add $s4, $s4, $t1
			lb $t5, ($s4)
			
			bgt $t1, $0, other_or1_if
				j if_cond_1
			
			other_or1_if:
			bne $t5, 'I', else_caseW_if
				j if_cond_1
				
				if_cond_1:
				addi $v0, $0, 4
				la $a0, message11
				syscall
				j while_loop
				
			else_caseW_if:
			#add $s3, $s3, $s5
			move $s3, $t1
			
			sub $a1, $s3, $s5 #opoy $a1 exei to mesa to orisma playerPos-step gia th makeplayermove	
			jal makePlayerMove
			move $t0, $v0 #h v0 tha exei thn timh poy theloyme na epistrefei h move
			
			bne $t0, 1, go_outside
			jal end_main
			
			go_outside:
			li $t2, 46
			la $s4, map
			add $s4, $s4, $a1
			sb $t2, ($s4)
			
			move $a3, $s3
			jal printLabyrinth
			
			j while_loop
			
		caseS:
			bne $s0, 'S', caseA
			
			move $s5, $s1
			
			add $t1, $s3, $s5  # $t1 = playerPos + step
			
			la $s4, map
			add $s4, $s4, $t1
			lb $t5, ($s4)
			
			addi $t2, $0, 231 #total elements
			blt $t1, $t2, other_or2_if
				j if_cond_2
				
			other_or2_if:
			bne $t5, 'I', else_caseS_if
				j if_cond_2
				
				if_cond_2:
				addi $v0, $0, 4
				la $a0, message11
				syscall
				j while_loop
				
			else_caseS_if:
			add $s3, $s3, $s5
			
			sub $a1, $s3, $s5 #opoy $a1 exei to mesa to orisma playerPos-step gia th makeplayermove	
			jal makePlayerMove
			move $t0, $v0 #h v0 tha exei thn timh poy theloyme na epistrefei h move
			
			bne $t0, 1, go_1_outside
			jal end_main
			
			go_1_outside:
			li $t2, 46
			la $s4, map
			add $s4, $s4, $a1
			sb $t2, ($s4)
			
			move $a3, $s3
			jal printLabyrinth
			
			j while_loop
			
		caseA:
			bne $s0, 'A', caseD
			
			addi $t0, $0, 1
			sub $t0, $0, $t0
			move $s5, $t0
			
			add $t1, $s3, $s5  # $t1 = playerPos + step
		
			la $s4, map
			add $s4, $s4, $t1
			lb $t5, ($s4)
		
			bgt $t1, $0, other_or3_if
				j if_cond_3
				
			other_or3_if:
			bne $t5, 'I', else_caseA_if
				j if_cond_3
				
				if_cond_3:
				addi $v0, $0, 4
				la $a0, message11
				syscall
				j while_loop
				
			else_caseA_if:
			add $s3, $s3, $s5
			
			sub $a1, $s3, $s5 #opoy $a1 exei to mesa to orisma playerPos-step gia th makeplayermove	
			jal makePlayerMove
			move $t0, $v0 #h v0 tha exei thn timh poy theloyme na epistrefei h move
			
			bne $t0, 1, go_2_outside
			jal end_main
			
			go_2_outside:
			li $t2, 46
			la $s4, map
			add $s4, $s4, $a1
			sb $t2, ($s4)
			
			move $a3, $s3
			jal printLabyrinth
			
			j while_loop
			
		caseD:
			bne $s0, 'D', caseE
			
			addi $t0, $0, 1
			move $s5, $t0
			
			add $t1, $s3, $s5  # $t1 = playerPos + step
			
			la $s4, map
			add $s4, $s4, $t1
			lb $t5, ($s4)
		
			addi $t2, $0, 231 #total elements
			blt $t1, $t2, other_or4_if
				j if_cond_4
				
			other_or4_if:
			bne $t5, 'I', else_caseD_if
				j if_cond_4
				
				if_cond_4:
				addi $v0, $0, 4
				la $a0, message11
				syscall
				j while_loop
				
			else_caseD_if:
			add $s3, $s3, $s5
			
			sub $a1, $s3, $s5 #opoy $a1 exei to mesa to orisma playerPos-step gia th makeplayermove	
			jal makePlayerMove
			move $t0, $v0 #h v0 tha exei thn timh poy theloyme na epistrefei h move
			
			bne $t0, 1, go_3_outside
			jal end_main
			
			go_3_outside:
			li $t2, 46
			la $s4, map
			add $s4, $s4, $a1
			sb $t2, ($s4)
			
			move $a3, $s3
			jal printLabyrinth
			
			j while_loop
			
		caseE:
			bne $s0, 'E', while_loop
			
			addi $a1, $0, 1 # $a1 to starX poy exoyme pei sth c oti einai iso me 1 arxika
			#exoyme to orisma na pernaei sto $a1
			jal makeMove

			move $a3, $s3
			jal printLabyrinth
		
	end_main:	
	addi $v0, $0, 10
	syscall
	

printLabyrinth:
	#temporary variables $t0 = i, $t1 = j, $t2 = k	
	addi $sp, $sp, -4

	addi $v0, $0, 4
	la $a0, message9
	syscall
	
	li $a0, 200
	sw $ra, 0($sp)
	jal usleep
	lw $ra, 0($sp)
	
	addi $t0, $0, 0
	addi $t2, $0, 0
	move $t3, $a3 #opou t3 to playerPos
	move $t4, $s1 #opou t4 to width
	move $t5, $s2 #opou t5 to height

	first_for_label:
		bge $t0, $t5, ending_label #anti bge mporw na valw to beq 
		addi $t1, $0, 0
		
		next_for:
			bge $t1, $t4, end_of_for
			
				bne $t2, $t3, else_label
				li $t6, 80				
				la $t7, temp
				add $t7, $t7, $t1
				sb $t6, ($t7)
				j extra_condition
				
				else_label:
				la $t7, map
				add $t7, $t7, $t2
				lb $t6, ($t7) 
								
				la $t7, temp  #mporw na janaxrhsimopoihsw ton kataxwrhth
				add $t7, $t7, $t1
				sb $t6, ($t7)
				
				extra_condition:
				addi $t2, $t2, 1
				addi $t1, $t1, 1
				j next_for
				
		end_of_for:
			addi $t1, $t1, 1
			
			li $t6, 3 #eite li eite la to idio tha kanei
			la $t7, temp #einai kathe grammh
			add $t7, $t7, $t1
			sb $t6, ($t7)
			
			li $v0, 4
			la $a0, temp
			syscall
			
			li $v0, 4
			la $a0, newline
			syscall
			
			addi $t0, $t0, 1
			j first_for_label
		
		ending_label:
			addi $sp, $sp, 4
			jr $ra
	
	
makePlayerMove:
	#dexetai apo th change to $a1 poy einai to index dhladh to playerpos - step
	addi $sp, $sp, -8
	sw $ra, 0($sp)
	sw $a1, 4($sp)
	
	addi $t0, $a1, -1  #index-1
	addi $t1, $a1, 1 #index+1
	
	li $t5, 37 #  %
	li $t6, 80 #  P
	li $t7, 46 #  .
	
	la $t3, map
	add $t3, $t3, $t0
	lb $t4, ($t3)
	
	bne $t4, '@', second_if
     		la $t3, map
		add $t3, $t3, $t0
		sb $t5, ($t3)
	
		la $t3, map
		add $t3, $t3, $a1
		sb $t6, ($t3)
	
		la $t3, map
		add $t3, $t3, $t1
		sb $t7, ($t3)
	
		move $s3, $a1  # playerPos = index
		move $a3, $s3 #a3 o kataxwrhths poyo zhtaei h printLabyrinth
		jal printLabyrinth
	
		li $v0, 4
		la $a0, theend
		syscall
	
		addi $v0, $0, 1
		j end_if
	
	second_if:
		la $t3, map
		add $t3, $t3, $t1
		lb $t4, ($t3)
	
		bne $t4, '@', third_if
		la $t3, map
		add $t3, $t3, $t0 #t0 = index - 1
		sb $t7, ($t3)
	
		la $t3, map
		add $t3, $t3, $a1
		sb $t6, ($t3)

		la $t3, map
		add $t3, $t3, $t1
		sb $t5, ($t3)
	
		move $s3, $a1
		move $a3, $s3
		jal printLabyrinth
	
		li $v0, 4
		la $a0, theend
		syscall
	
		addi $v0, $0, 1
		j end_if	
	
	third_if:
		add $t1, $a1, $s1
		la $t3, map
		add $t3, $t3, $t1
		lb $t4, ($t3)
	
		bne $t4, '@', fourth_if
		la $t3, map
		add $t3, $t3, $t1
		sb $t5, ($t3)
	
		la $t3, map
		add $t3, $t3, $a1
		sb $t6, ($t3)
	
		sub $t0, $a1, $s1
		la $t3, map
		add $t3, $t3, $t0
		sb $t7, ($t3)
	
		move $s3, $a1
		move $a3, $s3
		jal printLabyrinth
	
		li $v0, 4
		la $a0, theend
		syscall
	
		addi $v0, $0, 1
		j end_if
	
	
	fourth_if:
		sub $t1, $a1, $s1
		la $t3, map
		add $t3, $t3, $t1
		lb $t4, ($t3)
	
		bne $t4, '@', other_option
		la $t3, map
		add $t3, $t3, $t1
		sb $t5, ($t3)
	
		la $t3, map
		add $t3, $t3, $a1
		sb $t6, ($t3)
	
		add $t0, $a1, $s1
		la $t3, map
		add $t3, $t3, $t0
		lb $t7, ($t3)
	
		move $s3, $a1
		move $a3, $s3
		jal printLabyrinth
	
		li $v0, 4
		la $a0, theend
		syscall
	
		addi $v0, $0, 1
		j end_if
	
	other_option:
	addi $v0, $0, 0
	lw $ra, 0($sp)
	lw $a1, 4($sp)
	addi $sp, $sp, 8
	jr $ra
	
	end_if:
	lw $ra, 0($sp)
	lw $a1, 4($sp)
	addi $sp, $sp, 8
	jr $ra
	
makeMove:
	#exw orisma to $a1 = startX ;h alliws $a1 = index
	addi $sp, $sp, -12
	sw $ra, 0($sp)
	sw $s6, 4($sp) #index htan a1 ,pairnw s6
	#sw $s0, 8($sp) #gia na apothikeysw to arxiko index

	li $t5, 42  # *
	li $s4, 35  # #
	li $t7, 64  # @
	
	move $s6, $a1
	bge $a1, $0, nextIf
		j conditions
		
	nextIf:
	addi $t2, $0, 231
	blt $s6, $t2, next_if_labels
		j conditions
		
		conditions:
		addi $v0, $0, 0 #return 0
		j end_makeMove
	
	next_if_labels:
	la $t1, map
	add $t1, $t1, $s6
	lb $t2, ($t1) #map[index]
	
	sw $t1, 8($sp)
	
	li $t3, 46 # .
	li $t4, 80 # P 
	bne $t2, $t3, other_other
		j conditions_lala
		
	other_other:
	bne $t2, $t4, else_if_makeMove
		j conditions_lala
		
		conditions_lala:
		la $t1, map
		add $t1, $t1, $s6
		sb $t5, ($t1)
		
		addi $a1, $s6, 1 # index + 1
		jal makeMove
		move $t3, $v0 #vazoyme se allon kataxwrhth thn timh ths epistrofhs apo thn makeMove
		
		bne $t3, 1, if_label2
			lw $t1, 8($sp) 
			
			la $t1, map
			add $t1, $t1, $s6
			sb $s4, ($t1) 
			addi $v0, $0, 1 #return 1
			j end_makeMove
	
		if_label2:
		add $a1, $s6, $s1
		jal makeMove
		move $t3, $v0 #vazoyme se allon kataxwrhth thn timh ths epistrofhs apo thn makeMove
		
		bne $t3, 1, if_label3
		lw $t1, 8($sp) 
		
		la $t1, map
		add $t1, $t1, $s6
		sb $s4, ($t1)
		addi $v0, $0, 1 #return 1
		j end_makeMove
	
		if_label3:
		addi $a1, $s6, -1
		jal makeMove
		move $t3, $v0 #vazoyme se allon kataxwrhth thn timh ths epistrofhs apo thn makeMove
		
		bne $t3, 1, if_label4
		lw $t1, 8($sp)
		la $t1, map
		add $t1, $t1, $s6
		sb $s4, ($t1)
		addi $v0, $0, 1 #return 1
		j end_makeMove
	
		if_label4:
		sub $a1, $s6, $s1
		jal makeMove
		move $t3, $v0 #vazoyme se allon kataxwrhth thn timh ths epistrofhs apo thn makeMove
			
		bne $t3, 1, else_if_makeMove
		lw $t1, 8($sp)
		la $t1, map
		add $t1, $t1, $s0
		sb $s4, ($t1)
		addi $v0, $0, 1 #return 1
		j end_makeMove
	
	else_if_makeMove:
	la $t1, map
	add $t1, $t1, $s6 #edw to s6 htan a1
	lb $t6, ($t1)
	
	li $t5, 37
	bne $t6, $t7, end_makeMove
	la $t1, map
	add $t1, $t1, $s6
	sb $t5, ($t1)
	addi $v0, $0, 1
	j end_makeMove
	
	end_makeMove:
	lw $t1, 8($sp)
	lw $s6, 4($sp)
	lw $ra, 0($sp)
	addi $sp, $sp, 12
	jr $ra
	
	
usleep:
	move $t1, $a0
	addi $t2, $0, 0  # i
	
	first_sleep_for:
		bge $t2, $t1, end_sleep
		
		addi $t3, $0, 0  # j
		second_sleep_for:
			bge $t3, $t1, end_for_sleep
			addi $t3, $t3, 1
			j second_sleep_for
			
		end_for_sleep:
			addi $t2, $t2, 1
			j first_sleep_for
			
	end_sleep:
	jr $ra
	
read_ch:
	la $t1, 0xffff0000 #receiver control mono giati ayta kanoyn read
	lw      $t0, 0($t1) 
	andi    $t0, $t0, 1
	beq     $t0, $0, read_ch 
	
	la $t2, 0xffff0004 #receiver data
	lw $t3, 0($t2)
	move $v0, $t3
	jr $ra
	
	

