library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Matrix_Controler_TB is
end Matrix_Controler_TB;

architecture Behavioral of Matrix_Controler_TB is

    component Matrix_Control is
    generic(
    FREQ_SYSTEM: positive;
    FREQ_LED: positive;
    FREQ_UART : positive
    );
    port(
    CLK: in std_logic;
    rows : out std_logic_vector(7 downto 0);
    cols : out std_logic_vector(15 downto 0);
    
    RX: in std_logic;
    RX_VALID: inout std_logic;
    RX_DATA: inout std_logic_vector(7 downto 0)
    );
    end component;
    
    
    signal CLK: std_logic;
    signal rows: std_logic_vector(7 downto 0);
    signal cols: std_logic_vector(15 downto 0);
    
    signal RX : std_logic;
    signal RX_VALID : std_logic;
    signal RX_DATA : std_logic_vector(7 downto 0);
    
begin    
    -- Running the simulation for 41 ms and looking at the cols vector will
    -- show what will be displayed on the matrix

    UUT: Matrix_Control
    generic map(FREQ_SYSTEM => 50_000_000, FREQ_LED => 600, FREQ_UART => 9_600)
    port map(CLK => CLK, rows => rows, cols => cols, RX => RX,RX_VALID => RX_VALID,
     RX_DATA => RX_DATA);
    
    -- Process for the artificial clock with a frequency of 50MHz
    CLK_GEN:process
    begin
        CLK <= '1';
        wait for 10 ns;
        CLK <= '0';
        wait for 10 ns;
    end process;
    
    process
    begin
    -- 104 us = 1 cycle for UART baudrate 9600
    
        -- Start off with 1 ms of IDLE mode
        RX <= '1';
        wait for 1 ms;
        
        -- SENDING ROW 1
        -- START BIT
        RX <= '0'; 
        wait for 104 us; 
        -- DATA
        RX <= '1'; -- DATA 0
        wait for 104 us;
        RX <= '1'; -- DATA 1
        wait for 104 us;
        RX <= '1'; -- DATA 2
        wait for 104 us;
        RX <= '0'; -- DATA 3
        wait for 104 us;
        RX <= '1'; -- DATA 4
        wait for 104 us;
        RX <= '1'; -- DATA 5
        wait for 104 us;
        RX <= '1'; -- DATA 6
        wait for 104 us;
        RX <= '0'; -- DATA 7
        wait for 104 us;
        -- STOP BIT + IDLE mode
        RX <= '1';
        wait for 208 us;
        

        
        -- START BIT
        RX <= '0'; 
        wait for 104 us; 
        -- DATA
        RX <= '1'; -- DATA 0
        wait for 104 us;
        RX <= '1'; -- DATA 1
        wait for 104 us;
        RX <= '1'; -- DATA 2
        wait for 104 us;
        RX <= '0'; -- DATA 3
        wait for 104 us;
        RX <= '1'; -- DATA 4
        wait for 104 us;
        RX <= '1'; -- DATA 5
        wait for 104 us;
        RX <= '1'; -- DATA 6
        wait for 104 us;
        RX <= '0'; -- DATA 7
        wait for 104 us;
        -- STOP BIT + IDLE mode
        RX <= '1';
        wait for 208 us;

        
        -- SENDING ROW 2
        -- START BIT
        RX <= '0'; 
        wait for 104 us; 
        -- DATA
        RX <= '0'; -- DATA 0
        wait for 104 us;
        RX <= '1'; -- DATA 1
        wait for 104 us;
        RX <= '0'; -- DATA 2
        wait for 104 us;
        RX <= '0'; -- DATA 3
        wait for 104 us;
        RX <= '1'; -- DATA 4
        wait for 104 us;
        RX <= '0'; -- DATA 5
        wait for 104 us;
        RX <= '0'; -- DATA 6
        wait for 104 us;
        RX <= '0'; -- DATA 7
        wait for 104 us;
        -- STOP BIT + IDLE mode
        RX <= '1';
        wait for 208 us;

        
        -- START BIT
        RX <= '0'; 
        wait for 104 us; 
        -- DATA
        RX <= '1'; -- DATA 0
        wait for 104 us;
        RX <= '0'; -- DATA 1
        wait for 104 us;
        RX <= '0'; -- DATA 2
        wait for 104 us;
        RX <= '0'; -- DATA 3
        wait for 104 us;
        RX <= '0'; -- DATA 4
        wait for 104 us;
        RX <= '1'; -- DATA 5
        wait for 104 us;
        RX <= '0'; -- DATA 6
        wait for 104 us;
        RX <= '0'; -- DATA 7
        wait for 104 us;
        -- STOP BIT + IDLE mode
        RX <= '1';
        wait for 208 us;
        

        
        -- SENDING ROW 3
        -- START BIT
        RX <= '0'; 
        wait for 104 us; 
        -- DATA
        RX <= '0'; -- DATA 0
        wait for 104 us;
        RX <= '1'; -- DATA 1
        wait for 104 us;
        RX <= '0'; -- DATA 2
        wait for 104 us;
        RX <= '0'; -- DATA 3
        wait for 104 us;
        RX <= '1'; -- DATA 4
        wait for 104 us;
        RX <= '0'; -- DATA 5
        wait for 104 us;
        RX <= '0'; -- DATA 6
        wait for 104 us;
        RX <= '0'; -- DATA 7
        wait for 104 us;
        -- STOP BIT + IDLE mode
        RX <= '1';
        wait for 208 us;

        
        -- START BIT
        RX <= '0'; 
        wait for 104 us; 
        -- DATA
        RX <= '1'; -- DATA 0
        wait for 104 us;
        RX <= '0'; -- DATA 1
        wait for 104 us;
        RX <= '0'; -- DATA 2
        wait for 104 us;
        RX <= '0'; -- DATA 3
        wait for 104 us;
        RX <= '0'; -- DATA 4
        wait for 104 us;
        RX <= '1'; -- DATA 5
        wait for 104 us;
        RX <= '0'; -- DATA 6
        wait for 104 us;
        RX <= '0'; -- DATA 7
        wait for 104 us;
        -- STOP BIT + IDLE mode
        RX <= '1';
        wait for 208 us;

        
        -- SENDING ROW 4
        -- START BIT
        RX <= '0'; 
        wait for 104 us; 
        -- DATA
        RX <= '0'; -- DATA 0
        wait for 104 us;
        RX <= '1'; -- DATA 1
        wait for 104 us;
        RX <= '0'; -- DATA 2
        wait for 104 us;
        RX <= '0'; -- DATA 3
        wait for 104 us;
        RX <= '1'; -- DATA 4
        wait for 104 us;
        RX <= '1'; -- DATA 5
        wait for 104 us;
        RX <= '1'; -- DATA 6
        wait for 104 us;
        RX <= '0'; -- DATA 7
        wait for 104 us;
        -- STOP BIT + IDLE mode
        RX <= '1';
        wait for 208 us;
        

        
        -- START BIT
        RX <= '0'; 
        wait for 104 us; 
        -- DATA
        RX <= '1'; -- DATA 0
        wait for 104 us;
        RX <= '1'; -- DATA 1
        wait for 104 us;
        RX <= '1'; -- DATA 2
        wait for 104 us;
        RX <= '0'; -- DATA 3
        wait for 104 us;
        RX <= '0'; -- DATA 4
        wait for 104 us;
        RX <= '1'; -- DATA 5
        wait for 104 us;
        RX <= '0'; -- DATA 6
        wait for 104 us;
        RX <= '0'; -- DATA 7
        wait for 104 us;
        -- STOP BIT + IDLE mode
        RX <= '1';
        wait for 208 us;

        
        -- SENDING ROW 5
        -- START BIT
        RX <= '0'; 
        wait for 104 us; 
        -- DATA
        RX <= '0'; -- DATA 0
        wait for 104 us;
        RX <= '1'; -- DATA 1
        wait for 104 us;
        RX <= '0'; -- DATA 2
        wait for 104 us;
        RX <= '0'; -- DATA 3
        wait for 104 us;
        RX <= '1'; -- DATA 4
        wait for 104 us;
        RX <= '0'; -- DATA 5
        wait for 104 us;
        RX <= '0'; -- DATA 6
        wait for 104 us;
        RX <= '0'; -- DATA 7
        wait for 104 us;
        -- STOP BIT + IDLE mode
        RX <= '1';
        wait for 208 us;
        

        -- START BIT
        RX <= '0'; 
        wait for 104 us; 
        -- DATA
        RX <= '0'; -- DATA 0
        wait for 104 us;
        RX <= '0'; -- DATA 1
        wait for 104 us;
        RX <= '1'; -- DATA 2
        wait for 104 us;
        RX <= '0'; -- DATA 3
        wait for 104 us;
        RX <= '0'; -- DATA 4
        wait for 104 us;
        RX <= '1'; -- DATA 5
        wait for 104 us;
        RX <= '0'; -- DATA 6
        wait for 104 us;
        RX <= '0'; -- DATA 7
        wait for 104 us;
        -- STOP BIT + IDLE mode
        RX <= '1';
        wait for 208 us;

        
        -- SENDING ROW 6
        -- START BIT
        RX <= '0'; 
        wait for 104 us; 
        -- DATA
        RX <= '0'; -- DATA 0
        wait for 104 us;
        RX <= '1'; -- DATA 1
        wait for 104 us;
        RX <= '0'; -- DATA 2
        wait for 104 us;
        RX <= '0'; -- DATA 3
        wait for 104 us;
        RX <= '1'; -- DATA 4
        wait for 104 us;
        RX <= '0'; -- DATA 5
        wait for 104 us;
        RX <= '0'; -- DATA 6
        wait for 104 us;
        RX <= '0'; -- DATA 7
        wait for 104 us;
        -- STOP BIT + IDLE mode
        RX <= '1';
        wait for 208 us;
        

        
        -- START BIT
        RX <= '0'; 
        wait for 104 us; 
        -- DATA
        RX <= '0'; -- DATA 0
        wait for 104 us;
        RX <= '0'; -- DATA 1
        wait for 104 us;
        RX <= '1'; -- DATA 2
        wait for 104 us;
        RX <= '0'; -- DATA 3
        wait for 104 us;
        RX <= '0'; -- DATA 4
        wait for 104 us;
        RX <= '1'; -- DATA 5
        wait for 104 us;
        RX <= '0'; -- DATA 6
        wait for 104 us;
        RX <= '0'; -- DATA 7
        wait for 104 us;
        -- STOP BIT + IDLE mode
        RX <= '1';
        wait for 208 us;
        

        -- SENDING ROW 7
        -- START BIT
        RX <= '0'; 
        wait for 104 us; 
        -- DATA
        RX <= '0'; -- DATA 0
        wait for 104 us;
        RX <= '1'; -- DATA 1
        wait for 104 us;
        RX <= '0'; -- DATA 2
        wait for 104 us;
        RX <= '0'; -- DATA 3
        wait for 104 us;
        RX <= '1'; -- DATA 4
        wait for 104 us;
        RX <= '1'; -- DATA 5
        wait for 104 us;
        RX <= '1'; -- DATA 6
        wait for 104 us;
        RX <= '0'; -- DATA 7
        wait for 104 us;
        -- STOP BIT + IDLE mode
        RX <= '1';
        wait for 208 us;

        
        -- START BIT
        RX <= '0'; 
        wait for 104 us; 
        -- DATA
        RX <= '1'; -- DATA 0
        wait for 104 us;
        RX <= '1'; -- DATA 1
        wait for 104 us;
        RX <= '1'; -- DATA 2
        wait for 104 us;
        RX <= '0'; -- DATA 3
        wait for 104 us;
        RX <= '0'; -- DATA 4
        wait for 104 us;
        RX <= '1'; -- DATA 5
        wait for 104 us;
        RX <= '0'; -- DATA 6
        wait for 104 us;
        RX <= '0'; -- DATA 7
        wait for 104 us;
        -- STOP BIT + IDLE mode
        RX <= '1';
        wait for 208 us;
        

        -- SENDING ROW 8
        -- START BIT
        RX <= '0'; 
        wait for 104 us; 
        -- DATA
        RX <= '0'; -- DATA 0
        wait for 104 us;
        RX <= '0'; -- DATA 1
        wait for 104 us;
        RX <= '0'; -- DATA 2
        wait for 104 us;
        RX <= '0'; -- DATA 3
        wait for 104 us;
        RX <= '0'; -- DATA 4
        wait for 104 us;
        RX <= '0'; -- DATA 5
        wait for 104 us;
        RX <= '0'; -- DATA 6
        wait for 104 us;
        RX <= '0'; -- DATA 7
        wait for 104 us;
        -- STOP BIT + IDLE mode
        RX <= '1';
        wait for 208 us;

        
        -- START BIT
        RX <= '0'; 
        wait for 104 us; 
        -- DATA
        RX <= '0'; -- DATA 0
        wait for 104 us;
        RX <= '0'; -- DATA 1
        wait for 104 us;
        RX <= '0'; -- DATA 2
        wait for 104 us;
        RX <= '0'; -- DATA 3
        wait for 104 us;
        RX <= '0'; -- DATA 4
        wait for 104 us;
        RX <= '0'; -- DATA 5
        wait for 104 us;
        RX <= '0'; -- DATA 6
        wait for 104 us;
        RX <= '0'; -- DATA 7
        wait for 104 us;
        -- STOP BIT + IDLE mode
        RX <= '1';
        wait for 208 us;
        

    wait;
    end process;

end Behavioral;
