                .data
string:         .space 12
capacity:       .space 4 
number:         .asciiz "Hexidecimal Number:0x"
message:        .asciiz "1.Addition\n2.Subtraction\n3.Multiplication\n4.Division\n"
choice:         .asciiz "Enter your choice:"  
little_endian:  .asciiz "Little Endian:0x"
big_endian:     .asciiz "Big Endian:0x"
wrong:          .asciiz "Something went wrong! The Number must be 32bit, try something smaller.\n"
error:          .asciiz "An error occured! Try to type a valid number.\n"
false:          .asciiz "Something is off! Enter a valid option.\n"
overflow:       .asciiz "Overflow Detected! Try something different.\n"
underflow:      .asciiz "Underflow Detected! Try something different.\n"
final:          .asciiz "1.Repeat\n2.Exit\n"
remainder:      .asciiz "Decimal Remainder:"
answer:         .asciiz "Enter your answer:"
pattern:        .asciiz "---------\n"
newline:        .asciiz "\n"



                .text
                .globl main

main:           li $t4, 0
                
                li $v0, 4               
                la $a0, number           
                syscall
                la $a0, string
                li $a1, 12
                li $v0, 8
                syscall
                jal process
                move $t5,$v0

                li $t4, 1

flag:           li $v0, 4               
                la $a0, number           
                syscall
                la $a0, string
                li $a1, 12
                li $v0, 8
                syscall
                jal process
                move $t6,$v0

                li $t9,0

menu:           la $a0, pattern
                li $v0, 4
                syscall
                la $a0, message
                li $v0, 4
                syscall
                la $a0, pattern
                li $v0, 4
                syscall
                la $a0, choice
                li $v0, 4
                syscall
                li $v0, 5
                syscall
                move $t2,$v0
                la $a0, pattern
                li $v0 ,4
                syscall

                beq $t2,0,again
                beq $t2,1,addition
                beq $t2,2,subtraction
                beq $t2,3,multiplication
                beq $t2,4,division
                bgt $t2,4,again

again:          la $a0, false
                li $v0, 4
                syscall
                j menu

addition:       j platinum

subtraction:    j magnetite

multiplication: j uranium

division:       j aluminum

#Start Process
process:        la $t0, string
                li $t1, 0  

length:         lb $t2, 0($t0)           
                beq $t2  10, pause
                beq $t2,$zero, pause
                addi $t1,$t1,1
                addi $t0,$t0,1
                j length

pause:          ble $t1, 8, reset
                la $a0, wrong
                li $v0, 4
                syscall
                beq $t4, 1,flag
                j main

reset:          la $t0, string
                   

digit:          lb $t2, 0($t0)
                beq $t2  10, start
                beq $t2,$zero, start

                blt $t2, 48, stop    
                ble $t2, 57, resume

                blt $t2, 65, stop
                ble $t2, 70, resume

                blt $t2, 97, stop 
                ble $t2, 102, resume

stop:           la $a0, error
                li $v0, 4
                syscall
                beq $t4, 1,flag
                j main

resume:         addi $t0, $t0, 1         
                j digit

start:          li $t3,0
                la $t0, string           

convert:        lb $t2, 0($t0)           
                beq $t2, 10, finish     
                beq $t2, $zero, finish   
                blt $t2, 58, one            
                blt $t2, 91, two            
                j three                     

one:            sub $t4, $t2, 48         
                j update

two:            sub $t4, $t2, 55         
                j update

three:          sub $t4, $t2, 87         

update:         mul $t3, $t3, 16        
                add $t3, $t3, $t4   
                addi $t0, $t0, 1         
                j convert

finish:         move $v0, $t3
                jr $ra
#End Process

#Start Copper
copper:         bne $t4,1,bauxite
                la $t0, string
                move $t1,$t8
                j ruby

bauxite:        la $t0, string
                move $t1,$t7
                j ruby

ruby:           li $t2, 0
                li $t3, 0

gold:           beq $t1, $zero, emerald
                and $t3, $t1, 0xF                   
                blt $t3, 10, iron  
                add $t3, $t3, 55
                j store

iron:           add $t3, $t3, 48     

store:          sb $t3, 0($t0)           
                addi $t0, $t0, 1         
                add $t2, $t2, 1         
                srl $t1, $t1, 4
                j gold

emerald:        la $t0, string           
                add $t3, $t0, $t2        
                sub $t3, $t3, 1

reverse:        bge $t0, $t3, big      
                lb $t1, 0($t0)             
                lb $t2, 0($t3)             
                sb $t1, 0($t3)             
                sb $t2, 0($t0)             
                addi $t0, $t0, 1           
                addi $t3, $t3,-1           
                j reverse

big:            beq $t4,1,little
                la $a0,big_endian
                li $v0,4
                syscall            
                la $a0, string
                li $v0, 4
                syscall

                la $a0, newline
                li $v0, 4
                syscall

                j transformation

little:         la $a0,little_endian
                li $v0,4
                syscall            
                la $a0, string
                li $v0, 4
                syscall

                la $a0, newline
                li $v0, 4
                syscall

                j recall

transformation: la $t0, capacity
                move $t1,$t7
                sw $t1,($t0)

                rol $t0,$t1,8
		        li $t2,0x00FF00FF
		        and $t8,$t0,$t2

		        ror $t0,$t1,8
		        not $t2,$t2
		        and $t0,$t0,$t2
		        or  $t8,$t8,$t0

		        la $t0,capacity
		        sw $t8, ($t0)
                add $t4,$t4,1
                beq $t4,1,copper

recall:         jr $ra
#End Copper
		        

#Start Platinum
platinum:       blt $t5,$zero,quartz
                blt $t6,$zero,sulpher
                li $t2, 0x7FFFFFFF
                sub $t2, $t2, $t6
                ble $t5, $t2, sulpher
                j over

quartz:         bge $t5,$zero,sulpher
                bge $t6,$zero,sulpher
                li $t2, 0x80000000
                sub $t2, $t2, $t6
                bge $t5, $t2, sulpher
                j under

sulpher:        add $t7, $t5, $t6
                j display
#End Platinum

#Start Magnetite
magnetite:      sub $t6, $zero, $t6
                jal platinum
#End Magnetite

#Start Uranium
uranium:        beq $t5, $zero, jadite     
                beq $t6, $zero, jadite     
                
                li $t2, 0x7FFFFFFF         
                div $t2, $t2, $t6          
                mflo $t3                   
                bgt $t5, $t3, over         

                li $t2, 0x80000000         
                div $t2, $t2, $t6          
                mflo $t3                   
                blt $t5, $t3, under                      

jadite:         mul $t7, $t5, $t6          
                j display
#End Uranium

#Start Aluminum
aluminum:       beq $t6, $zero, under
                li $t2, -1
                bne $t5, 0x80000000, coal
                bne $t6, $t2, coal
                j over

coal:           div $t5, $t6
                mflo $t7
                mfhi $t9
                j display
#End Aluminum

over:           la $a0, overflow
                li $v0, 4
                syscall
                la $a0, pattern
                li $v0, 4
                syscall
                j main

under:          la $a0, underflow
                li $v0, 4
                syscall
                la $a0, pattern
                li $v0, 4
                syscall
                j main

display:        li $t4,0
                jal copper
                beq $t9,0,fresh

                la $a0,newline
                li $v0,4
                syscall

                la $a0,remainder
                li $v0,4
                syscall
                move $a0,$t9
                li $v0,1
                syscall

                la $a0,newline
                li $v0,4
                syscall
                j fresh

refresh:        la $a0, false
                li $v0,4
                syscall   

fresh:          la $a0, pattern
                li $v0,4
                syscall
                la $a0, final
                li $v0,4
                syscall
                la $a0, pattern
                li $v0,4
                syscall
                la $a0, answer
                li $v0,4
                syscall
                li $v0,5
                syscall
                move $t0,$v0
                la $a0, newline
                li $v0,4
                syscall
                beq $t0,0,refresh
                beq $t0,1,main
                beq $t0,2,exit
                bgt $t0,2,refresh

exit:           li $v0, 10 
                syscall