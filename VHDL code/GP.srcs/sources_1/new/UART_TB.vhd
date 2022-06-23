library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity UART_TB is
--  Port ( );
end UART_TB;

architecture Behavioral of UART_TB is
    component UART is
        generic(
        CLK_FREQ: positive; 
        BAUDRATE: positive
        );
        port(
        CLK: in std_logic;
        RX: in std_logic;
        RX_VALID: inout std_logic;
        RX_DATA: inout std_logic_vector(7 downto 0);
        test : inout std_logic
        );
    end component;
    
    signal CLK: std_logic := '0';
    signal RX: std_logic := '0';
    signal RX_VALID: std_logic := '0';
    signal RX_DATA: std_logic_vector(7 downto 0) := (others => '0');
    signal test : std_logic := '0';

        
begin
    UUT: UART
    generic map(CLK_FREQ => 50_000_000,BAUDRATE => 9_600)
    port map(CLK => CLK ,RX => RX , RX_VALID => RX_VALID, RX_DATA => RX_DATA, test => test);
    
    CLK_GEN: process
    begin
        CLK <= '1';
        wait for 10 ns;
        CLK <= '0';
        wait for 10 ns;
    end process;

process
begin

    -- Make sure its idle
    RX <= '1';
    wait for 500 us;
    
    -- START BIT
    RX <= '0'; 
    wait for 104 us;
    -- 8 DATA BITS
    RX <= '1';
    wait for 104 us;
    RX <= '0';
    wait for 104 us;
    RX <= '0';
    wait for 104 us;
    RX <= '0';
    wait for 104 us;
    RX <= '0';
    wait for 104 us;
    RX <= '0';
    wait for 104 us;
    RX <= '0';
    wait for 104 us;
    RX <= '1';
    wait for 104 us;
    -- STOP BIT
    RX <= '0';
    wait for 104 us;
    
    RX <= '1';
    
    
    wait;
end process;

end architecture;
