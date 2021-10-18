.data
data: .word 2, 3, 8, 11, 13, 19  # data[] = {2, 3, 8, 11, 13, 19}
size: .word 6                    # array size = 6
tar:  .word 13                   # target = 13  
str:  .string "The insert position is "

.text
# s1 = data base address
# s2 = array size
# s3 = target
# s4 = index
# t0 = down
# t1 = up
# t2 = mid
# t3 = address offset
# t4 = date point address
# t5 = data[mid]

main:
    la   s1, data        # s1 = address
    lw   s2, size        # s2 = 6
    lw   s3, tar         # s3 = 13
    add  t0, x0, x0      # t0 = 0
    addi t1, s2, -1      # t1 = size - 1 = 5
    jal  ra, loop        # jump and link to loop
    jal  ra, print       # jump and link to print
    li   a7, 10          # end program
    ecall

loop:    
    add  t2, t0, t1      # mid = down + up
    srli t2, t2, 1       # mid = mid / 2    
    slli t3, t2, 2       # offset = mid * 4
    add  t4, s1, t3      # point address = base address + offset
    lw   t5, 0(t4)       # t5 = data[mid]    
    beq s3, t5, equal    # if target == data[mid], go to equal
    blt s3, t5, less     # if target < data[mid], go to less
    addi t0, t2, 1       # if target > data[mid], down = mid + 1 
    j end                # jump to end
    less:             
        addi t1, t2, -1  # if target < data[mid], up = mid - 1    
    end:
        bge t1, t0, loop # if up >= down, go to loop
        mv s4, t0        # index = down
        ret              # return to main
    equal:
        mv s4, t2        # index = mid
        ret              # return to main

print:
    la  a0, str          # load string
    li  a7, 4            # print string
    ecall
    add a0, s4, x0       # load result
    li  a7, 1            # print integer
    ecall
    ret                  # return to main