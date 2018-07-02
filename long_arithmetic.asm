	.text
main:
	la 		$a0, first 
	nop
	li		$v0, 4	
	nop
	syscall
	
	la 		$a0, x	
	nop
	li		$a1, 1024	
	nop
	li		$v0, 8	
	nop
	syscall
	
	la 		$a0, z	
	nop
	li		$a1, 1024	
	nop
	li		$v0, 8	
	nop
	syscall
	
	la 		$a0, y	
	nop
	li		$a1, 1024	
	nop
	li		$v0, 8	
	nop	
	syscall
	
	la		$t0, x	
	nop				#кол-во символов в X
	li 		$t2, 0	
	nop
for1:							
	lb		$t1, ($t0)	
	nop
	beqz	$t1, end1
	add		$t0, $t0, 1
	add		$t2, $t2, 1
	b		for1
	nop
end1:
	sub		$t0, $t0, $t2
	sub		$t2, $t2, 1
	move	$t6, $t0
	move	$t4, $t2
	
	la		$t0, y	
	nop				#кол-во символов в Y
	li 		$t2, 0	
	nop
for3:							
	lb		$t1, ($t0)	
	nop
	beqz	$t1, end3	
	nop
	add		$t0, $t0, 1
	add		$t2, $t2, 1
	b		for3
	nop
end3:
	sub		$t0, $t0, $t2
	sub		$t2, $t2, 1
	move		$t7, $t0
	move		$t5, $t2
	
	la		$t0, z	
	nop				#go to Div
	lb		$t1, ($t0)	
	nop
	beq		$t1, 47, Div		
	nop
	
	move	$t8, $t5
	move 	$t3, $t4			#reverse X
	move 	$t2, $t4
	la		$t4, u	
	nop
	la		$t0, x	
	nop
	add		$t0, $t0, $t2
	sub		$t0, $t0, 1
for2:
	beqz	$t3, end2
	lb		$t5, ($t0)	
	nop
	sb		$t5, 0($t4)	
	nop
	add		$t4, $t4, 1
	sub		$t0, $t0, 1
	sub		$t3, $t3, 1
	b		for2
	nop
end2:
	sub		$t4, $t4, $t2
	move	$t7, $t4
	move	$t6, $t2
		
	la		$t4, w	
	nop				#reverse Y
	move 	$t3, $t8
	move 	$t2, $t8				
	la		$t0, y	
	nop
	add		$t0, $t0, $t2
	sub		$t0, $t0, 1
for4:
	beqz	$t3, end4	
	nop
	lb		$t5, ($t0)	
	nop
	sb		$t5, 0($t4)	
	nop
	add		$t4, $t4, 1
	sub		$t0, $t0, 1
	sub		$t3, $t3, 1
	b		for4
	nop
end4:
	sub		$t4, $t4, $t2
	move	$t5, $t6
	move	$t6, $t4
	move	$t4, $t2
	
	la		$t0, z	
	nop				
	lb		$t1, ($t0)	
	nop
	beq		$t1, 42, Mult		#go to Mult
	nop
	
	li		$t8, 0	
	nop		
	bgt		$t4, $t5, lab1		#Если длины чисел не равны сежду собой, дополним нулями начало
	nop
	li		$t8, 1	
	nop
	move	$t0, $t6
	move	$t6, $t7
	move	$t7, $t0
	move	$t0, $t4
	move	$t4, $t5
	move	$t5, $t0
lab1:
	bne		$t8, 0, cont11
	nop
	la 		$a0, minus	
	nop
	li		$v0, 4	
	nop
	syscall
cont11:
	add		$t7, $t7, $t5
	sub		$t0, $t4, $t5
	li		$t1, 48	
	nop
for5:
	beqz	$t0, end5
	sb		$t1, 0($t7)	
	nop
	add		$t7, $t7, 1
	sub		$t0, $t0, 1
	b		for5
	nop
end5:
	sub		$t7, $t7, $t4	
	move 	$t5, $t4
	
	li 		$t0, 0	
	nop
	li		$t1, 0	
	nop
	
	la		$t0, z	
	nop				
	lb		$t1, ($t0)	
	nop
	beq		$t1, 43, Plus		#go to Plus
	nop	
	beq		$t1, 45, Minus		#go to Minus
	nop	
################################################################
Plus:
	li		$t0, 0	
	nop
	li		$t1, 0	
	nop
for6:
	beq		$t0, $t5, end6	
	nop
	lb		$t2, ($t6)	
	nop
	add		$t1, $t1, $t2
	lb		$t2, ($t7)	
	nop
	add		$t1, $t1, $t2
	sub		$t1, $t1, 96
	move	$t2, $t1
	div		$t2, $t2, 10
	mul		$t2, $t2, 10
	sub		$t2, $t1, $t2
	div		$t1, $t1, 10
	add		$t2, 48
	sb		$t2, ($t6)	
	nop
	
	add		$t6, $t6, 1
	add		$t7, $t7, 1
	add		$t0, $t0, 1
	b		for6
	nop
end6:
	beq		$t1, 0, lab2
	nop
	add		$t1, 48
	add 	$t5, $t5, 1
	sb		$t1, ($t6)	
	nop
	add		$t6, $t6, 1
	nop
lab2:	
	sub		$t6, $t6, $t5
	
	b		writeln
	nop
############################################
Minus:
	move	$t0, $t5
	sub		$t0, $t0, 1
	add		$t6, $t6, $t0
	add		$t7, $t7, $t0
for20:
	beq		$t0, -1, cont20
	nop
	lb		$t2, ($t6)	
	nop
	lb		$t3, ($t7)	
	nop
	bne		$t2, $t3, end20
	nop
	sub		$t6, $t6, 1
	sub		$t7, $t7, 1
	sub		$t0, $t0, 1
	b		for20
	nop		
end20:
	bgt		$t2, $t3, cont20
	nop
	la 		$a0, minus	
	nop
	li		$v0, 4	
	nop
	syscall
	move	$t1, $t6
	move	$t6, $t7
	move	$t7, $t1
cont20:
	sub		$t6, $t6, $t0
	sub		$t7, $t7, $t0
	li		$t0, 0	
	nop
	li		$t1, 48	
	nop
for7:
	beq		$t0, $t5, end7	
	nop
	lb		$t2, ($t6)	
	nop
	add		$t1, $t1, $t2
	lb		$t2, ($t7)	
	nop
	sub 	$t1, $t1, $t2
	li		$t3, 0	
	nop
	bge		$t1, 48, cont1	#if
	nop
	add		$t1, $t1, 10
	li		$t3, 1	
	nop
cont1:
	sb		$t1, ($t6)
	li		$t1, 48
	sub		$t1, $t1, $t3
	
	add		$t6, $t6, 1
	add		$t7, $t7, 1
	add		$t0, $t0, 1
	b		for7
	nop
end7:
	sub		$t6, $t6, $t5
	nop
	
	b		writeln
	nop
#####################################################
Mult:
	li 		$t0, 0
	la		$t9, tem
for8:
	beq		$t0, $t4, end8
	nop
	li 		$t2, 0	
	nop
	lb		$t3, ($t6)	
	nop
	sub		$t3, $t3, 48
	li		$t1, 0	
	nop	
	for9:
		beq		$t1, $t5, end9
		nop
		lb		$t8, ($t7)	
		nop
		sub		$t8, $t8, 48
		mul		$t8, $t3, $t8
		add		$t2, $t2, $t8
		lb		$t8, ($t9)	
		nop
		beq		$t8, 0, cont4
			nop
			sub		$t8, $t8, 48
		cont4:
		add		$t2, $t2, $t8
		
		move	$t8, $t2
		div		$t8, $t8, 10
		mul		$t8, $t8, 10
		sub		$t8, $t2, $t8
		div		$t2, $t2, 10
		add		$t8, $t8, 48
		sb		$t8, ($t9)	
		nop

		add		$t9, $t9, 1
		add		$t1, $t1, 1
		add		$t7, $t7, 1
		b		for9
		nop
	end9:
	li		$t8, 0	
	nop
	while1:
		beq		$t2, 0, endWhile1
		nop
		lb		$t3, ($t9)	
		nop
		beq		$t3, 0, cont5
			nop
			sub		$t3, $t3, 48
		cont5:
		add		$t2, $t2, $t3
		
		move	$t3, $t2
		div		$t3, $t3, 10
		mul		$t3, $t3, 10
		sub		$t3, $t2, $t3
		div		$t2, $t2, 10
		add		$t3, $t3, 48
		sb		$t3, ($t9)	
		nop
		
		add		$t9, $t9, 1
		add		$t8, $t8, 1
		b		while1
		nop
	endWhile1:
	
	sub		$t7, $t7, $t5
	sub		$t9, $t9, $t5
	sub		$t9, $t9, $t8
	
	add		$t9, $t9, 1
	add		$t0, $t0, 1
	add		$t6, $t6, 1
	b		for8
	nop
end8:
	sub		$t9, $t9, $t4
	add		$t5, $t4, $t5
	add		$t9, $t9, $t5
	sub		$t9, $t9, 1
	lb		$t0, ($t9)	
	nop
	
	bne		$t0, 0, cont3
		nop	
		sub		$t9, $t9, 1
		sub		$t5, $t5, 1
	cont3:
	add		$t9, $t9, 1
	sub		$t9, $t9, $t5
	move	$t6, $t9
	
	b		writeln
	nop
##########################################################################
Div:	
	sub		$t6, $t6, 1
	bge		$t4, $t5, cont15
	nop
	la		$a0, nul	
	nop
	li		$v0, 4	
	nop
	syscall
	move	$a0, $t6
	li		$v0, 4	
	nop
	syscall
	jr		$ra
	nop
cont15:
	sub		$t4, $t4, $t5
	add		$t4, $t4, 1
	la		$t9, ans	
	nop

	li		$t0, 48	
	nop
	sub		$t6, $t6, 1
	sub		$t7, $t7, 1
	add		$t5, $t5, 1
	sb		$t0, ($t6)
	nop
	sb		$t0, ($t7)	
	nop

	li		$t0, 0	
	nop
for10:
	beq		$t0, $t4, end10
	nop
	li		$t2, 48	
	nop
	sb		$t2, ($t9)	
	nop
	
	while2:
		li		$t1, 0	
		nop
		for11:
			beq		$t1, $t5, end11
			nop
		
			lb		$t3, ($t6)	
			nop
			lb		$t8, ($t7)	
			nop
			bne		$t3, $t8, end11
			nop
		
			add		$t6, $t6, 1
			add		$t7, $t7, 1
			add		$t1, $t1, 1
			b		for11
			nop
		end11:
		sub		$t6, $t6, $t1
		sub		$t7, $t7, $t1

		blt		$t3, $t8, endWhile2
		nop
		
		lb		$t1, ($t9)	
		nop
		add		$t1, $t1, 1
		sb		$t1, ($t9)	
		nop
		
		li		$t1, 0	
		nop
		li		$t2, 48	
		nop
		add		$t6, $t6, $t5
		sub		$t6, $t6, 1
		add		$t7, $t7, $t5
		sub		$t7, $t7, 1		
		for12:
			beq		$t1, $t5, end12
			nop
			
			li		$t8, 0	
			nop
			lb		$t3, ($t6)	
			nop
			add		$t2, $t2, $t3
			lb		$t3, ($t7)	
			nop
			sub		$t2, $t2, $t3
			bge		$t2, 48, cont6
				nop
				add		$t2, 10
				li		$t8, 1
			cont6:
			sb		$t2, ($t6)	
			nop
			li		$t2, 48	
			nop
			sub		$t2, $t2, $t8
			
			add		$t1, $t1, 1
			sub		$t6, $t6, 1
			sub		$t7, $t7, 1
			
			b		for12
			nop
		end12:
		add		$t6, $t6, 1
		add		$t7, $t7, 1
		
		b		while2
		nop
	endWhile2:
	
	add		$t6, $t6, 1
	add		$t0, $t0, 1
	add		$t9, $t9, 1
	
	b		for10
	nop
end10:
	sub		$t9, $t9, $t4
	
for13:
	lb		$t0, ($t9)	
	nop
	bne		$t0, 48, end13
	nop
	beq		$t4, 1, end13
	nop
	
	add		$t9, $t9, 1
	sub		$t4, $t4, 1

	b		for13
	nop
end13:
for14:	
	lb		$t0, ($t6)	
	nop
	bne		$t0, 48, end14
	nop
	beq		$t5, 2, end14
	nop
	
	add		$t6, $t6, 1
	sub		$t5, $t5, 1

	b		for14
	nop
end14:

	move	$a0, $t9
	li		$v0, 4	
	nop
	syscall
	la		$a0, nl	
	nop
	li		$v0, 4	
	nop
	syscall
	move	$a0, $t6
	li		$v0, 4	
	nop
	syscall
	
	jr		$ra
	nop
##########################################################################
writeln:
	add		$t6, $t6, $t5
end_zero:
	sub		$t6, $t6, 1
	lb		$t2, ($t6)	
	nop
	bne		$t2, 48, cont2	
	nop
	beq		$t5, 1, cont2
	nop
	sub		$t5, $t5, 1
	b		end_zero
	nop
cont2:
	add		$t6, $t6, 1
	sub		$t6, $t6, $t5
	
	move	$t0, $t6			#reverse answer
	move	$t3, $t5
	move 	$t2, $t5
	la		$t4, ans	
	nop
	add 	$t0, $t0, $t2
	sub		$t0, $t0, 1
for_end:
	beqz	$t3, end_end	
	nop
	lb		$t5, ($t0)	
	nop
	sb		$t5, 0($t4)	
	nop
	add		$t4, $t4, 1
	sub		$t0, $t0, 1
	sub		$t3, $t3, 1
	b		for_end
	nop
end_end:
	sub		$t4, $t4, $t2
	move	$t6, $t4

	move	$a0, $t6
	li		$v0, 4	
	nop
	syscall
	la		$a0, nl	
	nop
	li		$v0, 4	
	nop
	syscall
	
	jr $ra
	nop
############################################################
	.data
first:	.asciiz "On the line write first number, on the second line write simbol of operation(+, -, *, /), on the third line write second number\n"
nul: 	.asciiz "0\n"
nl: 	.asciiz "\n"
minus: 	.asciiz "-"
remind:	.space 1024
ans:	.space 1024
tem:	.space 1024
x:		.space 1024
y:		.space 1024
z:		.space 1024
u:		.space 1024
w:		.space 1024
