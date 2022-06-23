library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CLOCK_DIVIDER_TB is
end entity;

architecture Behavioral of CLOCK_DIVIDER_TB is

    -- we need to define the signal
    component CLOCK_DIVIDER is
        generic(
        FREQ_IN: positive;
        FREQ_OUT: positive);
        port(
        CLK_IN: in std_logic;
        CLK_OUT: out std_logic;
        ENABLE: in std_logic);
    end component; 
    
    -- define the signals we will connect to CLOCK_DIVIDER
    signal CLK_IN: std_logic := '0';
    signal CLK_OUT: std_logic := '0';
    signal ENABLE: std_logic := '0';
    
begin

    -- Initialize UUT with the type of CLOCK_DIVIDER
    -- We set the values of the generics,
    -- and connect the entity ports with the signals
    UUT: CLOCK_DIVIDER
    generic map(FREQ_IN => 50_000_000, FREQ_OUT => 115_200)
    port map(CLK_IN, CLK_OUT, ENABLE);
    
    -- Process for the artificial clock with a frequency of 50MHz
    CLK_GEN:process
    begin
        CLK_IN <= '1';
        wait for 10 ns;
        CLK_IN <= '0';
        wait for 10 ns;
    end process;
    
    -- Process where we can simulate logic
    process
    begin
        -- Only enable the clock div after 1 ms in the simulation
        -- The wait statement is only possible in test benches
        wait for 100 ms;
        ENABLE <= '1';
        -- Wait until the end of the simulation
        wait;
    end process;


end architecture  Behavioral;







