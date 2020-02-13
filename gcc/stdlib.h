#ifndef STDLIB
#define STDLIB

typedef unsigned int size_t;
typedef unsigned int u32;
typedef unsigned int usize;
typedef unsigned char u8;

usize PAGE_SIZE = 4096;

struct Page {
	u8 flags;
};

void * memcpy(void * dest, void * source, size_t num); 
void * malloc(size_t size);

void * alloc(usize pages);

#endif