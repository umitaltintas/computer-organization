
.data # data section
arr1: .word	1, 2, 12, 3, 2, 5, 4, 7, 10
arr2:	.word 1:9
ans_arr: .word  0:9
size: 9
iterator:0
NL:     .asciiz "\n"
.text # code section



la		$s0, arr1		# 
la		$s1, arr2		# 
lw		$s2, iterator		# 
lw		$s4, size		# 




scan_arrray:
bge		$s2, $s4, ans	# if $s2 >= $s4 then ans
li		$t3, 0		# $t3 = 0,    j=0

scan_array_inner_loop:
bge		$t3, $s2, .incr	# if $t3 >= $s2 then .incr
sll		$t7, $t3, 2			# $t7 = $t3 << 2
sll		$t8, $s2, 2			# $t8 = $s2 << 2

lw		$t4, arr1($t7) 		# $t4=arr1[j]
lw		$t5, arr1($t8)		# $t5=arr1[i]
addi	$t3, $t3, 1			# $t3 = $t3 + 1
bge		$t4, $t5, scan_array_inner_loop # if $t4 >= $t5 then inner loop
lw		$a1, arr2($t8)		# a1=arr2[i]
lw		$a0, arr2($t7)		# a0=[arr2[j]
addi	$a0, $a0, 1			# $a0 = $a0 + 1
jal		max		# jump to max and save position to $ra v0=max(arr2[i], arr2[j] + 1)
sw		$v0, arr2($t8)		#  arr2[i]=v0, arr2[i]=max
b scan_array_inner_loop			# $s2 = $s2 + 1, i++
.incr:
addi	$s2, $s2, 1			# $s2 = $s2 + 1
j scan_arrray


max:
slt     $v0,$a1,$a0
bne     $v0,$0,L2
or      $v0,$zero,$a1
b       L3
L2:
or      $v0,$zero,$a0
b		L3			# branch to L3
        
L3:
jr       $ra


ans:
jal max_in_array
jal fill_arr
jal print_length
jal print_new_line
jal print_arr
j exit





max_in_array: 
la $s0, arr2   # starting address of arr2 in $s0  
lw $s1, size   # number of elements in $s1 
li $s2, 0   # i in $s2   
li $s3, 0   # max in $s3   
li $s4, -1   # index in $s4 
 
.max_in_array_loop:  
sll $t1, $s2, 2  # $t1 = i * 4; 
add $t1, $t1, $s0 # $t1 = i * 4 + $s0  
lw $t0, 0($t1)  # $t0 = A[i] 
slt $t2, $t0, $s3   # $t2 = 1 if $t0  < $s3. $t2 = 0 if $t0 >=  $s3.  
bne $t2, $zero, .max_in_array_loop_inner # if ($t2 != 0), s3 is still max, goto max_in_array_loop_inner 
ori $s3, $t0, 0   # update max value 
ori $s4, $s2, 0  # update max  index 
 
.max_in_array_loop_inner: 
addi $s2, $s2, 1   # i = i + 1 
bne $s2, $s1, .max_in_array_loop # if (i != $s1), go back to 
jr $ra


fill_arr:
or		$t3, $s3, $zero		# $t3 = $s3 | $zero
lw		$t1, size		# $t1 = $s4 | $zero
addi	$t1, $t1, -1			# $t1 = $t1 + -1

.fill_arr_loop:
blt		$t1, $zero, .finish_fill_array	# if $t1<= $zero then finish_fill_array
ble		$t3, $zero, .finish_fill_array	# if $t3 <= $zero then .finish_fill_array
sll		$t0, $t1, 2			# $t0 = $t1 << 2
lw		$t2, arr2($t0)		# 
bne		$t2, $t3, .fill_arr_last_step	# if $t2 != $t3 then fill_arr_last_step
addi	$t3, $t3, -1			# $t3 = $t3 + -1
sll		$t4, $t3, 2			# $t4 = $t3 << 2
lw		$t5, arr1($t0)		# 
sw		$t5, ans_arr($t4)		# 
j		.fill_arr_last_step				# jump to .fill_arr_last_step

.fill_arr_last_step:
addi	$t1, $t1, -1			# $t1 = $t1 + -1
j .fill_arr_loop

.finish_fill_array:
jr		$ra					# jump to $ra










print_length:
li $v0, 1
move $a0, $s3
syscall 
jr $ra


print_arr:
    li      $t0, 0
    la      $t1, ans_arr
    or		$t2, $zero, $s3		# 
    
print_arr_loop:
    bge     $t0, $s3, exit_print_arr

    # load word from addrs and goes to the next addrs
    lw      $t2, 0($t1)
    addi    $t1, $t1, 4

    # syscall to print value
    li      $v0, 1      
    move    $a0, $t2
    syscall
    # optional - syscall number for printing character (space)
    li      $a0, 32
    li      $v0, 11  
    syscall


    #increment counter
    addi    $t0, $t0, 1
    j      print_arr_loop


exit_print_arr:
jr $ra

print_new_line:
li $v0, 4       # you can call it your way as well with addi 
la $a0, NL       # load address of the string
syscall
jr		$ra					# jump to $ra


exit:
li  $v0, 10
syscall 
