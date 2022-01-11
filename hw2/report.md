# 171044005-ÜMİT ALTINTAŞ
# Computer Organization: Homework 2




- [171044005-ÜMİT ALTINTAŞ](#171044005-ümi̇t-altintaş)
- [Computer Organization: Homework 2](#computer-organization-homework-2)
  - [Functions](#functions)
        - [globals](#globals)
      - [c++ equivalent:](#c-equivalent)
    - [scan array](#scan-array)
      - [c++ equivalent:](#c-equivalent-1)
    - [max](#max)
    - [sequence](#sequence)
    - [max in array](#max-in-array)
      - [c++ equivalent:](#c-equivalent-2)
    - [fill array](#fill-array)
      - [c++ equivalent:](#c-equivalent-3)
    - [print steps](#print-steps)
  - [Test Cases](#test-cases)
    - [test case 1:](#test-case-1)
    - [test case 2:](#test-case-2)
    - [test case 3:](#test-case-3)
    - [test case 4:](#test-case-4)
    - [test case 5:](#test-case-5)
    - [test case 6:](#test-case-6)
  - [shortcomings](#shortcomings)






Program takes it's inputs manually.
</br>
First assign array to arr1.\
set 1 for all elements of second array.
set its lengt same with first array
set 0 for all elements of third array.
Size must be same for all arrays.

## Functions
##### globals




```mips
arr1:	1, 2, 12, 3, 2, 5, 4, 7, 10
arr2:	.word 1:9 # left part is assign value right part is size
ans_arr: .word  0:9
```

#### c++ equivalent:
```C++
    int a[] = {1, 2, 12, 3, 2, 5, 4, 7, 10};
    int forward[] = {1, 1, 1, 1, 1, 1, 1, 1,1};
    int ansarr[9];
```
### scan array
this loop scans arr1 and writes subsequence lengths to arr2.
It's inputs are arr1 and arr2. It edits arr2.

```mips
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
```

#### c++ equivalent: 
This is the main algorithm.
iterate throug the array and point the current subsequence length. if newcomer is bigger set new one.
```c++
   for (int i = 0; i < 8; i++)
    {
        for (int j = 0; j < i; j++)
        {
            if (a[i] > a[j])
                forward[i] = max(forward[i], forward[j] + 1);
        }
    }
```
### max
this program uses  a max function. this function takes its paremetes from a0 and a1 registers and returns bigger value from v0.
```mips
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
```
### sequence
after the fill the subsequence matrix program runs some operations on it.

first finds longest subsequence length from arr2 and saves it's result to $s3.
After that fills longest subsequence to result array.

And lastly  prints results.
```mips
ans:
jal max_in_array 
jal fill_arr
jal print_length
jal print_new_line
jal print_arr
j exit
```

### max in array
this function find maximum element of an arrray. its input is arr2. result will save to $s3.
```mips 
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
```
#### c++ equivalent:
```c++
  int ans = 0;
    for (int i = 0; i < 8; i++)
    {
        ans = max(ans, forward[i]);
    }
```

### fill array
this function fills result array with longest subsequence.
</br>
It takes 4 input. (ansarr, arr1, arr2, length=$s3).
</br>
saves result to the ansarr.
```mips

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
```


#### c++ equivalent:

```c++
 int j = ans;
    for (int i = 7; i >= 0 && j > 0; i--)
    {

        if (forward[i] == j)
        {
            j--;
            ansarr[j] = a[i];
        }
    }
```

### print steps
```mips
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
```


## Test Cases

### test case 1:

```yaml
1, 2, 12, 3, 2, 5, 4, 7, 10

expected-result:  6-6 
expected-result: 1 2 3 4 7 10 -1 2 3 4 7 10 
```
### test case 2:
```yaml
1, 2, 1, 3,5, 5, 5, 4, 2

expected-result:  4 - 4 
expected-result: 1 2 3 4 - 1 2 3 4 
```

### test case 3:
```yaml
1, 2, 1, 3

expected-result:  3 - 3 
expected-result: 1 2 3  - 1 2 3 
```


### test case 4:
```yaml
3, 2, 1, 0

expected-result:  1 - 1 
expected-result: 0  - 0
```

### test case 5:
```yaml
3, 2, 1, 4, 3, 2, 4, 5

expected-result:  4 - 4 
expected-result: 1 2 4 5  - 1 2 4 5  
```

### test case 6:
```yaml
3

expected-result:  1 - 1
expected-result: 3 - 3
```



## shortcomings

There is no file operations in my program.