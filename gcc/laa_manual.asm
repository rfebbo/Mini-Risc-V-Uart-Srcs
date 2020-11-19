00000000 <_start>:
   0:	00001117          	auipc	sp,0x1
   4:	18010113          	addi	sp,sp,384 # 1180 <_sp0>
   8:	00000097          	auipc	ra,0x0
   c:	00c08093          	addi	ra,ra,12 # 14 <_endloop>
  10:	008000ef          	jal	ra,18 <main>

00000014 <_endloop>:
  14:	0000006f          	j	14 <_endloop>

00000018 <main>:
  18:	00300513          	li	a0,3				# Store matA to registers
	# 000000000000 00000000 01010 0010011
	1c:	00C00593          	li	a1,12
	# 000000001100 00000000 01011 0010011
  20:	00400613          	li	a2,4
	# 000000000100 00000000 01100 0010011
  24:	00500693          	li	a3,5
	# 000000000101 00000000 01101 0010011
  28:	00600713          	li	a4,6
	# 000000000110 00000000 01110 0010011
  2c:	00800793          	li	a5,8
	# 000000001000 00000000 01111 0010011
  30:	00100813          	li	a6,1
	# 000000000001 00000000 10000 0010011
  34:	00000893          	li	a7,0
	# 000000000000 00000000 10001 0010011
  38:	00200913          	li	a8,2
	# 000000000010 00000000 10010 0010011

  3c:	5000010B						msw	a0,matA[0]	# Load matA into LAA
	# 01010 00000 0000000000 00010 0001011
  40:	5840010B						msw	a1,matA[1]
	# 01011 00001 0000000000 00010 0001011
  44:	6080010B						msw	a2,matA[2]
	# 01100 00010 0000000000 00010 0001011
  48:	68C0010B						msw	a3,matA[3]
	# 01101 00011 0000000000 00010 0001011
  4c:	7100010B						msw	a4,matA[4]
	# 01110 00100 0000000000 00010 0001011
  50: 7940010B						msw	a5,matA[5]
	# 01111 00101 0000000000 00010 0001011
  54:	8180010B						msw	a6,matA[6]
	# 10000 00110 0000000000 00010 0001011
  58: 89C0010B						msw	a7,matA[7]
	# 10001 00111 0000000000 00010 0001011
  5c:	9200010B						msw	a8,matA[8]
	# 10010 01000 0000000000 00010 0001011

  60: 00700513          	li	a0,7				# Store matB to registers
  64:	00300593          	li	a1,3
  68: 00800613          	li	a2,8
  6c:	00B00693          	li	a3,11
  70: 00900713          	li	a4,9
  74:	00500793          	li	a5,5
  78: 00600813          	li	a6,6
  7c:	00800893          	li	a7,8
  80: 00400913          	li	a8,4

  84:	5240010B						msw	a0,matB[0]	# Load matB into LAA
	# 01010 01001 0000000000 00010 0001011
  88: 5A80010B						msw	a1,matB[1]
	# 01011 01010 0000000000 00010 0001011
  8c:	62C0010B						msw	a2,matB[2]
	# 01100 01011 0000000000 00010 0001011
  90: 6B00010B						msw	a3,matB[3]
	# 01101 01100 0000000000 00010 0001011
  94:	7340010B						msw	a4,matB[4]
	# 01110 01101 0000000000 00010 0001011
  98: 7B80010B						msw	a5,matB[5]
	# 01111 01110 0000000000 00010 0001011
  9c:	83C0010B						msw	a6,matB[6]
	# 10000 01111 0000000000 00010 0001011
  a0: 8C00010B						msw	a7,matB[7]
	# 10001 10000 0000000000 00010 0001011
  a4:	9440010B						msw	a8,matB[8]
	# 10010 10001 0000000000 00010 0001011

  a8: 0000018B						mm							# Start matrix mult.
  ac:	FBC0008B          	mlw	a5,ctrl			# Read ctrl reg
  b0: 00000013          	nop
  b4:	00000013          	nop
  b8: 00000013          	nop
  bc:	00000013          	nop
  c0: FE0788E3          	beqz	a5,ac			# Loop if still working
	# fc078ee3 = 1111110 00000 01111 000 11101 1100011
	#                 -2  zero    a5 fc3        branch
	# offset[12,10:5], offset[11,4:1]
	# index  = 2109876543210
	# offset = 1111111011010 => -38 / 4 => -9 => just after
	# I want -4 * 4 = -16 = 1111111110000
	# index  = 2109876543210
	# offset = 1111111110000
	# FE0788E3 = 1111111 00000 01111 000 10001 1100011
	#                     zero    a5 fc3        branch

  c4:	0280008B          	mlw	a0,matA[0]	# Read matA from LAA
	# 00000 01010 0000000000 00001 0001011
  c8: 0AC0008B          	mlw	a1,matA[1]
	# 00001 01011 0000000000 00001 0001011
  cc:	1300008B          	mlw	a2,matA[2]
	# 00010 01100 0000000000 00001 0001011
  d0: 1B40008B          	mlw	a3,matA[3]
	# 00011 01101 0000000000 00001 0001011
  d4:	2380008B          	mlw	a4,matA[4]
	# 00100 01110 0000000000 00001 0001011
  d8:	2BC0008B          	mlw	a5,matA[5]
	# 00101 01111 0000000000 00001 0001011
  dc:	3400008B          	mlw	a6,matA[6]
	# 00110 10000 0000000000 00001 0001011
  e0:	3C40008B          	mlw	a7,matA[7]
	# 00111 10001 0000000000 00001 0001011
  e4:	4480008B          	mlw	a8,matA[8]
	# 01000 10010 0000000000 00001 0001011

	38: 00000013          	nop
	ec: 00000013          	nop
	f0: 00000013          	nop
	f4: 00000013          	nop
	f8: 00000013          	nop
  fc:	00000793          	li	a5,0
 100:	00078513          	mv	a0,a5
 104:	00008067          	ret
