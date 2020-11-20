
laa.elf:     file format elf32-littleriscv


Disassembly of section .text:

00000000 <_start>:
   0:	00002117          	auipc	sp,0x2
   4:	d8010113          	addi	sp,sp,-640 # 1d80 <_sp0>
   8:	00000097          	auipc	ra,0x0
   c:	00c08093          	addi	ra,ra,12 # 14 <_endloop>
  10:	008000ef          	jal	ra,18 <main>

00000014 <_endloop>:
  14:	0000006f          	j	14 <_endloop>

00000018 <main>:
  18:	f6010113          	addi	sp,sp,-160
  1c:	08112e23          	sw	ra,156(sp)
  20:	08812c23          	sw	s0,152(sp)
  24:	0a010413          	addi	s0,sp,160
  28:	2c4000ef          	jal	ra,2ec <uart_init>
  2c:	000017b7          	lui	a5,0x1
  30:	d307a683          	lw	a3,-720(a5) # d30 <__modsi3+0x50>
  34:	d3078713          	addi	a4,a5,-720
  38:	00472703          	lw	a4,4(a4)
  3c:	fcd42a23          	sw	a3,-44(s0)
  40:	fce42c23          	sw	a4,-40(s0)
  44:	d3078793          	addi	a5,a5,-720
  48:	0087d703          	lhu	a4,8(a5)
  4c:	fce41e23          	sh	a4,-36(s0)
  50:	00a7c783          	lbu	a5,10(a5)
  54:	fcf40f23          	sb	a5,-34(s0)
  58:	fd440793          	addi	a5,s0,-44
  5c:	00078513          	mv	a0,a5
  60:	454000ef          	jal	ra,4b4 <uart_print>
  64:	fe042423          	sw	zero,-24(s0)
  68:	fa042823          	sw	zero,-80(s0)
  6c:	fa042a23          	sw	zero,-76(s0)
  70:	fa042c23          	sw	zero,-72(s0)
  74:	fa042e23          	sw	zero,-68(s0)
  78:	fc042023          	sw	zero,-64(s0)
  7c:	fc042223          	sw	zero,-60(s0)
  80:	fc042423          	sw	zero,-56(s0)
  84:	fc042623          	sw	zero,-52(s0)
  88:	fc042823          	sw	zero,-48(s0)
  8c:	000017b7          	lui	a5,0x1
  90:	d3c7a803          	lw	a6,-708(a5) # d3c <__modsi3+0x5c>
  94:	d3c78713          	addi	a4,a5,-708
  98:	00472503          	lw	a0,4(a4)
  9c:	d3c78713          	addi	a4,a5,-708
  a0:	00872583          	lw	a1,8(a4)
  a4:	d3c78713          	addi	a4,a5,-708
  a8:	00c72603          	lw	a2,12(a4)
  ac:	d3c78713          	addi	a4,a5,-708
  b0:	01072683          	lw	a3,16(a4)
  b4:	d3c78713          	addi	a4,a5,-708
  b8:	01472703          	lw	a4,20(a4)
  bc:	f9042a23          	sw	a6,-108(s0)
  c0:	f8a42c23          	sw	a0,-104(s0)
  c4:	f8b42e23          	sw	a1,-100(s0)
  c8:	fac42023          	sw	a2,-96(s0)
  cc:	fad42223          	sw	a3,-92(s0)
  d0:	fae42423          	sw	a4,-88(s0)
  d4:	d3c78793          	addi	a5,a5,-708
  d8:	0187d783          	lhu	a5,24(a5)
  dc:	faf41623          	sh	a5,-84(s0)
  e0:	f9440793          	addi	a5,s0,-108
  e4:	00078513          	mv	a0,a5
  e8:	3cc000ef          	jal	ra,4b4 <uart_print>
  ec:	00300513          	li	a0,3									# MODIFIED
  f0:	00C00593          	li	a1,12									# MODIFIED
  f4:	00400613          	li	a2,4									# MODIFIED
  f8:	00500693          	li	a3,5									# MODIFIED
  fc:	00600713          	li	a4,6									# MODIFIED
 100:	00800793          	li	a5,8									# MODIFIED
 104:	00100813          	li	a6,1									# MODIFIED
 108:	00000893          	li	a7,0									# MODIFIED
 10c:	00200913          	li	a8,2									# MODIFIED
 110:	5000010B						msw	a0,matA[0]						# MODIFIED
 114:	5840010B						msw	a1,matA[1]						# MODIFIED
 118:	6080010B						msw	a2,matA[2]						# MODIFIED
 11c:	68C0010B						msw	a3,matA[3]						# MODIFIED
 120:	7100010B						msw	a4,matA[4]						# MODIFIED
 124:	7940010B						msw	a5,matA[5]						# MODIFIED
 128:	8180010B						msw	a6,matA[6]						# MODIFIED
 12c:	89C0010B						msw	a7,matA[7]						# MODIFIED
 130:	9200010B						msw	a8,matA[8]						# MODIFIED
 134:	00700513          	li	a0,7									# MODIFIED
 138:	00300593          	li	a1,3									# MODIFIED
 13c:	00800613          	li	a2,8									# MODIFIED
 140:	00B00693          	li	a3,11									# MODIFIED
 144:	00900713          	li	a4,9									# MODIFIED
 148:	00500793          	li	a5,5									# MODIFIED
 14c:	00600813          	li	a6,6									# MODIFIED
 150:	00800893          	li	a7,8									# MODIFIED
 154:	00400913          	li	a8,4									# MODIFIED
 158:	5240010B						msw	a0,matB[0]						# MODIFIED
 15c:	5A80010B						msw	a1,matB[1]						# MODIFIED
 160:	62C0010B						msw	a2,matB[2]						# MODIFIED
 164:	6B00010B						msw	a3,matB[3]						# MODIFIED
 168:	7340010B						msw	a4,matB[4]						# MODIFIED
 16c:	7B80010B						msw	a5,matB[5]						# MODIFIED
 170:	83C0010B						msw	a6,matB[6]						# MODIFIED
 174:	8C00010B						msw	a7,matB[7]						# MODIFIED
 178:	9440010B						msw	a8,matB[8]						# MODIFIED
 17c:	0000018B						mm												# MODIFIED
 180:	FBC0008B          	mlw	a5,ctrl								# MODIFIED
 184:	00000013          	nop												# MODIFIED
 188:	00000013          	nop												# MODIFIED
 18c:	00000013          	nop												# MODIFIED
 190:	00000013          	nop												# MODIFIED
 194:	fe0786e3          	beqz	a5,180 <main+0x168>
 198:	000017b7          	lui	a5,0x1
 19c:	d587a883          	lw	a7,-680(a5) # d58 <__modsi3+0x78>
 1a0:	d5878713          	addi	a4,a5,-680
 1a4:	00472803          	lw	a6,4(a4)
 1a8:	d5878713          	addi	a4,a5,-680
 1ac:	00872503          	lw	a0,8(a4)
 1b0:	d5878713          	addi	a4,a5,-680
 1b4:	00c72583          	lw	a1,12(a4)
 1b8:	d5878713          	addi	a4,a5,-680
 1bc:	01072603          	lw	a2,16(a4)
 1c0:	d5878713          	addi	a4,a5,-680
 1c4:	01472683          	lw	a3,20(a4)
 1c8:	d5878713          	addi	a4,a5,-680
 1cc:	01872703          	lw	a4,24(a4)
 1d0:	f7142a23          	sw	a7,-140(s0)
 1d4:	f7042c23          	sw	a6,-136(s0)
 1d8:	f6a42e23          	sw	a0,-132(s0)
 1dc:	f8b42023          	sw	a1,-128(s0)
 1e0:	f8c42223          	sw	a2,-124(s0)
 1e4:	f8d42423          	sw	a3,-120(s0)
 1e8:	f8e42623          	sw	a4,-116(s0)
 1ec:	d5878793          	addi	a5,a5,-680
 1f0:	01c7d783          	lhu	a5,28(a5)
 1f4:	f8f41823          	sh	a5,-112(s0)
 1f8:	f7440793          	addi	a5,s0,-140
 1fc:	00078513          	mv	a0,a5
 200:	2b4000ef          	jal	ra,4b4 <uart_print>
 204:	00000013          	nop												# MODIFIED
 208:	00000013          	nop												# MODIFIED
 20c:	00000013          	nop												# MODIFIED
 210:	00000013          	nop												# MODIFIED
 214:	00000013          	nop												# MODIFIED
 218:	00000013          	nop												# MODIFIED
 21c:	00000013          	nop												# MODIFIED
 220:	00000013          	nop												# MODIFIED
 224:	00000013          	nop												# MODIFIED
 228: 0280008B          	mlw	a0,matA[0]						# MODIFIED
 22c: 0AC0008B          	mlw	a1,matA[1]						# MODIFIED
 230: 1300008B          	mlw	a2,matA[2]						# MODIFIED
 234: 1B40008B          	mlw	a3,matA[3]						# MODIFIED
 238: 2380008B          	mlw	a4,matA[4]						# MODIFIED
 23c: 2BC0008B          	mlw	a5,matA[5]						# MODIFIED
 240: 3400008B          	mlw	a6,matA[6]						# MODIFIED
 244: 3C40008B          	mlw	a7,matA[7]						# MODIFIED
 248: 4480008B          	mlw	a8,matA[8]						# MODIFIED
 24c: FAA42823          	sw	a0,-80(s0)						# MODIFIED
 # 1111101 01111 01000 010 10000 0100011
 # offset  src   base  wid offst STORE
 # 1111101 01010 01000 010 10000 0100011
 250: FAB42A23          	sw	a1,-76(s0)						# MODIFIED
 # 1111101 01011 01000 010 10100 0100011
 254: FAC42C23          	sw	a2,-72(s0)						# MODIFIED
 # 1111101 01100 01000 010 11000 0100011
 258: FAD42E23          	sw	a3,-68(s0)						# MODIFIED
 # 1111101 01101 01000 010 11100 0100011
 25c: FCE42023          	sw	a4,-64(s0)						# MODIFIED
 # 1111110 01110 01000 010 00000 0100011
 260: fcf42223          	sw	a5,-60(s0)						# MODIFIED
 264: FD042423          	sw	a6,-56(s0)						# MODIFIED
 # 1111110 10000 01000 010 01000 0100011
 268: FD142623          	sw	a7,-52(s0)						# MODIFIED
 # 1111110 10010 01000 010 10000 0100011
 26c: FD242823          	sw	a8,-48(s0)						# MODIFIED
 # 1111110 10001 01000 010 01100 0100011
 270:	000017b7          	lui	a5,0x1
 274:	d2c78793          	addi	a5,a5,-724 # d2c <__modsi3+0x4c>
 278:	fef42023          	sw	a5,-32(s0)
 27c:	fe042623          	sw	zero,-20(s0)
 280:	0480006f          	j	2c8 <main+0x2b0>
 284:	fec42783          	lw	a5,-20(s0)
 288:	00279793          	slli	a5,a5,0x2
 28c:	ff040713          	addi	a4,s0,-16
 290:	00f707b3          	add	a5,a4,a5
 294:	fc07a783          	lw	a5,-64(a5)
 298:	f6440713          	addi	a4,s0,-156
 29c:	00070593          	mv	a1,a4
 2a0:	00078513          	mv	a0,a5
 2a4:	46c000ef          	jal	ra,710 <itoa>
 2a8:	f6440793          	addi	a5,s0,-156
 2ac:	00078513          	mv	a0,a5
 2b0:	204000ef          	jal	ra,4b4 <uart_print>
 2b4:	fe042503          	lw	a0,-32(s0)
 2b8:	1fc000ef          	jal	ra,4b4 <uart_print>
 2bc:	fec42783          	lw	a5,-20(s0)
 2c0:	00178793          	addi	a5,a5,1
 2c4:	fef42623          	sw	a5,-20(s0)
 2c8:	fec42703          	lw	a4,-20(s0)
 2cc:	00800793          	li	a5,8
 2d0:	fae7dae3          	ble	a4,a5,284 <main+0x26c>
 2d4:	00000793          	li	a5,0
 2d8:	00078513          	mv	a0,a5
 2dc:	09c12083          	lw	ra,156(sp)
 2e0:	09812403          	lw	s0,152(sp)
 2e4:	0a010113          	addi	sp,sp,160
 2e8:	00008067          	ret

000002ec <uart_init>:
 2ec:	fe010113          	addi	sp,sp,-32
 2f0:	00812e23          	sw	s0,28(sp)
 2f4:	02010413          	addi	s0,sp,32
 2f8:	aaaaa7b7          	lui	a5,0xaaaaa
 2fc:	40078793          	addi	a5,a5,1024 # aaaaa400 <_sp0+0xaaaa8680>
 300:	fef42623          	sw	a5,-20(s0)
 304:	fec42783          	lw	a5,-20(s0)
 308:	00378793          	addi	a5,a5,3
 30c:	f8300713          	li	a4,-125
 310:	00e78023          	sb	a4,0(a5)
 314:	03600793          	li	a5,54
 318:	fef405a3          	sb	a5,-21(s0)
 31c:	fec42783          	lw	a5,-20(s0)
 320:	feb44703          	lbu	a4,-21(s0)
 324:	00e78023          	sb	a4,0(a5)
 328:	fec42783          	lw	a5,-20(s0)
 32c:	00178793          	addi	a5,a5,1
 330:	00078023          	sb	zero,0(a5)
 334:	fec42783          	lw	a5,-20(s0)
 338:	00378793          	addi	a5,a5,3
 33c:	00300713          	li	a4,3
 340:	00e78023          	sb	a4,0(a5)
 344:	fec42783          	lw	a5,-20(s0)
 348:	00278793          	addi	a5,a5,2
 34c:	00100713          	li	a4,1
 350:	00e78023          	sb	a4,0(a5)
 354:	fec42783          	lw	a5,-20(s0)
 358:	00178793          	addi	a5,a5,1
 35c:	00100713          	li	a4,1
 360:	00e78023          	sb	a4,0(a5)
 364:	00100793          	li	a5,1
 368:	00078513          	mv	a0,a5
 36c:	01c12403          	lw	s0,28(sp)
 370:	02010113          	addi	sp,sp,32
 374:	00008067          	ret

00000378 <uart_put>:
 378:	fd010113          	addi	sp,sp,-48
 37c:	02812623          	sw	s0,44(sp)
 380:	03010413          	addi	s0,sp,48
 384:	00050793          	mv	a5,a0
 388:	fcf40fa3          	sb	a5,-33(s0)
 38c:	aaaaa7b7          	lui	a5,0xaaaaa
 390:	40078793          	addi	a5,a5,1024 # aaaaa400 <_sp0+0xaaaa8680>
 394:	fef42623          	sw	a5,-20(s0)
 398:	fec42783          	lw	a5,-20(s0)
 39c:	fdf44703          	lbu	a4,-33(s0)
 3a0:	00e78023          	sb	a4,0(a5)
 3a4:	00000013          	nop
 3a8:	02c12403          	lw	s0,44(sp)
 3ac:	03010113          	addi	sp,sp,48
 3b0:	00008067          	ret

000003b4 <uart_put_blocking>:
 3b4:	fd010113          	addi	sp,sp,-48
 3b8:	02112623          	sw	ra,44(sp)
 3bc:	02812423          	sw	s0,40(sp)
 3c0:	03010413          	addi	s0,sp,48
 3c4:	00050793          	mv	a5,a0
 3c8:	fcf40fa3          	sb	a5,-33(s0)
 3cc:	06c000ef          	jal	ra,438 <uart_poll>
 3d0:	00050793          	mv	a5,a0
 3d4:	0407f793          	andi	a5,a5,64
 3d8:	fef407a3          	sb	a5,-17(s0)
 3dc:	fef44783          	lbu	a5,-17(s0)
 3e0:	fe0786e3          	beqz	a5,3cc <uart_put_blocking+0x18>
 3e4:	fdf44783          	lbu	a5,-33(s0)
 3e8:	00078513          	mv	a0,a5
 3ec:	f8dff0ef          	jal	ra,378 <uart_put>
 3f0:	00000013          	nop
 3f4:	02c12083          	lw	ra,44(sp)
 3f8:	02812403          	lw	s0,40(sp)
 3fc:	03010113          	addi	sp,sp,48
 400:	00008067          	ret

00000404 <uart_get>:
 404:	fe010113          	addi	sp,sp,-32
 408:	00812e23          	sw	s0,28(sp)
 40c:	02010413          	addi	s0,sp,32
 410:	aaaaa7b7          	lui	a5,0xaaaaa
 414:	40078793          	addi	a5,a5,1024 # aaaaa400 <_sp0+0xaaaa8680>
 418:	fef42623          	sw	a5,-20(s0)
 41c:	fec42783          	lw	a5,-20(s0)
 420:	0007c783          	lbu	a5,0(a5)
 424:	0ff7f793          	andi	a5,a5,255
 428:	00078513          	mv	a0,a5
 42c:	01c12403          	lw	s0,28(sp)
 430:	02010113          	addi	sp,sp,32
 434:	00008067          	ret

00000438 <uart_poll>:
 438:	fe010113          	addi	sp,sp,-32
 43c:	00812e23          	sw	s0,28(sp)
 440:	02010413          	addi	s0,sp,32
 444:	aaaaa7b7          	lui	a5,0xaaaaa
 448:	40078793          	addi	a5,a5,1024 # aaaaa400 <_sp0+0xaaaa8680>
 44c:	fef42623          	sw	a5,-20(s0)
 450:	fec42783          	lw	a5,-20(s0)
 454:	00578793          	addi	a5,a5,5
 458:	0007c783          	lbu	a5,0(a5)
 45c:	0ff7f793          	andi	a5,a5,255
 460:	00078513          	mv	a0,a5
 464:	01c12403          	lw	s0,28(sp)
 468:	02010113          	addi	sp,sp,32
 46c:	00008067          	ret

00000470 <uart_read_blocking>:
 470:	fe010113          	addi	sp,sp,-32
 474:	00112e23          	sw	ra,28(sp)
 478:	00812c23          	sw	s0,24(sp)
 47c:	02010413          	addi	s0,sp,32
 480:	fb9ff0ef          	jal	ra,438 <uart_poll>
 484:	00050793          	mv	a5,a0
 488:	0017f793          	andi	a5,a5,1
 48c:	fef407a3          	sb	a5,-17(s0)
 490:	fef44783          	lbu	a5,-17(s0)
 494:	fe0786e3          	beqz	a5,480 <uart_read_blocking+0x10>
 498:	f6dff0ef          	jal	ra,404 <uart_get>
 49c:	00050793          	mv	a5,a0
 4a0:	00078513          	mv	a0,a5
 4a4:	01c12083          	lw	ra,28(sp)
 4a8:	01812403          	lw	s0,24(sp)
 4ac:	02010113          	addi	sp,sp,32
 4b0:	00008067          	ret

000004b4 <uart_print>:
 4b4:	fd010113          	addi	sp,sp,-48
 4b8:	02112623          	sw	ra,44(sp)
 4bc:	02812423          	sw	s0,40(sp)
 4c0:	03010413          	addi	s0,sp,48
 4c4:	fca42e23          	sw	a0,-36(s0)
 4c8:	fdc42783          	lw	a5,-36(s0)
 4cc:	fef42423          	sw	a5,-24(s0)
 4d0:	fe042623          	sw	zero,-20(s0)
 4d4:	0280006f          	j	4fc <uart_print+0x48>
 4d8:	fec42783          	lw	a5,-20(s0)
 4dc:	fe842703          	lw	a4,-24(s0)
 4e0:	00f707b3          	add	a5,a4,a5
 4e4:	0007c783          	lbu	a5,0(a5)
 4e8:	00078513          	mv	a0,a5
 4ec:	ec9ff0ef          	jal	ra,3b4 <uart_put_blocking>
 4f0:	fec42783          	lw	a5,-20(s0)
 4f4:	00178793          	addi	a5,a5,1
 4f8:	fef42623          	sw	a5,-20(s0)
 4fc:	fec42783          	lw	a5,-20(s0)
 500:	fe842703          	lw	a4,-24(s0)
 504:	00f707b3          	add	a5,a4,a5
 508:	0007c783          	lbu	a5,0(a5)
 50c:	fc0796e3          	bnez	a5,4d8 <uart_print+0x24>
 510:	00000013          	nop
 514:	02c12083          	lw	ra,44(sp)
 518:	02812403          	lw	s0,40(sp)
 51c:	03010113          	addi	sp,sp,48
 520:	00008067          	ret

00000524 <readline>:
 524:	fd010113          	addi	sp,sp,-48
 528:	02112623          	sw	ra,44(sp)
 52c:	02812423          	sw	s0,40(sp)
 530:	03010413          	addi	s0,sp,48
 534:	fca42e23          	sw	a0,-36(s0)
 538:	fcb42c23          	sw	a1,-40(s0)
 53c:	fe042623          	sw	zero,-20(s0)
 540:	0900006f          	j	5d0 <readline+0xac>
 544:	f2dff0ef          	jal	ra,470 <uart_read_blocking>
 548:	00050793          	mv	a5,a0
 54c:	fef403a3          	sb	a5,-25(s0)
 550:	fe744703          	lbu	a4,-25(s0)
 554:	00d00793          	li	a5,13
 558:	04f71663          	bne	a4,a5,5a4 <readline+0x80>
 55c:	fec42783          	lw	a5,-20(s0)
 560:	fef42423          	sw	a5,-24(s0)
 564:	0200006f          	j	584 <readline+0x60>
 568:	fe842783          	lw	a5,-24(s0)
 56c:	fdc42703          	lw	a4,-36(s0)
 570:	00f707b3          	add	a5,a4,a5
 574:	00078023          	sb	zero,0(a5)
 578:	fe842783          	lw	a5,-24(s0)
 57c:	00178793          	addi	a5,a5,1
 580:	fef42423          	sw	a5,-24(s0)
 584:	fe842703          	lw	a4,-24(s0)
 588:	fd842783          	lw	a5,-40(s0)
 58c:	fcf74ee3          	blt	a4,a5,568 <readline+0x44>
 590:	00d00513          	li	a0,13
 594:	de5ff0ef          	jal	ra,378 <uart_put>
 598:	00a00513          	li	a0,10
 59c:	dddff0ef          	jal	ra,378 <uart_put>
 5a0:	03c0006f          	j	5dc <readline+0xb8>
 5a4:	fe744783          	lbu	a5,-25(s0)
 5a8:	00078513          	mv	a0,a5
 5ac:	dcdff0ef          	jal	ra,378 <uart_put>
 5b0:	fec42783          	lw	a5,-20(s0)
 5b4:	fdc42703          	lw	a4,-36(s0)
 5b8:	00f707b3          	add	a5,a4,a5
 5bc:	fe744703          	lbu	a4,-25(s0)
 5c0:	00e78023          	sb	a4,0(a5)
 5c4:	fec42783          	lw	a5,-20(s0)
 5c8:	00178793          	addi	a5,a5,1
 5cc:	fef42623          	sw	a5,-20(s0)
 5d0:	fec42703          	lw	a4,-20(s0)
 5d4:	fd842783          	lw	a5,-40(s0)
 5d8:	f6f746e3          	blt	a4,a5,544 <readline+0x20>
 5dc:	02c12083          	lw	ra,44(sp)
 5e0:	02812403          	lw	s0,40(sp)
 5e4:	03010113          	addi	sp,sp,48
 5e8:	00008067          	ret

000005ec <strlen>:
 5ec:	fd010113          	addi	sp,sp,-48
 5f0:	02812623          	sw	s0,44(sp)
 5f4:	03010413          	addi	s0,sp,48
 5f8:	fca42e23          	sw	a0,-36(s0)
 5fc:	fdc42783          	lw	a5,-36(s0)
 600:	fef42423          	sw	a5,-24(s0)
 604:	fe042623          	sw	zero,-20(s0)
 608:	0100006f          	j	618 <strlen+0x2c>
 60c:	fec42783          	lw	a5,-20(s0)
 610:	00178793          	addi	a5,a5,1
 614:	fef42623          	sw	a5,-20(s0)
 618:	fec42783          	lw	a5,-20(s0)
 61c:	fe842703          	lw	a4,-24(s0)
 620:	00f707b3          	add	a5,a4,a5
 624:	0007c783          	lbu	a5,0(a5)
 628:	fe0792e3          	bnez	a5,60c <strlen+0x20>
 62c:	fec42783          	lw	a5,-20(s0)
 630:	00078513          	mv	a0,a5
 634:	02c12403          	lw	s0,44(sp)
 638:	03010113          	addi	sp,sp,48
 63c:	00008067          	ret

00000640 <atoi>:
 640:	fc010113          	addi	sp,sp,-64
 644:	02112e23          	sw	ra,60(sp)
 648:	02812c23          	sw	s0,56(sp)
 64c:	04010413          	addi	s0,sp,64
 650:	fca42623          	sw	a0,-52(s0)
 654:	fcc42503          	lw	a0,-52(s0)
 658:	f95ff0ef          	jal	ra,5ec <strlen>
 65c:	fea42223          	sw	a0,-28(s0)
 660:	fe042423          	sw	zero,-24(s0)
 664:	00100793          	li	a5,1
 668:	fef42023          	sw	a5,-32(s0)
 66c:	0840006f          	j	6f0 <atoi+0xb0>
 670:	fec42783          	lw	a5,-20(s0)
 674:	fcc42703          	lw	a4,-52(s0)
 678:	00f707b3          	add	a5,a4,a5
 67c:	0007c783          	lbu	a5,0(a5)
 680:	fd078793          	addi	a5,a5,-48
 684:	fcf42e23          	sw	a5,-36(s0)
 688:	fdc42703          	lw	a4,-36(s0)
 68c:	ffd00793          	li	a5,-3
 690:	00f71863          	bne	a4,a5,6a0 <atoi+0x60>
 694:	fe842783          	lw	a5,-24(s0)
 698:	40f007b3          	neg	a5,a5
 69c:	0600006f          	j	6fc <atoi+0xbc>
 6a0:	fdc42783          	lw	a5,-36(s0)
 6a4:	0207cc63          	bltz	a5,6dc <atoi+0x9c>
 6a8:	fdc42703          	lw	a4,-36(s0)
 6ac:	00900793          	li	a5,9
 6b0:	02e7c663          	blt	a5,a4,6dc <atoi+0x9c>
 6b4:	fdc42783          	lw	a5,-36(s0)
 6b8:	fe042703          	lw	a4,-32(s0)
 6bc:	00070593          	mv	a1,a4
 6c0:	00078513          	mv	a0,a5
 6c4:	1e0000ef          	jal	ra,8a4 <multiply>
 6c8:	00050713          	mv	a4,a0
 6cc:	fe842783          	lw	a5,-24(s0)
 6d0:	00e787b3          	add	a5,a5,a4
 6d4:	fef42423          	sw	a5,-24(s0)
 6d8:	00c0006f          	j	6e4 <atoi+0xa4>
 6dc:	fff00793          	li	a5,-1
 6e0:	01c0006f          	j	6fc <atoi+0xbc>
 6e4:	fec42783          	lw	a5,-20(s0)
 6e8:	fff78793          	addi	a5,a5,-1
 6ec:	fef42623          	sw	a5,-20(s0)
 6f0:	fec42783          	lw	a5,-20(s0)
 6f4:	f607dee3          	bgez	a5,670 <atoi+0x30>
 6f8:	fe842783          	lw	a5,-24(s0)
 6fc:	00078513          	mv	a0,a5
 700:	03c12083          	lw	ra,60(sp)
 704:	03812403          	lw	s0,56(sp)
 708:	04010113          	addi	sp,sp,64
 70c:	00008067          	ret

00000710 <itoa>:
 710:	fd010113          	addi	sp,sp,-48
 714:	02112623          	sw	ra,44(sp)
 718:	02812423          	sw	s0,40(sp)
 71c:	03010413          	addi	s0,sp,48
 720:	fca42e23          	sw	a0,-36(s0)
 724:	fcb42c23          	sw	a1,-40(s0)
 728:	fe042223          	sw	zero,-28(s0)
 72c:	fdc42783          	lw	a5,-36(s0)
 730:	0207d863          	bgez	a5,760 <itoa+0x50>
 734:	fe442783          	lw	a5,-28(s0)
 738:	fd842703          	lw	a4,-40(s0)
 73c:	00f707b3          	add	a5,a4,a5
 740:	02d00713          	li	a4,45
 744:	00e78023          	sb	a4,0(a5)
 748:	fdc42783          	lw	a5,-36(s0)
 74c:	40f007b3          	neg	a5,a5
 750:	fcf42e23          	sw	a5,-36(s0)
 754:	fe442783          	lw	a5,-28(s0)
 758:	00178793          	addi	a5,a5,1
 75c:	fef42223          	sw	a5,-28(s0)
 760:	fdc42703          	lw	a4,-36(s0)
 764:	00900793          	li	a5,9
 768:	02e7c463          	blt	a5,a4,790 <itoa+0x80>
 76c:	fdc42783          	lw	a5,-36(s0)
 770:	0ff7f713          	andi	a4,a5,255
 774:	fe442783          	lw	a5,-28(s0)
 778:	fd842683          	lw	a3,-40(s0)
 77c:	00f687b3          	add	a5,a3,a5
 780:	03070713          	addi	a4,a4,48
 784:	0ff77713          	andi	a4,a4,255
 788:	00e78023          	sb	a4,0(a5)
 78c:	0d40006f          	j	860 <itoa+0x150>
 790:	00100793          	li	a5,1
 794:	fef42623          	sw	a5,-20(s0)
 798:	0180006f          	j	7b0 <itoa+0xa0>
 79c:	fec42783          	lw	a5,-20(s0)
 7a0:	00a00593          	li	a1,10
 7a4:	00078513          	mv	a0,a5
 7a8:	0fc000ef          	jal	ra,8a4 <multiply>
 7ac:	fea42623          	sw	a0,-20(s0)
 7b0:	fec42583          	lw	a1,-20(s0)
 7b4:	fdc42503          	lw	a0,-36(s0)
 7b8:	158000ef          	jal	ra,910 <divide>
 7bc:	00050793          	mv	a5,a0
 7c0:	fcf04ee3          	bgtz	a5,79c <itoa+0x8c>
 7c4:	00a00593          	li	a1,10
 7c8:	fec42503          	lw	a0,-20(s0)
 7cc:	144000ef          	jal	ra,910 <divide>
 7d0:	fea42423          	sw	a0,-24(s0)
 7d4:	fec42583          	lw	a1,-20(s0)
 7d8:	fdc42503          	lw	a0,-36(s0)
 7dc:	268000ef          	jal	ra,a44 <modulo>
 7e0:	00050793          	mv	a5,a0
 7e4:	fe842583          	lw	a1,-24(s0)
 7e8:	00078513          	mv	a0,a5
 7ec:	124000ef          	jal	ra,910 <divide>
 7f0:	fea42023          	sw	a0,-32(s0)
 7f4:	fe042783          	lw	a5,-32(s0)
 7f8:	0ff7f713          	andi	a4,a5,255
 7fc:	fe442783          	lw	a5,-28(s0)
 800:	fd842683          	lw	a3,-40(s0)
 804:	00f687b3          	add	a5,a3,a5
 808:	03070713          	addi	a4,a4,48
 80c:	0ff77713          	andi	a4,a4,255
 810:	00e78023          	sb	a4,0(a5)
 814:	fe442783          	lw	a5,-28(s0)
 818:	00178793          	addi	a5,a5,1
 81c:	fef42223          	sw	a5,-28(s0)
 820:	fe842703          	lw	a4,-24(s0)
 824:	00100793          	li	a5,1
 828:	02f70a63          	beq	a4,a5,85c <itoa+0x14c>
 82c:	fe442703          	lw	a4,-28(s0)
 830:	00c00793          	li	a5,12
 834:	02f70463          	beq	a4,a5,85c <itoa+0x14c>
 838:	00a00593          	li	a1,10
 83c:	fe842503          	lw	a0,-24(s0)
 840:	0d0000ef          	jal	ra,910 <divide>
 844:	fea42423          	sw	a0,-24(s0)
 848:	00a00593          	li	a1,10
 84c:	fec42503          	lw	a0,-20(s0)
 850:	0c0000ef          	jal	ra,910 <divide>
 854:	fea42623          	sw	a0,-20(s0)
 858:	f7dff06f          	j	7d4 <itoa+0xc4>
 85c:	00000013          	nop
 860:	02c12083          	lw	ra,44(sp)
 864:	02812403          	lw	s0,40(sp)
 868:	03010113          	addi	sp,sp,48
 86c:	00008067          	ret

00000870 <abs>:
 870:	fe010113          	addi	sp,sp,-32
 874:	00812e23          	sw	s0,28(sp)
 878:	02010413          	addi	s0,sp,32
 87c:	fea42623          	sw	a0,-20(s0)
 880:	fec42783          	lw	a5,-20(s0)
 884:	41f7d713          	srai	a4,a5,0x1f
 888:	fec42783          	lw	a5,-20(s0)
 88c:	00f747b3          	xor	a5,a4,a5
 890:	40e787b3          	sub	a5,a5,a4
 894:	00078513          	mv	a0,a5
 898:	01c12403          	lw	s0,28(sp)
 89c:	02010113          	addi	sp,sp,32
 8a0:	00008067          	ret

000008a4 <multiply>:
 8a4:	fd010113          	addi	sp,sp,-48
 8a8:	02812623          	sw	s0,44(sp)
 8ac:	03010413          	addi	s0,sp,48
 8b0:	fca42e23          	sw	a0,-36(s0)
 8b4:	fcb42c23          	sw	a1,-40(s0)
 8b8:	fe042623          	sw	zero,-20(s0)
 8bc:	0380006f          	j	8f4 <multiply+0x50>
 8c0:	fdc42783          	lw	a5,-36(s0)
 8c4:	0017f793          	andi	a5,a5,1
 8c8:	00078a63          	beqz	a5,8dc <multiply+0x38>
 8cc:	fec42703          	lw	a4,-20(s0)
 8d0:	fd842783          	lw	a5,-40(s0)
 8d4:	00f707b3          	add	a5,a4,a5
 8d8:	fef42623          	sw	a5,-20(s0)
 8dc:	fdc42783          	lw	a5,-36(s0)
 8e0:	0017d793          	srli	a5,a5,0x1
 8e4:	fcf42e23          	sw	a5,-36(s0)
 8e8:	fd842783          	lw	a5,-40(s0)
 8ec:	00179793          	slli	a5,a5,0x1
 8f0:	fcf42c23          	sw	a5,-40(s0)
 8f4:	fdc42783          	lw	a5,-36(s0)
 8f8:	fc0794e3          	bnez	a5,8c0 <multiply+0x1c>
 8fc:	fec42783          	lw	a5,-20(s0)
 900:	00078513          	mv	a0,a5
 904:	02c12403          	lw	s0,44(sp)
 908:	03010113          	addi	sp,sp,48
 90c:	00008067          	ret

00000910 <divide>:
 910:	fd010113          	addi	sp,sp,-48
 914:	02112623          	sw	ra,44(sp)
 918:	02812423          	sw	s0,40(sp)
 91c:	03010413          	addi	s0,sp,48
 920:	fca42e23          	sw	a0,-36(s0)
 924:	fcb42c23          	sw	a1,-40(s0)
 928:	fd842783          	lw	a5,-40(s0)
 92c:	00079663          	bnez	a5,938 <divide+0x28>
 930:	00000793          	li	a5,0
 934:	0fc0006f          	j	a30 <divide+0x120>
 938:	00100793          	li	a5,1
 93c:	fef42623          	sw	a5,-20(s0)
 940:	fdc42783          	lw	a5,-36(s0)
 944:	fd842703          	lw	a4,-40(s0)
 948:	00070593          	mv	a1,a4
 94c:	00078513          	mv	a0,a5
 950:	f55ff0ef          	jal	ra,8a4 <multiply>
 954:	00050793          	mv	a5,a0
 958:	0007d663          	bgez	a5,964 <divide+0x54>
 95c:	fff00793          	li	a5,-1
 960:	fef42623          	sw	a5,-20(s0)
 964:	fdc42783          	lw	a5,-36(s0)
 968:	41f7d793          	srai	a5,a5,0x1f
 96c:	fdc42703          	lw	a4,-36(s0)
 970:	00f74733          	xor	a4,a4,a5
 974:	40f707b3          	sub	a5,a4,a5
 978:	fcf42e23          	sw	a5,-36(s0)
 97c:	fd842783          	lw	a5,-40(s0)
 980:	41f7d793          	srai	a5,a5,0x1f
 984:	fd842703          	lw	a4,-40(s0)
 988:	00f74733          	xor	a4,a4,a5
 98c:	40f707b3          	sub	a5,a4,a5
 990:	fcf42c23          	sw	a5,-40(s0)
 994:	00100793          	li	a5,1
 998:	fef42423          	sw	a5,-24(s0)
 99c:	fe042223          	sw	zero,-28(s0)
 9a0:	01c0006f          	j	9bc <divide+0xac>
 9a4:	fd842783          	lw	a5,-40(s0)
 9a8:	00179793          	slli	a5,a5,0x1
 9ac:	fcf42c23          	sw	a5,-40(s0)
 9b0:	fe842783          	lw	a5,-24(s0)
 9b4:	00179793          	slli	a5,a5,0x1
 9b8:	fef42423          	sw	a5,-24(s0)
 9bc:	fd842703          	lw	a4,-40(s0)
 9c0:	fdc42783          	lw	a5,-36(s0)
 9c4:	fee7d0e3          	ble	a4,a5,9a4 <divide+0x94>
 9c8:	0480006f          	j	a10 <divide+0x100>
 9cc:	fd842783          	lw	a5,-40(s0)
 9d0:	4017d793          	srai	a5,a5,0x1
 9d4:	fcf42c23          	sw	a5,-40(s0)
 9d8:	fe842783          	lw	a5,-24(s0)
 9dc:	0017d793          	srli	a5,a5,0x1
 9e0:	fef42423          	sw	a5,-24(s0)
 9e4:	fdc42703          	lw	a4,-36(s0)
 9e8:	fd842783          	lw	a5,-40(s0)
 9ec:	02f74263          	blt	a4,a5,a10 <divide+0x100>
 9f0:	fdc42703          	lw	a4,-36(s0)
 9f4:	fd842783          	lw	a5,-40(s0)
 9f8:	40f707b3          	sub	a5,a4,a5
 9fc:	fcf42e23          	sw	a5,-36(s0)
 a00:	fe442703          	lw	a4,-28(s0)
 a04:	fe842783          	lw	a5,-24(s0)
 a08:	00f767b3          	or	a5,a4,a5
 a0c:	fef42223          	sw	a5,-28(s0)
 a10:	fe842703          	lw	a4,-24(s0)
 a14:	00100793          	li	a5,1
 a18:	fae7eae3          	bltu	a5,a4,9cc <divide+0xbc>
 a1c:	fec42783          	lw	a5,-20(s0)
 a20:	fe442583          	lw	a1,-28(s0)
 a24:	00078513          	mv	a0,a5
 a28:	e7dff0ef          	jal	ra,8a4 <multiply>
 a2c:	00050793          	mv	a5,a0
 a30:	00078513          	mv	a0,a5
 a34:	02c12083          	lw	ra,44(sp)
 a38:	02812403          	lw	s0,40(sp)
 a3c:	03010113          	addi	sp,sp,48
 a40:	00008067          	ret

00000a44 <modulo>:
 a44:	fd010113          	addi	sp,sp,-48
 a48:	02112623          	sw	ra,44(sp)
 a4c:	02812423          	sw	s0,40(sp)
 a50:	03010413          	addi	s0,sp,48
 a54:	fca42e23          	sw	a0,-36(s0)
 a58:	fcb42c23          	sw	a1,-40(s0)
 a5c:	fd842783          	lw	a5,-40(s0)
 a60:	00079663          	bnez	a5,a6c <modulo+0x28>
 a64:	00000793          	li	a5,0
 a68:	0d80006f          	j	b40 <modulo+0xfc>
 a6c:	00100793          	li	a5,1
 a70:	fef42623          	sw	a5,-20(s0)
 a74:	fdc42783          	lw	a5,-36(s0)
 a78:	0007d663          	bgez	a5,a84 <modulo+0x40>
 a7c:	fff00793          	li	a5,-1
 a80:	fef42623          	sw	a5,-20(s0)
 a84:	fdc42783          	lw	a5,-36(s0)
 a88:	41f7d793          	srai	a5,a5,0x1f
 a8c:	fdc42703          	lw	a4,-36(s0)
 a90:	00f74733          	xor	a4,a4,a5
 a94:	40f707b3          	sub	a5,a4,a5
 a98:	fcf42e23          	sw	a5,-36(s0)
 a9c:	fd842783          	lw	a5,-40(s0)
 aa0:	41f7d793          	srai	a5,a5,0x1f
 aa4:	fd842703          	lw	a4,-40(s0)
 aa8:	00f74733          	xor	a4,a4,a5
 aac:	40f707b3          	sub	a5,a4,a5
 ab0:	fcf42c23          	sw	a5,-40(s0)
 ab4:	00100793          	li	a5,1
 ab8:	fef42423          	sw	a5,-24(s0)
 abc:	01c0006f          	j	ad8 <modulo+0x94>
 ac0:	fd842783          	lw	a5,-40(s0)
 ac4:	00179793          	slli	a5,a5,0x1
 ac8:	fcf42c23          	sw	a5,-40(s0)
 acc:	fe842783          	lw	a5,-24(s0)
 ad0:	00179793          	slli	a5,a5,0x1
 ad4:	fef42423          	sw	a5,-24(s0)
 ad8:	fd842703          	lw	a4,-40(s0)
 adc:	fdc42783          	lw	a5,-36(s0)
 ae0:	fee7d0e3          	ble	a4,a5,ac0 <modulo+0x7c>
 ae4:	0380006f          	j	b1c <modulo+0xd8>
 ae8:	fd842783          	lw	a5,-40(s0)
 aec:	4017d793          	srai	a5,a5,0x1
 af0:	fcf42c23          	sw	a5,-40(s0)
 af4:	fe842783          	lw	a5,-24(s0)
 af8:	0017d793          	srli	a5,a5,0x1
 afc:	fef42423          	sw	a5,-24(s0)
 b00:	fdc42703          	lw	a4,-36(s0)
 b04:	fd842783          	lw	a5,-40(s0)
 b08:	00f74a63          	blt	a4,a5,b1c <modulo+0xd8>
 b0c:	fdc42703          	lw	a4,-36(s0)
 b10:	fd842783          	lw	a5,-40(s0)
 b14:	40f707b3          	sub	a5,a4,a5
 b18:	fcf42e23          	sw	a5,-36(s0)
 b1c:	fe842703          	lw	a4,-24(s0)
 b20:	00100793          	li	a5,1
 b24:	fce7e2e3          	bltu	a5,a4,ae8 <modulo+0xa4>
 b28:	fec42783          	lw	a5,-20(s0)
 b2c:	fdc42703          	lw	a4,-36(s0)
 b30:	00070593          	mv	a1,a4
 b34:	00078513          	mv	a0,a5
 b38:	d6dff0ef          	jal	ra,8a4 <multiply>
 b3c:	00050793          	mv	a5,a0
 b40:	00078513          	mv	a0,a5
 b44:	02c12083          	lw	ra,44(sp)
 b48:	02812403          	lw	s0,40(sp)
 b4c:	03010113          	addi	sp,sp,48
 b50:	00008067          	ret

00000b54 <count_digits>:
 b54:	fd010113          	addi	sp,sp,-48
 b58:	02112623          	sw	ra,44(sp)
 b5c:	02812423          	sw	s0,40(sp)
 b60:	03010413          	addi	s0,sp,48
 b64:	fca42e23          	sw	a0,-36(s0)
 b68:	fe042623          	sw	zero,-20(s0)
 b6c:	0200006f          	j	b8c <count_digits+0x38>
 b70:	00a00593          	li	a1,10
 b74:	fdc42503          	lw	a0,-36(s0)
 b78:	d99ff0ef          	jal	ra,910 <divide>
 b7c:	fca42e23          	sw	a0,-36(s0)
 b80:	fec42783          	lw	a5,-20(s0)
 b84:	00178793          	addi	a5,a5,1
 b88:	fef42623          	sw	a5,-20(s0)
 b8c:	fdc42783          	lw	a5,-36(s0)
 b90:	fe0790e3          	bnez	a5,b70 <count_digits+0x1c>
 b94:	fec42783          	lw	a5,-20(s0)
 b98:	00078513          	mv	a0,a5
 b9c:	02c12083          	lw	ra,44(sp)
 ba0:	02812403          	lw	s0,40(sp)
 ba4:	03010113          	addi	sp,sp,48
 ba8:	00008067          	ret

00000bac <__mulsi3>:
 bac:	fd010113          	addi	sp,sp,-48
 bb0:	02812623          	sw	s0,44(sp)
 bb4:	03010413          	addi	s0,sp,48
 bb8:	fca42e23          	sw	a0,-36(s0)
 bbc:	fcb42c23          	sw	a1,-40(s0)
 bc0:	fe042623          	sw	zero,-20(s0)
 bc4:	fd842783          	lw	a5,-40(s0)
 bc8:	0007de63          	bgez	a5,be4 <__mulsi3+0x38>
 bcc:	fdc42783          	lw	a5,-36(s0)
 bd0:	40f007b3          	neg	a5,a5
 bd4:	fcf42e23          	sw	a5,-36(s0)
 bd8:	fd842783          	lw	a5,-40(s0)
 bdc:	40f007b3          	neg	a5,a5
 be0:	fcf42c23          	sw	a5,-40(s0)
 be4:	fe042423          	sw	zero,-24(s0)
 be8:	0200006f          	j	c08 <__mulsi3+0x5c>
 bec:	fec42703          	lw	a4,-20(s0)
 bf0:	fdc42783          	lw	a5,-36(s0)
 bf4:	00f707b3          	add	a5,a4,a5
 bf8:	fef42623          	sw	a5,-20(s0)
 bfc:	fe842783          	lw	a5,-24(s0)
 c00:	00178793          	addi	a5,a5,1
 c04:	fef42423          	sw	a5,-24(s0)
 c08:	fe842703          	lw	a4,-24(s0)
 c0c:	fd842783          	lw	a5,-40(s0)
 c10:	fcf74ee3          	blt	a4,a5,bec <__mulsi3+0x40>
 c14:	fec42783          	lw	a5,-20(s0)
 c18:	00078513          	mv	a0,a5
 c1c:	02c12403          	lw	s0,44(sp)
 c20:	03010113          	addi	sp,sp,48
 c24:	00008067          	ret

00000c28 <__divsi3>:
 c28:	fd010113          	addi	sp,sp,-48
 c2c:	02812623          	sw	s0,44(sp)
 c30:	03010413          	addi	s0,sp,48
 c34:	fca42e23          	sw	a0,-36(s0)
 c38:	fcb42c23          	sw	a1,-40(s0)
 c3c:	fe042623          	sw	zero,-20(s0)
 c40:	fdc42703          	lw	a4,-36(s0)
 c44:	fd842783          	lw	a5,-40(s0)
 c48:	00f75663          	ble	a5,a4,c54 <__divsi3+0x2c>
 c4c:	fec42783          	lw	a5,-20(s0)
 c50:	0240006f          	j	c74 <__divsi3+0x4c>
 c54:	fdc42703          	lw	a4,-36(s0)
 c58:	fd842783          	lw	a5,-40(s0)
 c5c:	40f707b3          	sub	a5,a4,a5
 c60:	fcf42e23          	sw	a5,-36(s0)
 c64:	fec42783          	lw	a5,-20(s0)
 c68:	00178793          	addi	a5,a5,1
 c6c:	fef42623          	sw	a5,-20(s0)
 c70:	fd1ff06f          	j	c40 <__divsi3+0x18>
 c74:	00078513          	mv	a0,a5
 c78:	02c12403          	lw	s0,44(sp)
 c7c:	03010113          	addi	sp,sp,48
 c80:	00008067          	ret

00000c84 <__udivsi3>:
 c84:	fd010113          	addi	sp,sp,-48
 c88:	02812623          	sw	s0,44(sp)
 c8c:	03010413          	addi	s0,sp,48
 c90:	fca42e23          	sw	a0,-36(s0)
 c94:	fcb42c23          	sw	a1,-40(s0)
 c98:	fe042623          	sw	zero,-20(s0)
 c9c:	fdc42703          	lw	a4,-36(s0)
 ca0:	fd842783          	lw	a5,-40(s0)
 ca4:	00f75663          	ble	a5,a4,cb0 <__udivsi3+0x2c>
 ca8:	fec42783          	lw	a5,-20(s0)
 cac:	0240006f          	j	cd0 <__udivsi3+0x4c>
 cb0:	fdc42703          	lw	a4,-36(s0)
 cb4:	fd842783          	lw	a5,-40(s0)
 cb8:	40f707b3          	sub	a5,a4,a5
 cbc:	fcf42e23          	sw	a5,-36(s0)
 cc0:	fec42783          	lw	a5,-20(s0)
 cc4:	00178793          	addi	a5,a5,1
 cc8:	fef42623          	sw	a5,-20(s0)
 ccc:	fd1ff06f          	j	c9c <__udivsi3+0x18>
 cd0:	00078513          	mv	a0,a5
 cd4:	02c12403          	lw	s0,44(sp)
 cd8:	03010113          	addi	sp,sp,48
 cdc:	00008067          	ret

00000ce0 <__modsi3>:
 ce0:	fe010113          	addi	sp,sp,-32
 ce4:	00812e23          	sw	s0,28(sp)
 ce8:	02010413          	addi	s0,sp,32
 cec:	fea42623          	sw	a0,-20(s0)
 cf0:	feb42423          	sw	a1,-24(s0)
 cf4:	fe842703          	lw	a4,-24(s0)
 cf8:	fec42783          	lw	a5,-20(s0)
 cfc:	00e7d663          	ble	a4,a5,d08 <__modsi3+0x28>
 d00:	fec42783          	lw	a5,-20(s0)
 d04:	0180006f          	j	d1c <__modsi3+0x3c>
 d08:	fec42703          	lw	a4,-20(s0)
 d0c:	fe842783          	lw	a5,-24(s0)
 d10:	40f707b3          	sub	a5,a4,a5
 d14:	fef42623          	sw	a5,-20(s0)
 d18:	fddff06f          	j	cf4 <__modsi3+0x14>
 d1c:	00078513          	mv	a0,a5
 d20:	01c12403          	lw	s0,28(sp)
 d24:	02010113          	addi	sp,sp,32
 d28:	00008067          	ret
