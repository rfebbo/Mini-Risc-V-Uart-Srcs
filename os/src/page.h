#ifndef PAGE_H 
#define PAGE_H 

typedef unsigned int size_t;
typedef unsigned int u32;
typedef unsigned int usize;
typedef unsigned char u8;

usize ALLOC_START;

typedef struct {
	u8 flags;
} Page;

enum PageBits { 
	Empty = 0, 
	Taken = 1 << 0, 
	Last = 1 << 1, 
};

void * alloc(usize pages);
void * zalloc(usize pages);
void mem_init(); 



#endif 