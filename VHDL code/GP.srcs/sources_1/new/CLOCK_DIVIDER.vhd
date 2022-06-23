-- libraries
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- define variables and ports
entity CLOCK_DIVIDER is

    -- Create variables
    generic(
    FREQ_IN: natural;
    FREQ_OUT: natural);
    
    -- create signals
    port(
    CLK_IN: in std_logic;
    CLK_OUT: out std_logic;
    ENABLE: in std_logic
    );
    
end CLOCK_DIVIDER;

-- define behavior
architecture Behavioral of CLOCK_DIVIDER is
    signal CLK_INTERNAL: std_logic := '1';
    
begin
    -- The process will activate when
    -- CLK_IN changes value and when
    -- ENABLE changes value
    process(CLK_IN, ENABLE)
        -- The counter we will use to "divide" the input clock
        variable CTR: positive := 0;
        -- The maximum value of our internal counter
        variable CTR_MAX: natural := FREQ_IN/FREQ_OUT;
    begin
        -- Note that we use '1' with quotes
        -- because ENABLE is a signal and not a APPEND_MODE
        if ENABLE = '1' then
            
            if CTR = CTR_MAX then
                 CTR := 0;
                 -- Inverse the state of the internal clock
                 CLK_INTERNAL <= not CLK_INTERNAL;
            
            else
                CLK_INTERNAL <= CLK_INTERNAL;
                CTR := CTR + 1;
            
            end if;
            -- We set the output clock to the internal clock
            -- when the entity is enabled
            CLK_OUT <= CLK_INTERNAL;
        else
            -- When the entity is not enabled,
            -- the internal clock is set to high
            -- and the output clock is set low
            CLK_INTERNAL <= '1';
            CLK_OUT <= '0';
        end if;
        end process;


end architecture Behavioral;









