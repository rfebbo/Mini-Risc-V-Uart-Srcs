#include"print.h" 

int main(void) {
	int a = 3; 
	int tot = 0; 
	while(a > 0) {
		tot += a; 
		print(tot);
		a--; 
	}
	while(1); 
	return 0;
}
