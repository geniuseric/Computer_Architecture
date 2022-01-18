.data
array:  .word  2, 5
string: .word  82, 101, 115, 117, 108, 116, 32, 50, 32, 43, 32, 53, 32, 61, 32
size:   .word  15
base:   .word  48

.text
.global main
main:
    la s0, array           # load address of array
    lr.w t0, (s0)          # load first word
    lw t1, 4(s0)           # load second word
    add t0, t0, t1         # add two words
    sc.w t1, t0, (s0)      # store result  
    bne t1, x0, end        # jump to end
    lui	s0, 0x90000        # load immediate
    la s1, string          # load address of string
    lw t1, size            # load word of string size

print_str:    
    lw t2, 0(s1)           # load word
    sw t2, 28(s0)          # print word
    addi t1, t1, -1        # size = size - 1
    beq t1, x0, print_res  # jump to print_int
    addi s1, s1, 4         # address = address + 4
    j print_str            # jump to print_str

print_res:
    lw t1, base            # load word of base 
    add t1, t0, t1         # add result and base        
    sw t1, 28(s0)          # print a word
    li t1, 10              # load immediate of next line
    sw t1, 28(s0)          # print next line
    ret                    # exit

end:
    ret                    # exit
