// #include"uart.h"
// #include"print.h"
// #include"utils.h"

int main(void) {
	//uart_init();

	//char h1[] = "LAA Test\r\n";
	//uart_print(h1);
	int test = 0;

	int matrixA[9] = { 3, 12, 4,  5, 6, 8, 1, 0, 2 };
	int matrixB[9] = { 7,  3, 8, 11, 9, 5, 6, 8, 4 };
	int matrixC[9] = { 0,  0, 0,  0, 0, 0, 0, 0, 0 };
	// Result should be { 177, 149, 100, 149, 133, 102, 19, 19, 16 }

	//char h2[] = "Loading matrix A\r\n";
	//uart_print(h2);
	test = matrixA[0];
	test = matrixA[1];
	test = matrixA[2];
	test = matrixA[3];
	test = matrixA[4];
	test = matrixA[5];
	test = matrixA[6];
	test = matrixA[7];
	test = matrixA[8];

	// char h3[] = "Loading matrix B\r\n";
	// uart_print(h3);
	test = matrixB[0];
	test = matrixB[1];
	test = matrixB[2];
	test = matrixB[3];
	test = matrixB[4];
	test = matrixB[5];
	test = matrixB[6];
	test = matrixB[7];
	test = matrixB[8];

	//char h4[] = "Multiplying matrices...\r\n";
	//uart_print(h4);
	int status = 0;
	do {
		// Read LAA control reg. into status register
		status = 0;
		status = 0;
		status = 0;
		status = 0;
		status = 0;
		status = 0;
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
