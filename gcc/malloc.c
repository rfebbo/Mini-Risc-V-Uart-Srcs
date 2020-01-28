#include<stdlib.h> 
#include<stdio.h> 

int main(void) {
	int *ptr; 
	int n, i; 

	n = 5; 
	ptr = (int*)malloc(n * sizeof(int)); 
	// ptr2 = (int*)malloc(n * sizeof(int));
	// for (i = 0; i < n; ++i) {
	// 	ptr[i] = i + 1; 
	// } 
	ptr[0] = 1;
	ptr[1] = 2;
	ptr[2] = 3; 
	ptr[3] = 4; 
	ptr[4] = 5;
	// ptr[5] = 6;
	ptr[8] = 7;
	for (i = 0; i < 10; ++i)
		printf("%d, %p\n", ptr[i], ptr + i);

	// printf("%d, %p\n", ptr[6], ptr + 8);
	// printf("%d, %p\n", ptr2[0], ptr2);
	return 0;
}
