-- libraries
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;


-- define variables and ports
entity Matrix_Control is
    generic(
    FREQ_SYSTEM: positive;
    FREQ_LED: positive;
    FREQ_UART : positive
    );
    Port(
    -- Clock
    CLK: in std_logic;
    
    -- Matrix
    rows : out std_logic_vector(7 downto 0) := (others => '0');
    cols : out std_logic_vector(15 downto 0) := (others => '0');
    
    -- UART
    RX: in std_logic;
    RX_VALID: inout std_logic;
    RX_DATA: inout std_logic_vector(7 downto 0) := (others => '0')
    
    );
end Matrix_Control;

architecture Behavioral of Matrix_Control is
    component CLOCK_DIVIDER is
        generic(
        FREQ_IN: natural;
        FREQ_OUT: natural);
        port(
        CLK_IN : in std_logic;
        CLK_OUT : out std_logic;
        ENABLE : in std_logic);
    end component;

    component UART is
        generic(
        CLK_FREQ: positive;
        BAUDRATE: positive
        );
        port(
        CLK: in std_logic;
        RX: in std_logic := '1';
        RX_VALID: inout std_logic;
        RX_DATA: inout std_logic_vector(7 downto 0)
        );
    end component;
    
    -- LED MATRIX VARIABLES
    type matrix_type is array(0 to 7) of std_logic_vector(15 downto 0); -- create new type : matrix
    signal matrix : matrix_type := (others => (others => '0')); -- create matrix filled with 0
    signal matrix_UART : matrix_type; -- create temp matrix to hold values read through UART
    
    signal CLK_LED : std_logic := '0';
    signal row_counter : integer := 0;
    
    
    signal UART_row_counter : integer := 0;
    signal UART_column_counter : integer := 0;
    signal UART_matrix_filled : integer := 0;
    
    signal DATA : std_logic_vector(7 downto 0);
    
   
begin

    -- Create clock to show LEDs (
    CLK_LED_GEN : CLOCK_DIVIDER
    generic map(FREQ_IN => FREQ_SYSTEM, FREQ_OUT => FREQ_LED)
    port map(CLK_IN => CLK, CLK_OUT => CLK_LED, ENABLE => '1');
    COM_UART : UART
    generic map(CLK_FREQ => FREQ_SYSTEM, BAUDRATE => FREQ_UART)
    port map(CLK => CLK, RX => RX, RX_VALID => RX_VALID, RX_DATA => RX_DATA);
    
    -- Combine 16 bytes received through UART into 1 8x16 bit matrix, 1 byte at a time
    READ_DATA : process(RX_VALID)
    begin
        if  RX_VALID = '1' then
            if UART_row_counter < 7 then
                if UART_column_counter = 0 then
                    DATA <= RX_DATA;
                    UART_column_counter <= 1;
                 else
                    matrix_UART(UART_row_counter)(7 downto 0) <= DATA;
                    matrix_UART(UART_row_counter)(15 downto 8) <= RX_DATA;
                    UART_column_counter <= 0;
                    UART_row_counter <= UART_row_counter + 1;
                end if;
            else     
                if UART_column_counter = 0 then
                    DATA <= RX_DATA;
                    UART_column_counter <= 1;
                else
                    matrix_UART(UART_row_counter)(7 downto 0) <= DATA;
                    matrix_UART(UART_row_counter)(15 downto 8) <= RX_DATA;
                    UART_column_counter <= 0;
                    UART_row_counter <= UART_row_counter + 1;
                    UART_matrix_filled <= 1;           
                end if;
            end if;
        end if;
    end process;
    
    -- If an entire matrix has been read with UART set that matrix to be the display matrix 
    process(UART_matrix_filled)
    begin
        if UART_matrix_filled = 1 then
            matrix <= matrix_UART;
        end if;
    end process;

    -- cycle through all rows in the matrix and illuminate the right LED's
    SHOW_ROW: process(CLK_LED)
    begin
        if rising_edge(CLK_LED) then
            if row_counter < 7 then
                row_counter <= row_counter + 1;  
            else
                row_counter <= 0;
            end if;
        
            cols <= matrix(row_counter); 
            rows <= (others => '0');
            rows(row_counter) <= '1';      
        end if; 
    end process;
    
end Behavioral;
