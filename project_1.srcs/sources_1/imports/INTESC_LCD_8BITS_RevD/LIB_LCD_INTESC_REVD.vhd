
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE WORK.COMANDOS_LCD_REVD.ALL;

entity LIB_LCD_INTESC_REVD is

GENERIC(
			FPGA_CLK : INTEGER := 50_000_000
);


PORT(CLK: IN STD_LOGIC;

-----------------------------------------------------
------------------PUERTOS DE LA LCD------------------
	  RS 		  : OUT STD_LOGIC;							--
	  RW		  : OUT STD_LOGIC;							--
	  ENA 	  : OUT STD_LOGIC;							--
	  DATA_LCD : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);   --
-----------------------------------------------------
-----------------------------------------------------
	  
	  
-----------------------------------------------------------
--------------ABAJO ESCRIBE TUS PUERTOS--------------------	
	 	STATE: in std_logic_vector(3 downto 0)
-----------------------------------------------------------
-----------------------------------------------------------

	  );

end LIB_LCD_INTESC_REVD;

architecture Behavioral of LIB_LCD_INTESC_REVD is


CONSTANT NUM_INSTRUCCIONES : INTEGER := 28; 	--INDICAR EL NÚMERO DE INSTRUCCIONES PARA LA LCD


--------------------------------------------------------------------------------
-------------------------SEÑALES DE LA LCD (NO BORRAR)--------------------------
																										--
component PROCESADOR_LCD_REVD is																--
																										--
GENERIC(																								--
			FPGA_CLK : INTEGER := 50_000_000;												--
			NUM_INST : INTEGER := 1																--
);																										--
																										--
PORT( CLK 				 : IN  STD_LOGIC;														--
	   VECTOR_MEM 		 : IN  STD_LOGIC_VECTOR(8  DOWNTO 0);							--
	   C1A,C2A,C3A,C4A : IN  STD_LOGIC_VECTOR(39 DOWNTO 0);							--
	   C5A,C6A,C7A,C8A : IN  STD_LOGIC_VECTOR(39 DOWNTO 0);							--
	   RS 				 : OUT STD_LOGIC;														--
	   RW 				 : OUT STD_LOGIC;														--
	   ENA 				 : OUT STD_LOGIC;														--
	   BD_LCD 			 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);			         	--
	   DATA 				 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);							--
	   DIR_MEM 			 : OUT INTEGER RANGE 0 TO NUM_INSTRUCCIONES					--
	);																									--
																										--
end component PROCESADOR_LCD_REVD;															--
																										--
COMPONENT CARACTERES_ESPECIALES_REVD is													--
																										--
PORT( C1,C2,C3,C4 : OUT STD_LOGIC_VECTOR(39 DOWNTO 0);								--
		C5,C6,C7,C8 : OUT STD_LOGIC_VECTOR(39 DOWNTO 0)									--
	 );																								--
																										--
end COMPONENT CARACTERES_ESPECIALES_REVD;													--
																										--
CONSTANT CHAR1 : INTEGER := 1;																--
CONSTANT CHAR2 : INTEGER := 2;																--
CONSTANT CHAR3 : INTEGER := 3;																--
CONSTANT CHAR4 : INTEGER := 4;																--
CONSTANT CHAR5 : INTEGER := 5;																--
CONSTANT CHAR6 : INTEGER := 6;																--
CONSTANT CHAR7 : INTEGER := 7;																--
CONSTANT CHAR8 : INTEGER := 8;																--
																										--
type ram is array (0 to  NUM_INSTRUCCIONES) of std_logic_vector(8 downto 0); 	--
signal INST : ram := (others => (others => '0'));										--
																										--
signal blcd 			  : std_logic_vector(7 downto 0):= (others => '0');		--																										
signal vector_mem 	  : STD_LOGIC_VECTOR(8  DOWNTO 0) := (others => '0');		--
signal c1s,c2s,c3s,c4s : std_logic_vector(39 downto 0) := (others => '0');		--
signal c5s,c6s,c7s,c8s : std_logic_vector(39 downto 0) := (others => '0'); 	--
signal dir_mem 		  : integer range 0 to NUM_INSTRUCCIONES := 0;				--																									--
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
signal top: string(1 to 16);
signal bot_num: integer;
signal bot_0: integer :=0;
signal bot: string(1 to 16);
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

begin
---------------------------------------------------------------
-------------------COMPONENTES PARA LCD------------------------																			 --
u1: PROCESADOR_LCD_REVD													 --
GENERIC map( FPGA_CLK => FPGA_CLK,									 --
				 NUM_INST => NUM_INSTRUCCIONES )						 --
																				 --
PORT map( CLK,VECTOR_MEM,C1S,C2S,C3S,C4S,C5S,C6S,C7S,C8S,RS, --
			 RW,ENA,BLCD,DATA_LCD, DIR_MEM );						 --
																				 --
U2 : CARACTERES_ESPECIALES_REVD 										 --
PORT MAP( C1S,C2S,C3S,C4S,C5S,C6S,C7S,C8S );				 		 --
																				 --
VECTOR_MEM <= INST(DIR_MEM);											 --																			 --
---------------------------------------------------------------
---------------------------------------------------------------
INST(0) <= LCD_INI("11");
disp_message:process(clk)
begin
    if(rising_edge(clk)) then
        case state is
            when "0000" =>
                INST(1) <= POS(1,1);                
                INST(2) <= CHAR(MM);                
                INST(3) <= CHAR_ASCII(x"3A");            
                INST(4) <= CHAR_ASCII(x"53");
                INST(5) <= CHAR(e);
                INST(6) <= CHAR(r);
                INST(7) <= CHAR(v);                
                INST(8) <= CHAR(o);                
                INST(9) <= CHAR_ASCII(x"20");            
                INST(10) <= CHAR(ME);
                INST(11) <= CHAR(s);
                INST(12) <= CHAR(t);
                INST(13) <= CHAR(a);            
                INST(14) <= CHAR(t);
                INST(15) <= CHAR(i);
                INST(16) <= CHAR(c);
                INST(17) <= CHAR(o);
                INST(18) <= POS(2,1);
                INST(19) <= CHAR(MG);
                INST(20) <= CHAR(r);
                INST(21) <= CHAR(a);
                INST(22) <= CHAR(d);            
                INST(23) <= CHAR(o);
                INST(24) <= CHAR_ASCII(x"20");
                INST(25) <= CHAR_ASCII(x"20");
                INST(26) <= INT_NUM(0);
            
            when "0001" =>
                INST(1) <= POS(1,1);                
                INST(2) <= CHAR(MM);                
                INST(3) <= CHAR_ASCII(x"3A");            
                INST(4) <= CHAR_ASCII(x"53");
                INST(5) <= CHAR(e);
                INST(6) <= CHAR(r);
                INST(7) <= CHAR(v);                
                INST(8) <= CHAR(o);                
                INST(9) <= CHAR_ASCII(x"20");            
                INST(10) <= CHAR(ME);
                INST(11) <= CHAR(s);
                INST(12) <= CHAR(t);
                INST(13) <= CHAR(a);            
                INST(14) <= CHAR(t);
                INST(15) <= CHAR(i);
                INST(16) <= CHAR(c);
                INST(17) <= CHAR(o);
                INST(18) <= POS(2,1);
                INST(19) <= CHAR(MG);
                INST(20) <= CHAR(r);
                INST(21) <= CHAR(a);
                INST(22) <= CHAR(d);            
                INST(23) <= CHAR(o);
                INST(24) <= CHAR_ASCII(x"20");
                INST(25) <= CHAR_ASCII(x"20");
                INST(26) <= INT_NUM(3);
                INST(27) <= INT_NUM(0);
            
            when "0010" =>
                INST(1) <= POS(1,1);                
                INST(2) <= CHAR(MM);                
                INST(3) <= CHAR_ASCII(x"3A");            
                INST(4) <= CHAR_ASCII(x"53");
                INST(5) <= CHAR(e);
                INST(6) <= CHAR(r);
                INST(7) <= CHAR(v);                
                INST(8) <= CHAR(o);                
                INST(9) <= CHAR_ASCII(x"20");            
                INST(10) <= CHAR(ME);
                INST(11) <= CHAR(s);
                INST(12) <= CHAR(t);
                INST(13) <= CHAR(a);            
                INST(14) <= CHAR(t);
                INST(15) <= CHAR(i);
                INST(16) <= CHAR(c);
                INST(17) <= CHAR(o);
                INST(18) <= POS(2,1);
                INST(19) <= CHAR(MG);
                INST(20) <= CHAR(r);
                INST(21) <= CHAR(a);
                INST(22) <= CHAR(d);            
                INST(23) <= CHAR(o);
                INST(24) <= CHAR_ASCII(x"20");
                INST(25) <= CHAR_ASCII(x"2D");
                INST(26) <= INT_NUM(3);
                INST(27) <= INT_NUM(0);
            
            when "0011" =>
                INST(1) <= POS(1,1);                
                INST(2) <= CHAR(MM);                
                INST(3) <= CHAR_ASCII(x"3A");            
                INST(4) <= CHAR_ASCII(x"53");
                INST(5) <= CHAR(e);
                INST(6) <= CHAR(r);
                INST(7) <= CHAR(v);                
                INST(8) <= CHAR(o);                
                INST(9) <= CHAR_ASCII(x"20");            
                INST(10) <= CHAR(ME);
                INST(11) <= CHAR(s);
                INST(12) <= CHAR(t);
                INST(13) <= CHAR(a);            
                INST(14) <= CHAR(t);
                INST(15) <= CHAR(i);
                INST(16) <= CHAR(c);
                INST(17) <= CHAR(o);
                INST(18) <= POS(2,1);
                INST(19) <= CHAR(MG);
                INST(20) <= CHAR(r);
                INST(21) <= CHAR(a);
                INST(22) <= CHAR(d);            
                INST(23) <= CHAR(o);
                INST(24) <= CHAR_ASCII(x"20");
                INST(25) <= CHAR_ASCII(x"20");
                INST(26) <= INT_NUM(6);
                INST(27) <= INT_NUM(0);
            
            when "0100" =>
                INST(1) <= POS(1,1);                
                INST(2) <= CHAR(MM);                
                INST(3) <= CHAR_ASCII(x"3A");            
                INST(4) <= CHAR_ASCII(x"53");
                INST(5) <= CHAR(e);
                INST(6) <= CHAR(r);
                INST(7) <= CHAR(v);                
                INST(8) <= CHAR(o);                
                INST(9) <= CHAR_ASCII(x"20");            
                INST(10) <= CHAR(ME);
                INST(11) <= CHAR(s);
                INST(12) <= CHAR(t);
                INST(13) <= CHAR(a);            
                INST(14) <= CHAR(t);
                INST(15) <= CHAR(i);
                INST(16) <= CHAR(c);
                INST(17) <= CHAR(o);
                INST(18) <= POS(2,1);
                INST(19) <= CHAR(MG);
                INST(20) <= CHAR(r);
                INST(21) <= CHAR(a);
                INST(22) <= CHAR(d);            
                INST(23) <= CHAR(o);
                INST(24) <= CHAR_ASCII(x"20");
                INST(25) <= CHAR_ASCII(x"2D");
                INST(26) <= INT_NUM(6);
                INST(27) <= INT_NUM(0);
            
            when "0101" =>
                INST(1) <= POS(1,1);                
                INST(2) <= CHAR(MM);                
                INST(3) <= CHAR_ASCII(x"3A");            
                INST(4) <= CHAR_ASCII(x"53");
                INST(5) <= CHAR(e);
                INST(6) <= CHAR(r);
                INST(7) <= CHAR(v);                
                INST(8) <= CHAR(o);                
                INST(9) <= CHAR_ASCII(x"20");            
                INST(10) <= CHAR(ME);
                INST(11) <= CHAR(s);
                INST(12) <= CHAR(t);
                INST(13) <= CHAR(a);            
                INST(14) <= CHAR(t);
                INST(15) <= CHAR(i);
                INST(16) <= CHAR(c);
                INST(17) <= CHAR(o);
                INST(18) <= POS(2,1);
                INST(19) <= CHAR(MG);
                INST(20) <= CHAR(r);
                INST(21) <= CHAR(a);
                INST(22) <= CHAR(d);            
                INST(23) <= CHAR(o);
                INST(24) <= CHAR_ASCII(x"20");
                INST(25) <= CHAR_ASCII(x"20");
                INST(26) <= INT_NUM(9);
                INST(27) <= INT_NUM(0);
            
            when "0110" =>
                INST(1) <= POS(1,1);                
                INST(2) <= CHAR(MM);                
                INST(3) <= CHAR_ASCII(x"3A");            
                INST(4) <= CHAR_ASCII(x"53");
                INST(5) <= CHAR(e);
                INST(6) <= CHAR(r);
                INST(7) <= CHAR(v);                
                INST(8) <= CHAR(o);                
                INST(9) <= CHAR_ASCII(x"20");            
                INST(10) <= CHAR(ME);
                INST(11) <= CHAR(s);
                INST(12) <= CHAR(t);
                INST(13) <= CHAR(a);            
                INST(14) <= CHAR(t);
                INST(15) <= CHAR(i);
                INST(16) <= CHAR(c);
                INST(17) <= CHAR(o);
                INST(18) <= POS(2,1);
                INST(19) <= CHAR(MG);
                INST(20) <= CHAR(r);
                INST(21) <= CHAR(a);
                INST(22) <= CHAR(d);            
                INST(23) <= CHAR(o);
                INST(24) <= CHAR_ASCII(x"20");
                INST(25) <= CHAR_ASCII(x"2D");
                INST(26) <= INT_NUM(9);
                INST(27) <= INT_NUM(0);
            when "0111" =>
                INST(1) <= POS(1,1);                
                INST(2) <= CHAR(MM);                
                INST(3) <= CHAR_ASCII(x"3A");            
                INST(4) <= CHAR_ASCII(x"53");
                INST(5) <= CHAR(e);
                INST(6) <= CHAR(r);
                INST(7) <= CHAR(v);                
                INST(8) <= CHAR(o);                
                INST(9) <= CHAR_ASCII(x"20");            
                INST(10) <= CHAR(MC);
                INST(11) <= CHAR(o);
                INST(12) <= CHAR(n);
                INST(13) <= CHAR(t);            
                INST(14) <= CHAR(i);
                INST(15) <= CHAR(n);
                INST(16) <= CHAR(u);
                INST(17) <= CHAR(o);
                INST(18) <= POS(2,1);
                INST(19) <= CHAR(MV);
                INST(20) <= CHAR(e);
                INST(21) <= CHAR(l);
                INST(22) <= CHAR(o);            
                INST(23) <= CHAR(c);
                INST(24) <= CHAR_ASCII(x"20");
                INST(25) <= CHAR(S);
                INST(26) <= CHAR(T);
                INST(27) <= CHAR(P);
            when "1000" =>
                INST(1) <= POS(1,1);                
                INST(2) <= CHAR(MM);                
                INST(3) <= CHAR_ASCII(x"3A");            
                INST(4) <= CHAR_ASCII(x"53");
                INST(5) <= CHAR(e);
                INST(6) <= CHAR(r);
                INST(7) <= CHAR(v);                
                INST(8) <= CHAR(o);                
                INST(9) <= CHAR_ASCII(x"20");            
                INST(10) <= CHAR(MC);
                INST(11) <= CHAR(o);
                INST(12) <= CHAR(n);
                INST(13) <= CHAR(t);            
                INST(14) <= CHAR(i);
                INST(15) <= CHAR(n);
                INST(16) <= CHAR(u);
                INST(17) <= CHAR(o);
                INST(18) <= POS(2,1);
                INST(19) <= CHAR(MV);
                INST(20) <= CHAR(e);
                INST(21) <= CHAR(l);
                INST(22) <= CHAR(o);            
                INST(23) <= CHAR(c);
                INST(24) <= CHAR_ASCII(x"20");
                INST(25) <= CHAR(MI);
                INST(26) <= CHAR_ASCII(x"20");
                INST(27) <= CHAR(ML);
            when "1001" =>
                INST(1) <= POS(1,1);                
                INST(2) <= CHAR(MM);                
                INST(3) <= CHAR_ASCII(x"3A");            
                INST(4) <= CHAR_ASCII(x"53");
                INST(5) <= CHAR(e);
                INST(6) <= CHAR(r);
                INST(7) <= CHAR(v);                
                INST(8) <= CHAR(o);                
                INST(9) <= CHAR_ASCII(x"20");            
                INST(10) <= CHAR(MC);
                INST(11) <= CHAR(o);
                INST(12) <= CHAR(n);
                INST(13) <= CHAR(t);            
                INST(14) <= CHAR(i);
                INST(15) <= CHAR(n);
                INST(16) <= CHAR(u);
                INST(17) <= CHAR(o);
                INST(18) <= POS(2,1);
                INST(19) <= CHAR(MV);
                INST(20) <= CHAR(e);
                INST(21) <= CHAR(l);
                INST(22) <= CHAR(o);            
                INST(23) <= CHAR(c);
                INST(24) <= CHAR_ASCII(x"20");
                INST(25) <= CHAR(MD);
                INST(26) <= CHAR_ASCII(x"20");
                INST(27) <= CHAR(ML);
            when "1010" =>
                INST(1) <= POS(1,1);                
                INST(2) <= CHAR(MM);                
                INST(3) <= CHAR_ASCII(x"3A");            
                INST(4) <= CHAR_ASCII(x"53");
                INST(5) <= CHAR(e);
                INST(6) <= CHAR(r);
                INST(7) <= CHAR(v);                
                INST(8) <= CHAR(o);                
                INST(9) <= CHAR_ASCII(x"20");            
                INST(10) <= CHAR(MC);
                INST(11) <= CHAR(o);
                INST(12) <= CHAR(n);
                INST(13) <= CHAR(t);            
                INST(14) <= CHAR(i);
                INST(15) <= CHAR(n);
                INST(16) <= CHAR(u);
                INST(17) <= CHAR(o);
                INST(18) <= POS(2,1);
                INST(19) <= CHAR(MV);
                INST(20) <= CHAR(e);
                INST(21) <= CHAR(l);
                INST(22) <= CHAR(o);            
                INST(23) <= CHAR(c);
                INST(24) <= CHAR_ASCII(x"20");
                INST(25) <= CHAR(MI);
                INST(26) <= CHAR_ASCII(x"20");
                INST(27) <= CHAR(MM);
            when "1011" =>
                INST(1) <= POS(1,1);                
                INST(2) <= CHAR(MM);                
                INST(3) <= CHAR_ASCII(x"3A");            
                INST(4) <= CHAR_ASCII(x"53");
                INST(5) <= CHAR(e);
                INST(6) <= CHAR(r);
                INST(7) <= CHAR(v);                
                INST(8) <= CHAR(o);                
                INST(9) <= CHAR_ASCII(x"20");            
                INST(10) <= CHAR(MC);
                INST(11) <= CHAR(o);
                INST(12) <= CHAR(n);
                INST(13) <= CHAR(t);            
                INST(14) <= CHAR(i);
                INST(15) <= CHAR(n);
                INST(16) <= CHAR(u);
                INST(17) <= CHAR(o);
                INST(18) <= POS(2,1);
                INST(19) <= CHAR(MV);
                INST(20) <= CHAR(e);
                INST(21) <= CHAR(l);
                INST(22) <= CHAR(o);            
                INST(23) <= CHAR(c);
                INST(24) <= CHAR_ASCII(x"20");
                INST(25) <= CHAR(MD);
                INST(26) <= CHAR_ASCII(x"20");
                INST(27) <= CHAR(MM);
            when "1100" =>
                INST(1) <= POS(1,1);                
                INST(2) <= CHAR(MM);                
                INST(3) <= CHAR_ASCII(x"3A");            
                INST(4) <= CHAR_ASCII(x"53");
                INST(5) <= CHAR(e);
                INST(6) <= CHAR(r);
                INST(7) <= CHAR(v);                
                INST(8) <= CHAR(o);                
                INST(9) <= CHAR_ASCII(x"20");            
                INST(10) <= CHAR(MC);
                INST(11) <= CHAR(o);
                INST(12) <= CHAR(n);
                INST(13) <= CHAR(t);            
                INST(14) <= CHAR(i);
                INST(15) <= CHAR(n);
                INST(16) <= CHAR(u);
                INST(17) <= CHAR(o);
                INST(18) <= POS(2,1);
                INST(19) <= CHAR(MV);
                INST(20) <= CHAR(e);
                INST(21) <= CHAR(l);
                INST(22) <= CHAR(o);            
                INST(23) <= CHAR(c);
                INST(24) <= CHAR_ASCII(x"20");
                INST(25) <= CHAR(MI);
                INST(26) <= CHAR_ASCII(x"20");
                INST(27) <= CHAR(MR);
            when "1101" =>
                INST(1) <= POS(1,1);                
                INST(2) <= CHAR(MM);                
                INST(3) <= CHAR_ASCII(x"3A");            
                INST(4) <= CHAR_ASCII(x"53");
                INST(5) <= CHAR(e);
                INST(6) <= CHAR(r);
                INST(7) <= CHAR(v);                
                INST(8) <= CHAR(o);                
                INST(9) <= CHAR_ASCII(x"20");            
                INST(10) <= CHAR(MC);
                INST(11) <= CHAR(o);
                INST(12) <= CHAR(n);
                INST(13) <= CHAR(t);            
                INST(14) <= CHAR(i);
                INST(15) <= CHAR(n);
                INST(16) <= CHAR(u);
                INST(17) <= CHAR(o);
                INST(18) <= POS(2,1);
                INST(19) <= CHAR(MV);
                INST(20) <= CHAR(e);
                INST(21) <= CHAR(l);
                INST(22) <= CHAR(o);            
                INST(23) <= CHAR(c);
                INST(24) <= CHAR_ASCII(x"20");
                INST(25) <= CHAR(MD);
                INST(26) <= CHAR_ASCII(x"20");
                INST(27) <= CHAR(MR);

            when others => null;
        end case;
    end if;
end process;
INST(28) <= CODIGO_FIN(1);      
-------------------------------------------------------------------
-------------------------------------------------------------------
end Behavioral;
