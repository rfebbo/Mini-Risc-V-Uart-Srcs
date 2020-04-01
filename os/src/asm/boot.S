.section .data 

.section .text.init 
.global _start 
_start: 
	# li sp, 2044
	la sp, _sp0
	la ra, _endloop 
	jal kinit
	jal main

_endloop:
	j _endloop