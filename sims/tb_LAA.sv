`timescale 1ns / 1ps

module tb_LAA();

    logic [4:0] addr = 5'b00000; // A or B (1 bit), addr (4 bits), all 1s to multiply
    logic [31:0] data_in = 32'h00000000; // Data to be written
    logic operate = 0;
    logic clk = 0;
    logic reset = 0; // Reset all registers to 0
    logic [31:0] data_out = 32'h00000000; // Output of register at current address

    LAA laa0 (addr, data_in, clk, operate, reset, data_out);
    
    // Run clock (2ns/cycle)
    always begin
        clk <= ~clk; #1;
    end
    
	// Monitor results for changes
	initial begin
		$monitor($time, " Read %h", data_out);
	end
    
    // Run tests
    initial begin
        // Reset
        $display($time, " Resetting");
        reset = 1; #2;
        reset = 0; #2;
        
        // Load Matrix A
        $display($time, " Loading Matrix A");
        operate = 1;
        addr = 5'b00000; data_in = 3; #2; // A00
        addr = 5'b00001; data_in = 12;#2; // A01
        addr = 5'b00010; data_in = 4; #2; // A02
        
        addr = 5'b00011; data_in = 5; #2; // A10
        addr = 5'b00100; data_in = 6; #2; // A11
        addr = 5'b00101; data_in = 8; #2; // A12
        
        addr = 5'b00110; data_in = 1; #2; // A20
        addr = 5'b00111; data_in = 0; #2; // A21
        addr = 5'b01000; data_in = 2; #2; // A22
        operate = 0;
        
        // Load Matrix B
        $display($time, " Loading Matrix B");
        operate = 1;
        addr = 5'b10000; data_in = 7; #2; // B00
        addr = 5'b10001; data_in = 3; #2; // B01
        addr = 5'b10010; data_in = 8; #2; // B02
        
        addr = 5'b10011; data_in = 11;#2; // B10
        addr = 5'b10100; data_in = 9; #2; // B11
        addr = 5'b10101; data_in = 5; #2; // B12
        
        addr = 5'b10110; data_in = 6; #2; // B20
        addr = 5'b10111; data_in = 8; #2; // B21
        addr = 5'b11000; data_in = 4; #2; // B22
        operate = 0;
        
        // Multiply
        $display($time, " Multiplying");
        operate = 1;
        addr = 5'b11111; #2;
        operate = 0;
        
        // Read Matrix A (result)
        $display($time, " Reading Matrix A");
        addr = 5'b00000; #2; // A00
        addr = 5'b00001; #2; // A01
        addr = 5'b00010; #2; // A02
        
        addr = 5'b00011; #2; // A10
        addr = 5'b00100; #2; // A11
        addr = 5'b00101; #2; // A12
        
        addr = 5'b00110; #2; // A20
        addr = 5'b00111; #2; // A21
        addr = 5'b01000; #2; // A22
    end
endmodule
