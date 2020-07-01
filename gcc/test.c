#include"print.h"

//typedef unsigned int uint;
int a = 7;
//uint key_addr  = 0xaaaaaf00;


	
	 

int main(void) {
	/*
	//keyload
	uint key[3]={0x0cbae3cf,0xf3cf30c3,0x3cf3cf3c};
	//uint key[3]={0,0,0};
	uint key_end = 3;
	uint w = 0;
	while (w < key_end) {
		//print(key[w]);
		uint * q = (uint *) (key_addr + w); 
		*q=key[w];
		w+=1;
	}	
	
	*/
	int b = 3;
	int c = a + b;
    	print(a); 
	print(b);	
   	print(c);
    while(1); 	
	return 0;
}
