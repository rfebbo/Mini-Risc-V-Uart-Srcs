#include"uart.h"
// #include"print.h"
#include"utils.h"

int main(void) {
	uart_init();

	char h1[] = "LAA Test\r\n";
	uart_print(h1);
	int test = 0;

	int matrixC[9] = { 0,  0, 0,  0, 0, 0, 0, 0, 0 };
	// Result should be { 177, 149, 100, 149, 133, 102, 19, 19, 16 }

	char h4[] = "Multiplying matrices...\r\n";
	uart_print(h4);

	// Matrix A
	test = 2;
	test = 12;
	test = 4;
	test = 5;
	test = 6;
	test = 8;
	test = 1;
	test = 1;
	test = 2;

	// Matix B
	test = 7;
	test = 3;
	test = 8;
	test = 11;
	test = 9;
	test = 5;
	test = 6;
	test = 8;
	test = 4;

	int status = 0; // mm
	do {
		// Read LAA control reg. into status register
		status = 0; // mlw a5, ctrl
		status = 0; // nop
		status = 0; // nop
		status = 0; // nop
		// nop
	} while (status == 0); // beqz a5, #do

	char h5[] = "Retrieving resultant matrix\r\n";
	uart_print(h5);

	test = 0; // mlw a0,matA[0]
	test = 0; // mlw a1,matA[1]
	test = 0; // mlw a2,matA[2]
	test = 0; // mlw a3,matA[3]
	test = 0; // mlw a4,matA[4]
	test = 0; // mlw a5,matA[5]
	test = 0; // mlw a6,matA[6]
	test = 0; // mlw a7,matA[7]
	test = 0; // mlw a8,matA[8]

	matrixC[0] = test;
	matrixC[1] = test;
	matrixC[2] = test;
	matrixC[3] = test;
	matrixC[4] = test;
	matrixC[5] = test;
	matrixC[6] = test;
	matrixC[7] = test;
	matrixC[8] = test;

	char num_str[16];
	char* space = " ";
	for (int i = 0; i < 9; i++) {
		itoa(matrixC[i], num_str);
		uart_print(num_str);
		uart_print(space);
	}

	return 0;
}
