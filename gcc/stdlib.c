#include"stdlib.h"

extern usize HEAP_SIZE;
extern usize HEAP_START; 



void * alloc(usize pages) {
	usize num_pages = HEAP_SIZE / PAGE_SIZE; 
	struct Page * ptr = (struct Page *)HEAP_START; 
	int i;
	for (i = 0; i < (num_pages - pages); i++) {
		char found = 0; 
		Page p = (struct Page *)(ptr + i); 
	}
}

void * memcpy(void * dest, void * src, size_t num) {
	size_t i = 0; 
	char c;
	while(i < num) {
		c = ((char *)(src + i))[0];
		char * ptr = (char*)(dest + i);
		*ptr = c;
		// *(dest + i) = *ptr; 
		i++; 
	}
	return dest; 
}

void * malloc(size_t size) {
	void *ptr; 
	char c[size+4]; 
	for (int i = 0; i < (size + 4); i++) 
		c[i] = 0; 
	ptr = &c[0];
	return ptr;
}

int __mulsi3(int a, int b) {
	int product = 0; 
	int i;
	if (b < 0) {
		a = 0 - a; 
		b = 0 - b;
	}
	for (i = 0; i < b; i++) {
		product += a; 
	}
	return product;
}

int __divsi3(int a, int b) {
	int cnt = 0; 
	while(1) {
		if (a < b) return cnt; 
		a = a - b; 
		cnt++;
	}
}

int __modsi3(int a, int b) {
	
	while(1) {
		if (b > a) return a;
		a = a - b;
	}
}