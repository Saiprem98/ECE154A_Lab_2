##############################################################################
# File: mult.s
# Skeleton for ECE 154a project
##############################################################################

	.data
student:
	.asciiz "Sai Kathika, Pete Makrygiannis, Rahul Varghese" 	
	.globl	student
nl:	.asciiz "\n"
	.globl nl


op1:	.word 5				# change the multiplication operands
op2:	.word 2			# for testing.


	.text

	.globl main
main:					# main has to be a global label
	addi	$sp, $sp, -4		# Move the stack pointer
	sw 	$ra, 0($sp)		# save the return address

	move	$t0, $a0		# Store argc
	move	$t1, $a1		# Store argv
				
	li	$v0, 4			# print_str (system call 4)
	la	$a0, student		# takes the address of string as an argument 
	syscall	

	slti	$t2, $t0, 2		# check number of arguments
	bne     $t2, $zero, operands
	j	ready

operands:
	la	$t0, op1
	lw	$a0, 0($t0)
	la	$t1, op2
	lw	$a1, 0($t1)
		

ready:
	jal	multiply		# go to multiply code

	jal	print_result		# print operands to the console

					# Usual stuff at the end of the main
	lw	$ra, 0($sp)		# restore the return address
	addi	$sp, $sp, 4
	jr	$ra			# return to the main program


multiply:
##############################################################################
# Your code goes here.
# Should have the same functionality as running
#	multu	$a1, $a0
#	mflo	$a2
##############################################################################

	move $t0,$zero      
	move $t7, $a0
	move $t6, $a1
	multiplication_loop:
	    andi $t2,$a1,1
	    beq $t0,$zero,loop
	    addu $t0,$t0,$a0  
	loop:
	    sll $a0,$a0,1    
	    srl $a1,$a1,1     
	    bne $a1,$zero,multiplication_loop

	srl $a0,$a0,1 
	move $a2,$a0 
	move $a0, $t7
	move $a1, $t6

##############################################################################
# Do not edit below this line
##############################################################################
	jr	$ra



print_result:
	move	$t0, $a0
	li	$v0, 4
	la	$a0, nl
	syscall

	move	$a0, $t0
	li	$v0, 1
	syscall
	li	$v0, 4
	la	$a0, nl
	syscall

	li	$v0, 1
	move	$a0, $a1
	syscall
	li	$v0, 4
	la	$a0, nl
	syscall

	li	$v0, 1
	move	$a0, $a2
	syscall
	li	$v0, 4
	la	$a0, nl
	syscall

	jr $ra