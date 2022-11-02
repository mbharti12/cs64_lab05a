.data

krabby: .word 1 2 3 4 5 6 7 8 9 10

carray: .word 0:10

marray: .word 0:10

.text
main:
	la $a0,krabby
	li $a1,10

	la $a2,carray
	la $a3,marray
	
	#fill in your loop here
	#feel free to use 2 loops if you need to
	$t5 


	j exit

secret_formula_apply:
	li $t0 7
	mult $a0 $a1

	#n
	mflo $t1
	li $t2 0

	j pow_loop

secret_formula_remove:
	li $t0 3
	mult $a0 $a1

	#n
	mflo $t1
	li $t2 0

	j pow_loop

pow_loop:
	beq $t2 $t0 function_end
    mult $t3 $a2
    mflo $t3
    addiu $t2 1
    j pow_loop

function_end:
	div $t3 $t1
	mfhi $t4
	move $v0 $t4
	jr $ra









exit:
	li $v0, 10
	syscall


