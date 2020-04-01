.section .rodata 
.global HEAP_START 
HEAP_START: .word _heap_start 

.global HEAP_END
HEAP_END: .word _heap_end

.global HEAP_SIZE
HEAP_SIZE: .word _heap_size 

