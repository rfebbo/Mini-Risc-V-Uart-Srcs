.section .data 

.section .text.start
.global _start 
_start: 
	# li sp, 2044
	la sp, _sp0
	la ra, _endloop 
	jal kinit

	la t0, m_trap_vector
	csrw mtvec, t0 

	jal main

_endloop:
	j _endloop