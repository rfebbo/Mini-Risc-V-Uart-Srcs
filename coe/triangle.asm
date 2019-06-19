xor x0,x0,x0
xor x4,x4,x4
xor x3,x3,x3
xor x5,x5,x5
addi x3,x0,3
addi x5,x0,1
tri:
add x4,x4,x3
sub x3,x3,x5
bne x3,x0,tri
exit:
jal x1,exit
