----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/19/2018 11:08:28 PM
-- Design Name: 
-- Module Name: DB - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

--combines CDiv.vhd and SingPul.vhd to create a debounced clock pulse triggered by a pushbutton
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DB is
  Port
  (
    Key, Clk : in  STD_LOGIC;
    pulse    : out std_logic
  );
end DB;

architecture Behavioral of DB is
  signal Clk1 : std_logic;
    
  component CDiv
    Port
    (
      Cin  : in  std_logic;
      Cout : out std_logic
    );
  end component;
    
  component SingPul
    Port
    (
      Clk1, Key : in  std_logic;
      pulse     : out std_logic
    );
  end component;

begin
  CDiv1    : CDiv    PORT MAP(Cin=>Clk, Cout=>Clk1);
  SingPul1 : SingPul PORT MAP(Clk1=>Clk1, Key=>Key, pulse=>pulse);
end Behavioral;
