// #include"uart.h"
// #include"print.h"
// #include"utils.h"

int main(void) {
	//uart_init();

	//char h1[] = "LAA Test\r\n";
	//uart_print(h1);
	int test = 0;

	// int matrixA[9] = { 3, 12, 4,  5, 6, 8, 1, 0, 2 };
	// int matrixB[9] = { 7,  3, 8, 11, 9, 5, 6, 8, 4 };
	int matrixC[9] = { 0,  0, 0,  0, 0, 0, 0, 0, 0 };
	// Result should be { 177, 149, 100, 149, 133, 102, 19, 19, 16 }

	//char h2[] = "Loading matrix A\r\n";
	//uart_print(h2);
	test = 2;
	test = 12;
	test = 4;
	test = 5;
	test = 6;
	test = 8;
	test = 1;
	test = 0;
	test = 2;

	// char h3[] = "Loading matrix B\r\n";
	// uart_print(h3);
	test = 7;
	test = 3;
	test = 8;
	test = 11;
	test = 9;
	test = 5;
	test = 6;
	test = 8;
	test = 4;

	//char h4[] = "Multiplying matrices...\r\n";
	//uart_print(h4);
	int status = 0;
	do {
		// Read LAA control reg. into status register
		status = 0;
		status = 0;
	} while (status == 0);

	//char h5[] = "Retrieving resultant matrix\r\n";
	//uart_print(h5);
	matrixC[0] = test;
	matrixC[1] = test;
	matrixC[2] = test;
	matrixC[3] = test;
	matrixC[4] = test;
	matrixC[5] = test;
	matrixC[6] = test;
	matrixC[7] = test;
	matrixC[8] = test;

	// char num_str[16];
	// for (int i = 0; i < 9; i++) {
	// 	itoa(matrixC[i], num_str);
	// 	uart_print(num_str);
	// }

	return 0;
}
