library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity main_pwm is  
port (
    clk100m : in std_logic;
    BTN: in std_logic;
    Mode: in std_logic;
    LR: in std_logic;
    RST: in std_logic;
    LED: out std_logic_vector(3 downto 0);
    pwm_continous : out std_logic;
    pwm_static : out std_logic;
    RS, RW, ENA: out std_logic;
    DATA_LCD: out std_logic_vector(7 downto 0)
);
end main_pwm;

architecture Behavioral of main_pwm is
-- 
subtype u20 is unsigned(19 downto 0);
signal counter      : u20 := x"00000";

constant clk_freq   : integer := 50_000_000;        
constant pwm_freq   : integer := 50;               
constant period     : integer := clk_freq/pwm_freq; 
signal duty_cycle : integer := 0;    

signal pwm_counter  : std_logic := '0';
signal stateHigh    : std_logic := '1';

signal clk50m       : std_logic;
signal reset        : std_logic;
signal locked       : std_logic;

signal state: integer range 0 to 3 := 0;
signal msg: integer range 0 to 14;

signal btn_in: std_logic;
signal btn_rst: std_logic;

signal flag: std_logic_vector(3 downto 0);

component clock
    Port ( clk50m: out std_logic;
    reset: in std_logic;
    locked: out std_logic;
    clk_in1: in std_logic);
end component;

component one_shot
    Port ( Din, clk: in std_logic;
    Qout: out std_logic);
end component;

component LIB_LCD_INTESC_REVD
    PORT(CLK: IN STD_LOGIC;
    RS: OUT STD_LOGIC;						
    RW: OUT STD_LOGIC;
    ENA: OUT STD_LOGIC;
    DATA_LCD: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    STATE: in std_logic_vector(3 downto 0));
end component;

begin

clock_instance: clock port map (clk50m => clk50m, reset => reset, locked => locked, clk_in1 => clk100m );
one_shot_instance_g: one_shot port map (Din => BTN, clk => clk50m, Qout => btn_in);
one_shot_instance_r: one_shot port map (Din => RST, clk => clk50m, Qout => btn_rst);

selector: process(clk50m, btn_rst)
begin
    if(btn_rst = '1') then
        state <= 0;
    elsif(rising_edge(clk50m)) then
        case state is
            when 0=>
                led(0) <= '1';
                led(1) <= '0';
                led(2) <= '0';
                led(3) <= '0';
                if(btn_in = '1') then
                    state <= 1;
                else
                    state <= 0;
                end if;
            when 1=>
                led(0) <= '0';
                led(1) <= '1';
                led(2) <= '0';
                led(3) <= '0';
                if(btn_in = '1') then
                    state <= 2;
                else
                    state <= 1;
                end if;
            when 2=>
                led(0) <= '0';
                led(1) <= '0';
                led(2) <= '1';
                led(3) <= '0';
                if(btn_in = '1') then
                    state <= 3;
                else
                    state <= 2;
                end if;
            when 3=>
                led(0) <= '0';
                led(1) <= '0';
                led(2) <= '0';
                led(3) <= '1';
                if(btn_in = '1') then
                    state <= 0;
                else
                    state <= 3;
                end if;
        end case;
    end if;
end process;

duty_cycle <= 75000 when (state = 0 and Mode = '0')
            else 91666 when (state = 1 and Mode = '0' and LR = '1')
            else 58334 when (state = 1 and Mode = '0')
            else 108332 when (state = 2 and Mode = '0' and LR = '1')
            else 41668 when (state = 2 and Mode = '0')
            else 125000 when (state = 3 and Mode = '0' and LR = '1')
            else 25000 when (state = 3 and Mode = '0')
            else 76200 when (state = 0 and Mode = '1')
            else 77800 when (state = 1 and Mode = '1' and LR = '1')
            else 76000 when (state = 1 and Mode = '1')
            else 78000 when (state = 2 and Mode = '1' and LR = '1')
            else 75800 when (state = 2 and Mode = '1')
            else 78400 when (state = 3 and Mode = '1' and LR = '1')
            else 75400 when (state = 3 and Mode = '1');

flag <= "0000" when (duty_cycle = 75000)
        else "0001" when (duty_cycle = 91666)
        else "0010" when (duty_cycle = 58334)
        else "0011" when (duty_cycle = 108332)
        else "0100" when (duty_cycle = 41668)
        else "0101" when (duty_cycle = 125000)
        else "0110" when (duty_cycle = 25000)
        else "0111" when (duty_cycle = 76200)
        else "1000" when (duty_cycle = 77800)
        else "1001" when (duty_cycle = 76000)
        else "1010" when (duty_cycle = 78000)
        else "1011" when (duty_cycle = 75800)
        else "1100" when (duty_cycle = 78400)
        else "1101" when (duty_cycle = 75400);

display: LIB_LCD_INTESC_REVD port map(clk50m, RS, RW, ENA, DATA_LCD, flag);

pwm_generator : process(clk50m) is
variable cur : u20 := counter;
begin
    if (rising_edge(clk50m)) then
        cur := cur + 1;  
        counter <= cur;
        if (cur <= duty_cycle) then
            pwm_counter <= '1'; 
        elsif (cur > duty_cycle) then
            pwm_counter <= '0';
        elsif (cur = period) then
            cur := x"00000";
        end if;  
    end if;
end process pwm_generator;

pwm: process(clk50m) is
begin
    if (rising_edge(clk50m)) then
        if(Mode = '0') then
            pwm_static <= pwm_counter;
            pwm_continous <= '0';
        else
            pwm_continous <= pwm_counter;
            pwm_static <= '0';
        end if;
    end if;
end process pwm;

end Behavioral;