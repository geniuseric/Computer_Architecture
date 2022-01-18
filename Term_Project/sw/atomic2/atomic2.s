.data
lock:   .word  0
string: .word  67, 114, 105, 116, 105, 99, 97, 108, 32, 115, 101, 99, 116, 105, 111, 110, 10
size:   .word  17

.text
.global main
main:
    la s0, lock                # load address of lock
    li t0, 1                   # load swap value  

again:
    lw t1, 0(s0)               # load word of lock
    bne t1, x0, again          # jump to again
    amoswap.w.aq t1, t0, (s0)  # aquire lock
    bne t1, x0, again          # jump to again
    lui	s1, 0x90000            # load immediate
    la s2, string              # load address of string
    lw t1, size                # load word of string size

critical:  
    lw t0, 0(s2)           # load word
    sw t0, 28(s1)          # print word
    addi t1, t1, -1        # size = size - 1
    beq t1, x0, end        # jump to end
    addi s2, s2, 4         # address = address + 4
    j critical             # jump to critical

end:
    amoswap.w.rl x0, x0, (s0)  # release lock
    ret                        # exit
