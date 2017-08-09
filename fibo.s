# This is a MIPS assembly implementation of fibonacci algorithm


main:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	li $a0, 24 # n
	jal fibo
	move $a0, $v0
	li $v0, 1
	syscall # this syscall print fibonacci number to the console
	lw $ra, 0($sp)
	addi $sp, $sp , 4
	jr $ra

fibo:
	li $s0, 1
	bgt $a0, $s0, else # if n <= 1 then return n
	move $v0, $a0 
	jr $ra

else:
	addi $sp, $sp, -8
	sw $ra, 4($sp)
	sw $a0, 0($sp) # current n must be saved because fibo(n - 1)'s call will change its value
	jal fibo1 # call fibo(n - 1)
	lw $a0, 0($sp) # get back current n for fibo( n - 2)
	sw $v0, 0($sp) # current v0 , that contains return value of fibo(n - 1), must be saved  because fibo(n - 2)'s call will change its value 
	jal fibo2 # call fibo(n - 2)
	lw $t0, 0($sp) # get back return value of fibo(n - 1) previously saved and put it in temporary register that will allow to add with fibo(n - 2)'s return value
	add $v0, $v0, $t0 # $v0 = fibo(n - 1) + fibo(n - 2)
	lw $ra, 4($sp)
	addi $sp, $sp, 8
	jr $ra

fibo1:
	addi $a0, $a0, -1
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal fibo
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra

fibo2:
	addi $a0, $a0, -2
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal fibo
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra 