.section .data 

.section .text.init 
.global _start 
_start: 
	li sp, 2044
	la ra, _endloop 
	jal main

_endloop:
	j _endloop