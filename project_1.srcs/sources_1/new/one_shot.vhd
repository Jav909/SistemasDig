----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/25/2020 10:14:35 PM
-- Design Name: 
-- Module Name: one_shot - Behavioral
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
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity One_Shot is
    Port ( Din, clk: in std_logic;
    Qout: out std_logic);
end One_Shot;

architecture Behavioral of One_Shot is
signal Q1, Q2, Q3: std_logic;

begin
process(clk)
begin
    if(clk ='1' and clk'event) then
        Q1 <= Din;
        Q2 <= Q1;
        Q3 <= Q2;
    end if;
end process;
Qout <= Q1 and Q2 and not Q3;

end Behavioral;
