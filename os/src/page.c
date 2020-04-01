#include"page.h" 

extern usize HEAP_SIZE;
extern usize HEAP_START; 

usize PAGE_SIZE = 256; 

void mem_init() {
	usize num_pages = HEAP_SIZE / PAGE_SIZE; 
	Page * ptr = (Page *)HEAP_START; 
	int i; 
	for (i = 0; i < num_pages; i++) {
		(ptr + i)->flags = Empty;
	}
	ALLOC_START = (HEAP_START + num_pages * sizeof(Page) + PAGE_SIZE - 1) & !(PAGE_SIZE - 1); 
}

void * alloc(usize pages) {
	usize num_pages = HEAP_SIZE / PAGE_SIZE; 
	Page * ptr = (Page *)HEAP_START; 
	int i; 
	for (i = 0; i < (num_pages - pages); i++) {
		char found = 0; 
		if ((ptr + i)->flags == Empty) {
			found = 1; 
			for (int j = i; j < i + pages; j++) {
				if ((ptr + j)->flags != Empty) {
					found = 0;
					break;
				}
			}
		}

		if (found) {
			for (int k = i; k < i + pages - 1; k++) {
				(ptr + k)->flags = Taken; 
			}
			(ptr + i + pages - 1)->flags = Last | Taken; 

			return (void *)(ALLOC_START + PAGE_SIZE * i); 
		}
	}
}