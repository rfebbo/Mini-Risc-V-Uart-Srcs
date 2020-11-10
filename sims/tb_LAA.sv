`timescale 1ns / 1ps

module tb_LAA();

    logic clk = 0;
    logic reset = 0;
    LAA_bus bus(clk, reset);

    LAA laa0 (bus);
    
    // Run clock (2ns/cycle)
    always begin
        clk <= ~clk; #1;
        clk <= ~clk; #1;
    end
    
	// Monitor results for changes
	initial begin
		$monitor($time, " Read %h", bus.data_out);
	end
    
    // Run tests
    initial begin
        // Reset
        $display($time, " Resetting");
        reset = 1; #2;
        reset = 0; #2;
        
        // Load Matrix A
        $display($time, " Loading Matrix A");
        bus.opcode = WRITE;
        bus.addr = 5'b00000; bus.data_in = 3; #2; // A00
        bus.addr = 5'b00001; bus.data_in = 12;#2; // A01
        bus.addr = 5'b00010; bus.data_in = 4; #2; // A02
        
        bus.addr = 5'b00011; bus.data_in = 5; #2; // A10
        bus.addr = 5'b00100; bus.data_in = 6; #2; // A11
        bus.addr = 5'b00101; bus.data_in = 8; #2; // A12
        
        bus.addr = 5'b00110; bus.data_in = 1; #2; // A20
        bus.addr = 5'b00111; bus.data_in = 0; #2; // A21
        bus.addr = 5'b01000; bus.data_in = 2; #2; // A22
        bus.opcode = NONE;
        
        // Load Matrix B
        $display($time, " Loading Matrix B");
        bus.opcode = WRITE;
        bus.addr = 5'b01001; bus.data_in = 7; #2; // B00
        bus.addr = 5'b01010; bus.data_in = 3; #2; // B01
        bus.addr = 5'b01011; bus.data_in = 8; #2; // B02
        
        bus.addr = 5'b01100; bus.data_in = 11;#2; // B10
        bus.addr = 5'b01101; bus.data_in = 9; #2; // B11
        bus.addr = 5'b01110; bus.data_in = 5; #2; // B12
        
        bus.addr = 5'b01111; bus.data_in = 6; #2; // B20
        bus.addr = 5'b10000; bus.data_in = 8; #2; // B21
        bus.addr = 5'b10001; bus.data_in = 4; #2; // B22
        bus.opcode = NONE;
        
        // Multiply
        $display($time, " Multiplying");
        bus.opcode = MULTIPLY; #4;
        bus.opcode = READ; bus.addr = 5'b11111; #20;
        bus.opcode = NONE; #2;
        
        // Read Matrix A (result)
        $display($time, " Reading Matrix A");
        bus.opcode = READ; 
        bus.addr = 5'b00000; #2; // A00 (expect 177 = 0xb1)
        bus.addr = 5'b00001; #2; // A01 (expect 149 = 0x95)
        bus.addr = 5'b00010; #2; // A02 (expect 100 = 0x64)
        
        bus.addr = 5'b00011; #2; // A10 (expect 149 = 0x95)
        bus.addr = 5'b00100; #2; // A11 (expect 133 = 0x85)
        bus.addr = 5'b00101; #2; // A12 (expect 102 = 0x66)
        
        bus.addr = 5'b00110; #2; // A20 (expect  19 = 0x13)
        bus.addr = 5'b00111; #2; // A21 (expect  19 = 0x13)
        bus.addr = 5'b01000; #2; // A22 (expect  16 = 0x10)
    end
endmodule
