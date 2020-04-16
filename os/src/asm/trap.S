.section .text 
.global m_trap_vector
.align 4
m_trap_vector: 
	call m_trap
	jalr a0