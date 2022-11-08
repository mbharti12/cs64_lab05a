.data

krabby: .word 1 2 3 4 5 6 7 8 9 10
#krabby: .word 252 126 21 1 1 1 1 1 1 1

#carray: .word 0:10
carray: .word 37 23 22 1 1 1 1 1 1 1

marray: .word 0:10

debug: .asciiz "DEBUGGG"

encrypted: .asciiz "Encrypted: "
decrypted: .asciiz "Decrypted: "
comma: .asciiz ", "
newline: .asciiz "\n"

.text
main:
	la $a0,krabby
	li $a1,10

	la $a2,carray
	la $a3,marray
	
	#fill in your loop here
	#feel free to use 2 loops if you need to
	li $t5 3
	li $t6 11
	li $t7 0
	li $t8 40

	#store argument variables into s registers
	#use $t9 for offsetting address to store in array
	move $s0 $a0
	move $s2 $a2
	move $s3 $a3

	move $s4 $a0
	move $s5 $a2
	move $s6 $a3

	j main_loop

	li $v0 1
	la $a0 debug
	syscall

main_loop:
	beq $t7 $t8 print_encrypted
	move $a0 $t5
	move $a1 $t6

	#store arr[i] in $a2
	#lw $a2 0($s0)

	#jal secret_formula_apply

	#store $v0 in c_arr(i)
	#sw $v0 0($s2)

	#store c_arr[i] in $a2
	lw $a2 0($s2)

	jal secret_formula_remove

	#store $v0 in m_arr[i]
	sw $v0 0($s3)

    addiu $t7 $t7  4
	addiu $s0 $s0  4
	addiu $s2 $s2  4
	addiu $s3 $s3  4

    j main_loop

print_encrypted:
	li $v0 4
	la $a0 encrypted
	syscall

	li $t0 0
	li $t1 40

	j print_encrypted_loop

print_encrypted_loop:
	bge $t0 $t1 print_decrypted
	lw $t2 0($s5)

	li $v0 1
	move $a0 $t2
	syscall

	addiu $t0 $t0 4
	addiu $s5 $s5 4

	#if the i is less than 40, then don't include comma
	#beq $t0 $t1 print_decrypted

	beq $t0 $t1 skip_comma

	li $v0 4
	la $a0 comma
	syscall

	skip_comma:

	j print_encrypted_loop
	
print_decrypted:
	li $v0 4
	la $a0 newline
	syscall

	li $v0 4
	la $a0 decrypted
	syscall

	li $t0 0
	li $t1 40

	j print_decrypted_loop

print_decrypted_loop:
	beq $t0 $t1 exit
	lw $t2 0($s6)

	li $v0 1
	move $a0 $t2
	syscall

	addiu $t0 $t0 4 
	addiu $s6 $s6 4

	#if the i is less than 40, then don't include comma
	#beq $t0 $t1 exit
	
	beq $t0 $t1 skip_comma_2

	li $v0 4
	la $a0 comma
	syscall

	skip_comma_2:

	j print_decrypted_loop

secret_formula_apply:
	li $t0 7
	mult $a0 $a1

	#n
	mflo $t1
	li $t2 0

	li $t3 1

	j pow_loop

secret_formula_remove:
	li $t0 3
	mult $a0 $a1

	#n
	mflo $t1
	li $t2 0

	li $t3 1

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
	li $v0 10
	syscall


